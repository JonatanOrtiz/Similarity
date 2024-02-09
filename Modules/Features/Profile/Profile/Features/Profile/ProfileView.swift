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
    @StateObject var viewModel: ViewModeling
    @State private var selectedImageIndex = 0

    let mockProfile = AppProfile(
        uid: "hgFDA4A2YMRoFHNuSZvX1VtRgO43",
        email: "jonataneduard@gmail.com",
        base: AppProfile.Base(
            name: "John Doe",
            job: "Software Developer",
            age: "29",
            bornGender: "Male"
        ),
        details: AppProfile.Details(
            graduation: "BSc Computer Science",
            height: 1.75,
            languages: ["English", "Spanish"],
            sign: "Aquarius",
            kids: "None",
            drinks: "Socially",
            smokes: "Never",
            city: "San Francisco"
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
            mentalHealthDisorder: [],
            healthProblems: [],
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
            "https://example.com/image1.jpg",
            "https://example.com/image2.jpg",
            "https://example.com/image3.jpg",
            "https://example.com/image4.jpg",
            "https://example.com/image5.jpg",
            "https://example.com/image6.jpg"
        ]
    )

    @State var chips = [
        ChipData(backgroundColor: .appBlue, icon: .suitcase, text: "Jobription"),
        ChipData(backgroundColor: .appBlue, icon: .pin, text: "JobDescriion"),
        ChipData(backgroundColor: .appBlue, icon: .suitcase, text: "riptn"),
        ChipData(backgroundColor: .appBlue, icon: .suitcase, text: "Joi"),
        ChipData(backgroundColor: .appBlue, icon: .suitcase, text: "Jodi"),
        ChipData(backgroundColor: .appBlue, icon: .suitcase, text: "Jodis"),
        ChipData(backgroundColor: .appBlue, icon: .suitcase, text: "Jobription"),
        ChipData(backgroundColor: .appBlue, icon: .pin, text: "JobDescriion"),
        ChipData(backgroundColor: .appBlue, icon: .suitcase, text: "riptn"),
        ChipData(backgroundColor: .appBlue, icon: .suitcase, text: "Joi"),
        ChipData(backgroundColor: .appBlue, icon: .suitcase, text: "Jod"),
        ChipData(backgroundColor: .appBlue, icon: .suitcase, text: "Jodis"),
        ChipData(backgroundColor: .appBlue, icon: .suitcase, text: "JobDescription")
    ]

    let imageUrls: [AssetImage] = [.someImageExample1, .someImageExample2, .someImageExample3, .someImageExample4, .someImageExample5, .someImageExample6]

    public var body: some View {
        VStack {
            TopItems
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    ImagesCarrousel
                    sectionTitle(title: Strings.Profile.aboutMe)
                    AboutMe
                    sectionTitle(title: Strings.Profile.myDetails)
                    MyDetails
                }
                .padding(.bottom, 60)
            }
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
        }
        .onAppear {
            viewModel.fetchProfile()
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
            Text("I do some modeling jobs.\nIf I don't answer here, follow me on the other network and send me a message and I'll always answer.\n@andr_essa_novais \u{2764}")
                .bodyBold(.white)
                .lineSpacing(7)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(18)
        .flatGlassCard(color: .appPurple)
    }

    var MyDetails: some View {
        LazyVStack(alignment: .leading) {
            ForEach(
                Chip.makeGrids(with: chips, availableWidth: UIScreen.main.bounds.width - 60),
                id: \.self
            ) { grid in
                LazyHGrid(rows: [GridItem(.flexible())]) {
                    ForEach(grid) {
                        Chip(backgroundColor: $0.backgroundColor, icon: $0.icon, text: $0.text)
                    }
                }
            }
        }
        .padding(0, 10, 0, 10)
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
            .padding(25, 15, 5, 0)
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
