//
//  ProfileContentView.swift
//  Profile
//
//  Created by Jonatan Ortiz on 03/08/23.
//

import SwiftUI
import UI

public struct ProfileLoadingView<ViewModeling>: View where ViewModeling: ProfileViewModeling {
    typealias Localizable = Strings.Profile

    @StateObject var viewModel: ViewModeling

    public var body: some View {
        Group {
            if viewModel.isLoading {
                LoadingView()
            } else if let profile = viewModel.profile {
                ProfileView(profile: profile)
            } else if let error = viewModel.error {
                ErrorView(
                    title: error.title,
                    message: error.message,
                    secondaryButton: ErrorViewButton(
                        title: Strings.ProfileErrorView.button,
                        action: {
                            viewModel.fetchProfile()
                        })
                )
            }
        }
        .onAppear {
            if viewModel.isLoading {
                viewModel.fetchProfile()
            }
        }
        .backgroundImage()
    }
}

// MARK: - ProfileView
struct ProfileView: View {
    typealias Localizable = Strings.Profile

    @State private var selectedImageIndex = 0
    private let profile: AppProfile

    private var detailsChips: [ChipData] {
        var chips: [ChipData] = []
        let nonOptionalDetailsChips = [
            ChipData(backgroundColor: .appBlue, text: profile.details.city, sfIcon: .map),
            ChipData(backgroundColor: .appBlue, text: profile.details.sign, sfIcon: .sparkles),
            ChipData(backgroundColor: .appBlue, text: profile.details.kids, icon: .baby),
            ChipData(backgroundColor: .appBlue, text: profile.details.drinks, sfIcon: .wineglass),
            ChipData(backgroundColor: .appBlue, text: profile.details.smokes, icon: .cigar),
            ChipData(backgroundColor: .appBlue, text: profile.details.height, icon: .ruler)
        ]
        if let job = profile.details.job {
            chips.append(ChipData(backgroundColor: .appBlue, text: job, sfIcon: .suitcase))
        }
        if let graduation = profile.details.graduation {
            chips.append(ChipData(backgroundColor: .appBlue, text: graduation, sfIcon: .graduationcap))
        }
        chips.append(contentsOf: nonOptionalDetailsChips)
        return chips
    }

    init(profile: AppProfile) {
        self.profile = profile
    }

    var body: some View {
        VStack {
            TopItems
            ScrollView(showsIndicators: false) {
                VStack {
                    ImagesCarrousel
                    EditProfileButton
                    AboutMe
                    Details
                    Attributes
                }
                .padding(.bottom, 60)
            }
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
        }
    }
}

