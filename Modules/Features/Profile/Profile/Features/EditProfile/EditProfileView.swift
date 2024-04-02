//
//  EditProfileView.swift
//  Profile
//
//  Created by Jonatan Ortiz on 22/02/24.
//

import SwiftUI
import Combine
import UI

private typealias Localizable = Strings.EditProfile

struct EditProfileView<ViewModeling>: View where ViewModeling: EditProfileViewModeling {
    @StateObject var viewModel: ViewModeling
    @State private var isPresentingCityPicker = false
    @State private var selectedCity: String?

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                PhotoGridView()
                sectionTitle(title: Localizable.city)
                CityView
                sectionTitle(title: Localizable.languages)
                LanguagesView()
                sectionTitle(title: Localizable.aboutMe)
                AboutMeTextField
                sectionTitle(title: Localizable.myDetails)
                CustomTextField(
                    text: binding(for: $viewModel.profile.details.job),
                    placeholder: Localizable.jobTextField,
                    backgroundColor: .secondaryPurple
                )
                .padding(10, 15, 0, 15)
                CustomTextField(
                    text: binding(for: $viewModel.profile.details.graduation),
                    placeholder: Localizable.graduationTextField,
                    backgroundColor: .secondaryPurple
                )
                .padding(10, 15, 0, 15)
            }
        }
        .backgroundImage()
    }

    var CityView: some View {
        Text(selectedCity ?? viewModel.profile.details.city)
            .foregroundColor(.primaryColor)
            .onTapGesture {
                isPresentingCityPicker = true
            }
            .customBottomSheet(isPresented: $isPresentingCityPicker, height: screenHeight / 2) {
                CityPickerView(isPresenting: $isPresentingCityPicker, selectedCity: $selectedCity)
            }
            .frame(
                width: min((selectedCity ?? viewModel.profile.details.city).widthOfString(usingFont: .systemFont(ofSize: 17)),
                screenWidth - 60),
                height: 40
            )
            .padding(5, 15, 5, 15)
            .background(Color.secondaryPurple)
            .cornerRadius(15)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.primaryColor, lineWidth: 1)
            )
            .padding(10, 15, -5, 15)
    }
}

// MARK: - UI Properties
extension EditProfileView {
    private var AboutMeTextField: some View {
        let characterLimit = 200

        return VStack(alignment: .trailing) {
            TextEditor(text: $viewModel.profile.details.aboutMe)
                .onReceive(Just(viewModel.profile.details.aboutMe)) { _ in
                    limitText(characterLimit)
                }
                .disableAutocorrection(true)
                .padding(10)
                .scrollContentBackground(.hidden)
                .background(Color.secondaryPurple)
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.primaryColor, lineWidth: 1)
                )
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button(action: {
                            hideKeyboard()
                        }, label: {
                            Text(Localizable.Keyboard.doneButton)
                                .calloutBold()
                            Image
                                .assetSFSymbol(
                                    .checkmarkCircle, color: .primaryColor, font: .system(size: 14)
                                )
                        })
                    }
                }
            Text("\(characterLimit - viewModel.profile.details.aboutMe.count)")
                .foregroundColor(.gray)
                .padding(.trailing, 5)
        }
        .padding(10, 15, 0, 15)
    }
}

// MARK: - Methods
extension EditProfileView {
    private func sectionTitle(title: String) -> some View {
        Text.localized(LocalizedStringKey(title))
            .secondaryTitleBold(.primaryColor)
            .fixedSize(horizontal: false, vertical: true)
            .padding(25, 15, 5, 15)
    }

    private func hideKeyboard() {
        UIApplication
            .shared
            .sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

    private func limitText(_ upper: Int) {
        if viewModel.profile.details.aboutMe.count > upper {
            viewModel.profile.details.aboutMe = String(viewModel.profile.details.aboutMe.prefix(upper))
        }
    }

    private func binding(for optionalString: Binding<String?>) -> Binding<String> {
        Binding<String>(
            get: { optionalString.wrappedValue ?? String() },
            set: { newValue in optionalString.wrappedValue = newValue.isEmpty ? nil : newValue }
        )
    }
}

// MARK: - PhotoGridView
extension EditProfileView {
    struct PhotoGridView: View {
        @State private var photos: [Photo] = []
        @State private var showingImagePicker = false
        @State private var showingImageCropper = false
        @State private var imageToCrop: UIImage?
        @State private var activePhotoId: UUID?
        @State private var replacementIndex: Int?

