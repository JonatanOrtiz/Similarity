//
//  ProfileContentView.swift
//  Profile
//
//  Created by Jonatan Ortiz on 03/08/23.
//

import SwiftUI
import UI
import CoreInterface

public struct ProfileView<ViewModeling>: View where ViewModeling: ProfileViewModeling {
    typealias Localizable = Strings.Profile

    @StateObject var viewModel: ViewModeling
    @State private var selectedImageIndex = 0

    let mockProfile = AppProfile(
        uid: "uniqueUserID123",
        email: "user@example.com",
        base: AppProfile.Base(
            name: "Alex Doe",
            age: "30",
            bornGender: "Non-binary"
        ),
        details: AppProfile.Details(
            aboutMe: "I'm a lover of books and endless conversations. Nature and city life both have their charms that captivate me.",
            job: "Graphic Designer",
            graduation: "MFA in Design",
            city: "New York",
            sign: "Gemini",
            kids: "Open to discussion",
            drinks: "Socially",
            smokes: "Never",
            height: "175 cm",
            languages: ["English", "French"]
        ),
        attributes: AppProfile.Attributes(
            musicGenres: ["Jazz", "Electronic", "Indie Rock"],
            watchingReading: ["Comedy", "Drama", "Science Fiction"],
            gameGenres: ["Puzzle", "Strategy", "Adventure"],
            firstDate: "Whoever invites pays the bill",
            breadwinnerHomemaker: "The couple shares all obligations",
            cleaningRoutines: "Weekly Cleaning",
            hobbiesInterests: ["Reading", "Photography", "Traveling"],
            whenIGoOutILikeTo: ["Visit Art Galleries or Museums", "Enjoy Fine Dining at Restaurants", "Take Scenic Walks or Hikes"],
            foodCuisinePreferences: ["Italian Cuisine", "Japanese Cuisine", "Vegetarian Diet"],
            travel: ["Cultural and Historical Tours", "Adventure and Outdoor Activities", "City Breaks"],
            philosophyOfLife: "Minimalist",
            petPreferences: ["Cats", "Dogs"],
            urbanRural: ["Urban"],
            socialMedia: "Moderate User",
            lifestyle: "Night Owl",
            religion: "Agnosticism",
            socialPreferences: ["Small gatherings", "One-on-one"],
            familyValues: ["Progressive Family Ideals"],
            sexualOrientation: ["Bisexual"],
            genderIdentity: "Non-binary",
            politicalPositioning: "Progressive",
            bodyType: ["Athletic", "Slim or slender"],
            skinColor: "Medium",
            mentalHealthDisorder: ["Anxiety disorders"],
            healthProblems: ["Asthma"],
            clothingStyle: ["Casual", "Vintage or Retro"],
            communicationStyle: ["Text", "In-person"],
            financialManagement: ["Saver", "Budgeter"],
            lifeGoals: ["Career growth", "Personal milestones"],
            environmentalConcerns: ["Recycling proponent", "Green living enthusiast"],
            humorStyle: ["Dry Humor / Deadpan", "Sarcastic Humor"],
            socializingPreferences: ["Small gatherings", "Online communities"],
            futureFamilyPlans: "Wants children",
            personalityTraits: ["Creative", "Analytical", "Compassionate"],
            conflictResolutionStyle: ["Communicative", "Compromising"],
            privacyIndependence: ["Highly independent", "Private space lover"]
        ),
        imageUrls: [
            "https://example.com/image1.jpg",
            "https://example.com/image2.jpg",
            "https://example.com/image3.jpg",
            "https://example.com/image4.jpg",
            "https://example.com/image5.jpg",
            "https://example.com/image6.jpg"
        ]
    )


    let imageUrls: [AssetImage] = [.someImageExample1, .someImageExample2, .someImageExample3, .someImageExample4, .someImageExample5, .someImageExample6]