// MARK: - View Properties
extension ProfileView {
    var TopItems: some View {
        HStack {
            Image.assetSFSymbol(.listBullet, color: .primaryColor, font: .system(size: 20, weight: .bold))
                .padding(.leading)
            Spacer()
            Text("Similarity")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.appPurple, .appBlue]), startPoint: .leading, endPoint: .trailing))
            Spacer()
            Image.assetSFSymbol(.equalCircle, color: .primaryColor, font: .system(size: 20, weight: .bold))
                .padding(.trailing)
        }
    }

    var ImagesCarrousel: some View {
        TabView(selection: $selectedImageIndex) {
            ForEach(0..<profile.imageUrls.count, id: \.self) { index in
                AsyncImage(url: URL(string: profile.imageUrls[index])) { image in
                    ImageContainerView(
                        image: image,
                        onTapLeft: {
                            if selectedImageIndex > 0 {
                                selectedImageIndex -= 1
                            }
                        },
                        onTapRight: {
                            if selectedImageIndex < profile.imageUrls.count - 1 {
                                selectedImageIndex += 1
                            }
                        })
                    .tag(index)
                    .overlay {
                        LinearGradient(
                            gradient: Gradient(colors: [.black, .black, .clear, .clear, .clear]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                        .opacity(0.5)
                    }
                } placeholder: {
                    ProgressView()
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .frame(height: UIScreen.main.bounds.height / 1.5)
        .cornerRadius(20)
        .padding(0, 10, 0, 10)
        .overlay(alignment: .bottomLeading) {
            ProfileDataView
        }
    }

    var ProfileDataView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(profile.base.name), \(profile.base.age)")
                .secondaryTitleBold(.white)
            HStack {
                Image.assetIcon(.pin)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                Text("10 km")
                    .calloutBold(.white)
            }
        }
        .allowsHitTesting(false)
        .padding(0, 10, 1, 0)
        .padding()
    }

    var EditProfileButton: some View {
        FlatGlassButton(
            text: Strings.Profile.edit,
            backgroundColor: .appPink,
            horizontalPadding: 50
        ) {
            print("")
        }
        .padding(.top, 25)
    }

    var AboutMe: some View {
        VStack(alignment: .leading) {
            sectionTitle(title: Localizable.aboutMe)
            VStack(alignment: .leading, spacing: 15) {
                Text(profile.details.aboutMe)
                    .bodyBold(.white)
                    .lineSpacing(7)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(18)
            .flatGlassCard(color: .appPurple)
        }
    }

    var Details: some View {
        VStack(alignment: .leading) {
            sectionTitle(title: Localizable.myDetails)
            makeChips(chips: detailsChips)
        }
    }

    var Attributes: some View {
        VStack(alignment: .leading) {
            makeSection(title: Localizable.languages, attributes: profile.details.languages)
            makeSection(title: Localizable.musicGenres, attributes: profile.attributes.musicGenres)
            makeSection(title: Localizable.watchingReading, attributes: profile.attributes.watchingReading)
            makeSection(title: Localizable.gameGenres, attributes: profile.attributes.gameGenres)
            makeSection(title: Localizable.firstDate, attribute: profile.attributes.firstDate)
            makeSection(title: Localizable.breadwinnerHomemaker, attribute: profile.attributes.breadwinnerHomemaker)
            makeSection(title: Localizable.cleaningRoutines, attribute: profile.attributes.cleaningRoutines)
            makeSection(title: Localizable.hobbiesInterests, attributes: profile.attributes.hobbiesInterests)
            makeSection(title: Localizable.whenIGoOutILikeTo, attributes: profile.attributes.whenIGoOutILikeTo)
            makeSection(title: Localizable.foodCuisinePreferences, attributes: profile.attributes.foodCuisinePreferences)
            makeSection(title: Localizable.travel, attributes: profile.attributes.travel)
            makeSection(title: Localizable.philosophyOfLife, attribute: profile.attributes.philosophyOfLife)
            makeSection(title: Localizable.petPreferences, attributes: profile.attributes.petPreferences)
            makeSection(title: Localizable.urbanRural, attributes: profile.attributes.urbanRural)
            makeSection(title: Localizable.socialMedia, attribute: profile.attributes.socialMedia)
            makeSection(title: Localizable.lifestyle, attribute: profile.attributes.lifestyle)
            makeSection(title: Localizable.religion, attribute: profile.attributes.religion)
            makeSection(title: Localizable.socialPreferences, attributes: profile.attributes.socialPreferences)
            makeSection(title: Localizable.familyValues, attributes: profile.attributes.familyValues)
            makeSection(title: Localizable.sexualOrientation, attributes: profile.attributes.sexualOrientation)
            makeSection(title: Localizable.genderIdentity, attribute: profile.attributes.genderIdentity)
            makeSection(title: Localizable.politicalPositioning, attribute: profile.attributes.politicalPositioning)
            makeSection(title: Localizable.bodyType, attributes: profile.attributes.bodyType)
            makeSection(title: Localizable.skinColor, attribute: profile.attributes.skinColor)
            makeSection(title: Localizable.mentalHealthDisorder, attributes: profile.attributes.mentalHealthDisorder)
            makeSection(title: Localizable.healthProblems, attributes: profile.attributes.healthProblems)
            makeSection(title: Localizable.clothingStyle, attributes: profile.attributes.clothingStyle)
            makeSection(title: Localizable.communicationStyle, attributes: profile.attributes.communicationStyle)
            makeSection(title: Localizable.financialManagement, attributes: profile.attributes.financialManagement)
            makeSection(title: Localizable.lifeGoals, attributes: profile.attributes.lifeGoals)
            makeSection(title: Localizable.environmentalConcerns, attributes: profile.attributes.environmentalConcerns)
            makeSection(title: Localizable.humorStyle, attributes: profile.attributes.humorStyle)
            makeSection(title: Localizable.socializingPreferences, attributes: profile.attributes.socializingPreferences)
            makeSection(title: Localizable.futureFamilyPlans, attribute: profile.attributes.futureFamilyPlans)
            makeSection(title: Localizable.personalityTraits, attributes: profile.attributes.personalityTraits)
            makeSection(title: Localizable.conflictResolutionStyle, attributes: profile.attributes.conflictResolutionStyle)
            makeSection(title: Localizable.privacyIndependence, attributes: profile.attributes.privacyIndependence)
        }
    }
}

// MARK: - Structs
extension ProfileView {
    struct ImageContainerView: View {
        let image: Image
        var onTapLeft: () -> Void
        var onTapRight: () -> Void

        var body: some View {
            GeometryReader { geometry in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .onTapGesture { location in
                        if location.x < geometry.size.width / 2 {
                            onTapLeft()
                        } else {
                            onTapRight()
                        }
                    }
            }
        }
    }
}

// MARK: - Methods
extension ProfileView {
    func sectionTitle(title: String) -> some View {
        Text.localized(LocalizedStringKey(title))
            .secondaryTitleBold(.primaryColor)
            .fixedSize(horizontal: false, vertical: true)
            .padding(25, 15, 5, 15)
    }

    func makeChips(chips: [ChipData]) -> some View {
        LazyVStack(alignment: .leading) {
            ForEach(
                Chip.makeGrids(with: chips, availableWidth: UIScreen.main.bounds.width - 60),
                id: \.self
            ) { grid in
                LazyHGrid(rows: [GridItem(.flexible())]) {
                    ForEach(grid) {
                        Chip(backgroundColor: $0.backgroundColor, text: $0.text, icon: $0.icon, sfIcon: $0.sfIcon)
                    }
                }
            }
        }
        .padding(0, 15, 0, 15)
    }

    func makeSection(title: String, attribute: String? = nil, attributes: [String]? = nil) -> some View {
        VStack(alignment: .leading) {
            sectionTitle(title: title)
            if let attribute {
                makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: attribute) ])
            }
            if let attributes {
                makeChips(chips: attributes.map { ChipData(backgroundColor: .appPurple, text: $0) })
            }
        }
    }
}

// MARK: - ProfileLoadingView Previews
#Preview {
    PreviewDependencyOrchestrator.start()
    return ProfileLoadingView(viewModel: ProfileViewModel(dependencies: DependencyContainer()))
        .environment(\.locale, .init(identifier: "pt-BR"))
}

// MARK: - ProfileView Previews
#Preview {
    PreviewDependencyOrchestrator.start()
    return ProfileView(profile: AppProfile.fixture())
        .backgroundImage()
        .environment(\.locale, .init(identifier: "pt-BR"))
}