        private let maxPhotos = 6
        private let size = UIScreen.main.bounds.width / 3 - 20

        var body: some View {
            VStack {
                LazyVGrid(
                    columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())],
                    spacing: 10
                ) {
                    ForEach(0..<maxPhotos, id: \.self) { index in
                        if index < photos.count {
                            imageForPhoto(index, size)
                                .onDrag {
                                    self.activePhotoId = photos[index].id
                                    return NSItemProvider(object: String(photos[index].id.uuidString) as NSString)
                                }
                                .onDrop(
                                    of: [.text],
                                    delegate: PhotoDropDelegate(
                                        currentPhoto: photos[index],
                                        photos: $photos,
                                        activePhotoId: $activePhotoId
                                    )
                                )
                        }
                    }
                    ForEach(0..<(maxPhotos - photos.count), id: \.self) { _ in
                        addButtonOrPlaceholder(size)
                    }
                }
                .cropImagePicker(show: $showingImagePicker) { selectedImage in
                    let newPhoto = Photo(image: selectedImage)
                    if let replacementIndex = replacementIndex, replacementIndex < photos.count {
                        photos[replacementIndex] = newPhoto
                    } else if photos.count < maxPhotos {
                        self.photos.append(newPhoto)
                    }
                }
                .animation(.default, value: photos)
                .padding()
            }
        }

        private func imageForPhoto(_ index: Int, _ size: CGFloat) -> some View {
            photos[index].image
                .resizable()
                .scaledToFill()
                .frame(width: size, height: size * 1.5)
                .clipped()
                .cornerRadius(20)
                .onTapGesture {
                    self.replacementIndex = index
                    self.showingImagePicker = true
                }
                .overlay(alignment: .topTrailing) {
                    Button(action: {
                        withAnimation {
                            var newPhotos = photos
                            newPhotos.remove(at: index)
                            photos = newPhotos
                        }
                    }) {
                        Image.assetSFSymbol(.xMarkCircleFill, color: .gray)
                            .padding(10)
                    }
                }
        }

        private func addButtonOrPlaceholder(_ size: CGFloat) -> some View {
            Button(action: {
                self.replacementIndex = nil
                showingImagePicker = true
            }) {
                Image.assetSFSymbol(.plusCircleFill, color: .gray, font: .largeTitle)
            }
            .frame(width: size, height: size * 1.5)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(20)
        }
    }
}

// MARK: - PhotoDropDelegate
extension EditProfileView {
    struct PhotoDropDelegate: DropDelegate {
        let currentPhoto: Photo
        @Binding var photos: [Photo]
        @Binding var activePhotoId: UUID?

        func performDrop(info: DropInfo) -> Bool {
            guard let activePhotoId = activePhotoId,
                  let sourceIndex = photos.firstIndex(where: { $0.id == activePhotoId }),
                  let targetIndex = photos.firstIndex(where: { $0.id == currentPhoto.id })
            else {
                return false
            }

            if sourceIndex != targetIndex {
                withAnimation {
                    photos.move(
                        fromOffsets: IndexSet(integer: sourceIndex),
                        toOffset: targetIndex > sourceIndex ? targetIndex + 1 : targetIndex
                    )
                }
            }

            return true
        }
    }
}

// MARK: - LanguagesView
extension EditProfileView {
    struct LanguagesView: View {
        @State private var selectedLanguages: [String] = []

        let maxLanguages = 5

        let languages: [String] = {
            var seenNames = Set<String>()
            return Locale.availableIdentifiers.compactMap { identifier in
                let locale = Locale(identifier: identifier)
                guard let languageCode = Locale(identifier: identifier).language.languageCode?.identifier,
                      let languageName = locale.localizedString(forLanguageCode: languageCode),
                      !seenNames.contains(languageName) else { return nil }
                seenNames.insert(languageName)
                return languageName.capitalized
            }
            .sorted { $0 < $1 }
        }()

        var PlusButtonMenu: some View {
            Menu {
                ForEach(languages, id: \.self) { language in
                    Button(language) {
                        addLanguage(language)
                    }
                }
            } label: {
                Image.assetSFSymbol(.plusCircleFill, color: .gray, font: .largeTitle)
            }
        }