    public var body: some View {
        VStack {
            TopItems
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    ImagesCarrousel
                    sectionTitle(title: Localizable.aboutMe)
                    AboutMe
                    sectionTitle(title: Localizable.myDetails)
                    makeChips(
                        chips:
                            [
                                ChipData(backgroundColor: .appBlue, text: mockProfile.details.job, sfIcon: .suitcase),
                                ChipData(backgroundColor: .appBlue, text: mockProfile.details.graduation, sfIcon: .graduationcap),
                                ChipData(backgroundColor: .appBlue, text: mockProfile.details.city, sfIcon: .map),
                                ChipData(backgroundColor: .appBlue, text: mockProfile.details.sign, sfIcon: .sparkles),
                                ChipData(backgroundColor: .appBlue, text: mockProfile.details.kids, icon: .baby),
                                ChipData(backgroundColor: .appBlue, text: mockProfile.details.drinks, sfIcon: .wineglass),
                                ChipData(backgroundColor: .appBlue, text: mockProfile.details.smokes, icon: .cigar),
                                ChipData(backgroundColor: .appBlue, text: mockProfile.details.height, icon: .ruler)
                            ]
                    )
                    sectionTitle(title: Localizable.languages)
                    makeChips(chips: mockProfile.details.languages.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.musicGenres)
                    makeChips(chips: mockProfile.attributes.musicGenres.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.watchingReading)
                    makeChips(chips: mockProfile.attributes.watchingReading.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.gameGenres)
                    makeChips(chips: mockProfile.attributes.gameGenres.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.firstDate)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: mockProfile.attributes.firstDate) ])
                    sectionTitle(title: Localizable.breadwinnerHomemaker)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: mockProfile.attributes.breadwinnerHomemaker) ])
                    sectionTitle(title: Localizable.cleaningRoutines)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: mockProfile.attributes.cleaningRoutines) ])
                    sectionTitle(title: Localizable.hobbiesInterests)
                    makeChips(chips: mockProfile.attributes.hobbiesInterests.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.whenIGoOutILikeTo)
                    makeChips(chips: mockProfile.attributes.whenIGoOutILikeTo.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.foodCuisinePreferences)
                    makeChips(chips: mockProfile.attributes.foodCuisinePreferences.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.travel)
                    makeChips(chips: mockProfile.attributes.travel.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.philosophyOfLife)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: mockProfile.attributes.philosophyOfLife) ])
                    sectionTitle(title: Localizable.petPreferences)
                    makeChips(chips: mockProfile.attributes.petPreferences.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.urbanRural)
                    makeChips(chips: mockProfile.attributes.urbanRural.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.socialMedia)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: mockProfile.attributes.socialMedia) ])
                    sectionTitle(title: Localizable.lifestyle)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: mockProfile.attributes.lifestyle) ])
                    sectionTitle(title: Localizable.religion)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: mockProfile.attributes.religion) ])
                    sectionTitle(title: Localizable.socialPreferences)
                    makeChips(chips: mockProfile.attributes.socialPreferences.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.familyValues)
                    makeChips(chips: mockProfile.attributes.familyValues.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.sexualOrientation)
                    makeChips(chips: mockProfile.attributes.sexualOrientation.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.genderIdentity)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: mockProfile.attributes.genderIdentity) ])
                    sectionTitle(title: Localizable.politicalPositioning)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: mockProfile.attributes.politicalPositioning) ])
                    sectionTitle(title: Localizable.bodyType)
                    makeChips(chips: mockProfile.attributes.bodyType.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.skinColor)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: mockProfile.attributes.skinColor) ])
                    sectionTitle(title: Localizable.mentalHealthDisorder)
                    makeChips(chips: mockProfile.attributes.mentalHealthDisorder.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.healthProblems)
                    makeChips(chips: mockProfile.attributes.healthProblems.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.clothingStyle)
                    makeChips(chips: mockProfile.attributes.clothingStyle.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.communicationStyle)
                    makeChips(chips: mockProfile.attributes.communicationStyle.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.financialManagement)
                    makeChips(chips: mockProfile.attributes.financialManagement.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.lifeGoals)
                    makeChips(chips: mockProfile.attributes.lifeGoals.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.environmentalConcerns)
                    makeChips(chips: mockProfile.attributes.environmentalConcerns.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.humorStyle)
                    makeChips(chips: mockProfile.attributes.humorStyle.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.socializingPreferences)
                    makeChips(chips: mockProfile.attributes.socializingPreferences.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.futureFamilyPlans)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: mockProfile.attributes.futureFamilyPlans) ])
                    sectionTitle(title: Localizable.personalityTraits)
                    makeChips(chips: mockProfile.attributes.personalityTraits.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.conflictResolutionStyle)
                    makeChips(chips: mockProfile.attributes.conflictResolutionStyle.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.privacyIndependence)
                    makeChips(chips: mockProfile.attributes.privacyIndependence.map { ChipData(backgroundColor: .appPurple, text: $0) })
                }
                .padding(.bottom, 60)
            }
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
        }
        .onAppear {
            //            viewModel.fetchProfile()
        }
        .backgroundImage()
        .errorBottomSheet(
            customError: $viewModel.error,
            primaryButton: .init(title: Strings.Common.ok) {
                viewModel.error = nil
            },
            secondaryButton: .init(title: Strings.Common.tryAgain) {
                viewModel.error = nil
                viewModel.tryAgainAction?()
            }
        )
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
                .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.appBlue, .appPurple]), startPoint: .leading, endPoint: .trailing))
            Spacer()
            Image(systemName: "equal.circle")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.primaryColor)
                .padding(.trailing)
        }
    }

    var ImagesCarrousel: some View {
        TabView(selection: $selectedImageIndex) {
            ForEach(0..<imageUrls.count, id: \.self) { index in
                ImageContainerView(
                    image: imageUrls[index],
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
            Text("\(viewModel.profile?.base.name ?? "Error"), \(viewModel.profile?.base.age ?? "Error")")
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
            Text(mockProfile.details.aboutMe)
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
        let image: AssetImage
        var onTapLeft: () -> Void
        var onTapRight: () -> Void

        var body: some View {
            GeometryReader { geometry in
                Image.assetImage(image)
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
}

// MARK: - Previews
struct ProfileContentView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewDependencyOrchestrator.start()
        return ProfileView(viewModel: ProfileViewModel(dependencies: DependencyContainer()))
            .environment(\.locale, .init(identifier: "pt-BR"))
    }
}
