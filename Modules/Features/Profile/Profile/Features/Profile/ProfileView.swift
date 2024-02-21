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
            } else if viewModel.error != nil {
                errorView()
            }
        }
        .onAppear {
            if viewModel.isLoading {
                viewModel.fetchProfile()
            }
        }
        .backgroundImage()
    }

    // create later
    private func errorView() -> some View {
        VStack {
            Spacer()
            Text("An error occurred while fetching the profile.")
                .foregroundColor(.red)
            Spacer()
            Button("Try Again") {
                viewModel.fetchProfile()
            }
            Spacer()
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

    let imageUrls: [AssetImage] = [.someImageExample1, .someImageExample2, .someImageExample3, .someImageExample4, .someImageExample5, .someImageExample6]

    init(profile: AppProfile) {
        self.profile = profile
    }

    var body: some View {
        VStack {
            TopItems
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    ImagesCarrousel
                    sectionTitle(title: Localizable.aboutMe)
                    AboutMe
                    sectionTitle(title: Localizable.myDetails)
                    makeChips(chips: detailsChips)
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
            Image(systemName: "list.bullet")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primaryColor)
                .padding(.leading)
            Spacer()
            Text("Similarity")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.appPurple, .appBlue]), startPoint: .leading, endPoint: .trailing))
            Spacer()
            Image(systemName: "equal.circle")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primaryColor)
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
                            if selectedImageIndex < imageUrls.count - 1 {
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

    var AboutMe: some View {
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
 struct ProfileLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewDependencyOrchestrator.start()
        return ProfileLoadingView(viewModel: ProfileViewModel(dependencies: DependencyContainer()))
            .environment(\.locale, .init(identifier: "pt-BR"))
    }
 }

// MARK: - ProfileView Previews
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewDependencyOrchestrator.start()
        return ProfileView(profile: mockProfile)
            .backgroundImage()
            .environment(\.locale, .init(identifier: "pt-BR"))
    }
}

let mockProfile = AppProfile(
    uid: "hgFDA4A2YMRoFHNuSZvX1VtRgO43",
    email: "jonataneduard@gmail.com",
    base: AppProfile.Base(
        name: "John Doe",
        age: "29",
        bornGender: "Male"
    ),
    details: AppProfile.Details(
        aboutMe: "I do some modeling jobs.\nIf I don't answer here, follow me on the other network and send me a message and I'll always answer.\n@andr_essa_novais \u{2764}",
        city: "San Francisco",
        sign: "Aquarius",
        kids: "Don't Want",
        drinks: "Socially",
        smokes: "Never",
        height: "165 cm",
        languages: ["English", "Spanish"],
        job: "Psychologist",
        graduation: "Psychology"
    ),
    attributes: AppProfile.Attributes(
        musicGenres: ["Rock", "Classical", "Jazz"],
        watchingReading: ["Sci-Fi", "Fantasy", "Non-fiction"],
        gameGenres: ["Strategy", "Puzzle", "Adventure"],
        firstDate: "Coffee shop",
        breadwinnerHomemaker: "Equal partnership",
        cleaningRoutines: "Weekly",
        hobbiesInterests: ["Hiking", "Coding", "Traveling"],
        whenIGoOutILikeTo: ["Explore new restaurants", "Visit museums", "Go to concerts"],
        foodCuisinePreferences: ["Italian", "Mexican", "Japanese"],
        travel: ["Beach", "City", "Countryside"],
        philosophyOfLife: "Live and let live",
        petPreferences: ["Dogs", "Cats"],
        urbanRural: ["Urban"],
        socialMedia: "Minimal use",
        lifestyle: "Active",
        religion: "Agnostic",
        socialPreferences: ["Small gatherings", "One-on-one"],
        familyValues: ["Close-knit"],
        sexualOrientation: ["Straight"],
        genderIdentity: "Cisgender",
        politicalPositioning: "Moderate",
        bodyType: ["Athletic"],
        skinColor: "Medium",
        mentalHealthDisorder: ["Anxiety disorders"],
        healthProblems: ["I have no health problems"],
        clothingStyle: ["Casual", "Smart casual"],
        communicationStyle: ["Open", "Honest"],
        financialManagement: ["Saver", "Investor"],
        lifeGoals: ["Career success", "Travel"],
        environmentalConcerns: ["Recycling", "Conservation"],
        humorStyle: ["Sarcastic", "Dry"],
        socializingPreferences: ["Bars", "Home gatherings"],
        futureFamilyPlans: "Open to possibilities",
        personalityTraits: ["Thoughtful", "Analytical"],
        conflictResolutionStyle: ["Discussion", "Compromise"],
        privacyIndependence: ["Valued", "Respected"]
    ),
    imageUrls: [
        "https://i.pinimg.com/736x/5e/50/a5/5e50a55755f443649181f76a90ee4aa7.jpg",
        "https://i.pinimg.com/736x/18/85/2c/18852c7db70d38a00a9a5534eab2c869.jpg",
        "https://i.pinimg.com/736x/4d/bf/71/4dbf71b50ab6ad7bff3a1c7232533a5e.jpg",
        "https://i.pinimg.com/736x/78/9f/53/789f53dafa9752275504d0f3c3067073.jpg",
        "https://i.pinimg.com/originals/24/81/40/248140144a26042c0e4fa9b413e96090.jpg",
        "https://i.pinimg.com/474x/4e/d3/e3/4ed3e327d5c81bb1ca07d8f86216df2d.jpg"
    ]
)