        var body: some View {
            LazyVStack(alignment: .leading) {
                let grids = makeGrids(with: selectedLanguages, availableWidth: screenWidth - 80)
                let totalGrids = grids.count

                if totalGrids > 0 {
                    ForEach(Array(grids.enumerated()), id: \.element.self) { gridIndex, languageDataArray in
                        LazyHGrid(rows: [GridItem(.flexible())]) {
                            ForEach(Array(languageDataArray.enumerated()), id: \.element) { rowIndex, language in
                                Picker(Localizable.languages, selection: getLanguageBinding(for: language.language)) {
                                    ForEach(languages, id: \.self) { pickerLanguage in
                                        Text(pickerLanguage)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .accentColor(.appWhite)
                                .foregroundColor(.appWhite)
                                .background(Color.appBlue)
                                .cornerRadius(15)

                                if gridIndex == totalGrids - 1 && rowIndex == languageDataArray.count - 1 && selectedLanguages.count < maxLanguages {
                                    PlusButtonMenu
                                }
                            }
                        }
                    }
                }
                if selectedLanguages.isEmpty {
                    PlusButtonMenu
                        .padding(.top, -22)
                }
            }
            .padding(15, 10, 0, 10)
        }

        func getLanguageBinding(for language: String) -> Binding<String> {
            Binding(
                get: {
                    language
                },
                set: { newValue in
                    if selectedLanguages.contains(newValue) {
                        selectedLanguages.removeAll { $0 == newValue }
                    } else {
                        if let index = selectedLanguages.firstIndex(of: language) {
                            selectedLanguages[index] = newValue
                        }
                    }
                }
            )
        }

        func addLanguage(_ language: String) {
            if !selectedLanguages.contains(language) {
                selectedLanguages.append(language)
            }
        }

        func makeGrids(with languages: [String], availableWidth: CGFloat) -> [[LanguageData]] {
            var grids: [[LanguageData]] = [[]]
            var currentWidth: CGFloat = 0

            for language in languages {
                let languageWidth = language.widthOfString(usingFont: .systemFont(ofSize: 17)) + 40
                if currentWidth + languageWidth > availableWidth {
                    grids.append([LanguageData(language: language)])
                    currentWidth = languageWidth
                } else {
                    grids[grids.count - 1].append(LanguageData(language: language))
                    currentWidth += languageWidth
                }
            }
            return grids
        }
    }
}

import MapKit

// MARK: - CityPickerView
extension EditProfileView {
    struct CityPickerView: View {
        @ObservedObject var citySearchCompleter = CitySearchCompleter()
        @State private var searchText = String()
        @Binding var isPresenting: Bool
        @Binding var selectedCity: String?

        var body: some View {
            NavigationView {
                List(citySearchCompleter.suggestions, id: \.self) { suggestion in
                    Text(suggestion.title).onTapGesture {
                        self.selectedCity = suggestion.title
                        self.isPresenting = false
                    }
                }
                .navigationBarTitle(Text(Localizable.citySearch), displayMode: .inline)
                .searchable(text: $searchText)
                .onChange(of: searchText) { newValue in
                    citySearchCompleter.searchQuery(newValue)
                }
            }
        }
    }
}

class CitySearchCompleter: NSObject, ObservableObject, MKLocalSearchCompleterDelegate {
    @Published var suggestions: [MKLocalSearchCompletion] = []

    private var searchCompleter: MKLocalSearchCompleter

    override init() {
        self.searchCompleter = MKLocalSearchCompleter()
        super.init()
        self.searchCompleter.resultTypes = .address
        self.searchCompleter.delegate = self
    }

    func searchQuery(_ query: String) {
        searchCompleter.queryFragment = query
    }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        DispatchQueue.main.async {
            self.suggestions = completer.results
        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
}

// MARK: - Models
extension EditProfileView {
    struct Photo: Identifiable, Equatable {
        let id: UUID
        var image: Image

        init(image: Image, id: UUID = UUID()) {
            self.id = id
            self.image = image
        }
    }

    struct LanguageData: Identifiable, Hashable {
        let id: UUID
        var language: String

        init(language: String, id: UUID = UUID()) {
            self.id = id
            self.language = language
        }
    }
}

// MARK: - Preview
#Preview {
    PreviewDependencyOrchestrator.start()
    return EditProfileView(viewModel: EditProfileViewModel(profile: AppProfile.fixture(), dependencies: DependencyContainer()))
}
