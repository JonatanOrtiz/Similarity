//
//  EditProfileView.swift
//  Profile
//
//  Created by Jonatan Ortiz on 22/02/24.
//

import SwiftUI
import Combine
import UI

struct EditProfileView<ViewModeling>: View where ViewModeling: EditProfileViewModeling {
    typealias Localizable = Strings.EditProfile

    @StateObject var viewModel: ViewModeling

    let characterLimit = 200

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

    @State private var selectedLanguages: [String] = []

    let maxLanguages = 5

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                PhotoGridView()
                sectionTitle(title: Localizable.languages)

                ForEach(selectedLanguages, id: \.self) { selectedLanguage in
                    Picker(Localizable.languages, selection: getLanguageBinding(for: selectedLanguage)) {
                        ForEach(languages, id: \.self) { language in
                            Text(language)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .accentColor(.white)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(5)
                }

                if selectedLanguages.count < maxLanguages {
                    Menu {
                        ForEach(languages, id: \.self) { language in
                            Button(language) {
                                addLanguage(language)
                            }
                        }
                    } label: {
                        Label("Add Language", systemImage: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    }
                    .frame(width: 50, height: 50)
                }

                sectionTitle(title: Localizable.aboutMe)
                AboutMeTextField
                sectionTitle(title: Localizable.myDetails)
                CustomTextField(
                    text: binding(for: $viewModel.profile.details.job),
                    placeholder: Localizable.jobTextField,
                    backgroundColor: .white.opacity(0.2)
                )
                .padding(10, 15, 0, 15)
                CustomTextField(
                    text: binding(for: $viewModel.profile.details.graduation),
                    placeholder: Localizable.graduationTextField,
                    backgroundColor: .white.opacity(0.2)
                )
                .padding(10, 15, 0, 15)
            }
        }
        .backgroundImage()
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

    private var AboutMeTextField: some View {
        VStack(alignment: .trailing) {
            TextEditor(text: $viewModel.profile.details.aboutMe)
                .onReceive(Just(viewModel.profile.details.aboutMe)) { _ in
                    limitText(characterLimit)
                }
                .disableAutocorrection(true)
                .padding(10)
                .scrollContentBackground(.hidden)
                .background(.white.opacity(0.2))
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
        .padding(.horizontal, 15)
    }

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

// MARK: - Photo
extension EditProfileView {
    struct Photo: Identifiable, Equatable {
        let id: UUID
        var image: Image

        init(image: Image, id: UUID = UUID()) {
            self.id = id
            self.image = image
        }
    }
}

// MARK: - Preview
#Preview {
    PreviewDependencyOrchestrator.start()
    return EditProfileView(viewModel: EditProfileViewModel(profile: AppProfile.fixture(), dependencies: DependencyContainer()))
}
