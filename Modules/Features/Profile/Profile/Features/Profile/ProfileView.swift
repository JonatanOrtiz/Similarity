//
//  ProfileContentView.swift
//  Profile
//
//  Created by Jonatan Ortiz on 03/08/23.
//

import SwiftUI
import UI

public struct ProfileLoadingView<ViewModeling>: View where ViewModeling: ProfileViewModeling {
    @StateObject var viewModel: ViewModeling

    public var body: some View {
        Group {
            if viewModel.isLoading {
                loadingView()
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
    private func loadingView() -> some View {
        VStack {
            ProgressView("Loading...")
        }
    }

    // create later
    private func errorView() -> some View {
        VStack {
            Text("An error occurred while fetching the profile.")
                .foregroundColor(.red)
            Button("Try Again") {
                viewModel.fetchProfile()
            }
        }
    }
}

// MARK: - ProfileView
struct ProfileView: View {
    typealias Localizable = Strings.Profile

    @State private var profile: AppProfile
    @State private var selectedImageIndex = 0

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
                    makeChips(
                        chips:
                            [
                                ChipData(backgroundColor: .appBlue, text: profile.details.job, sfIcon: .suitcase),
                                ChipData(backgroundColor: .appBlue, text: profile.details.graduation, sfIcon: .graduationcap),
                                ChipData(backgroundColor: .appBlue, text: profile.details.city, sfIcon: .map),
                                ChipData(backgroundColor: .appBlue, text: profile.details.sign, sfIcon: .sparkles),
                                ChipData(backgroundColor: .appBlue, text: profile.details.kids, icon: .baby),
                                ChipData(backgroundColor: .appBlue, text: profile.details.drinks, sfIcon: .wineglass),
                                ChipData(backgroundColor: .appBlue, text: profile.details.smokes, icon: .cigar),
                                ChipData(backgroundColor: .appBlue, text: profile.details.height, icon: .ruler)
                            ]
                    )
                    sectionTitle(title: Localizable.languages)
                    makeChips(chips: profile.details.languages.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.musicGenres)
                    makeChips(chips: profile.attributes.musicGenres.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.watchingReading)
                    makeChips(chips: profile.attributes.watchingReading.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.gameGenres)
                    makeChips(chips: profile.attributes.gameGenres.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.firstDate)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: profile.attributes.firstDate) ])
                    sectionTitle(title: Localizable.breadwinnerHomemaker)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: profile.attributes.breadwinnerHomemaker) ])
                    sectionTitle(title: Localizable.cleaningRoutines)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: profile.attributes.cleaningRoutines) ])
                    sectionTitle(title: Localizable.hobbiesInterests)
                    makeChips(chips: profile.attributes.hobbiesInterests.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.whenIGoOutILikeTo)
                    makeChips(chips: profile.attributes.whenIGoOutILikeTo.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.foodCuisinePreferences)
                    makeChips(chips: profile.attributes.foodCuisinePreferences.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.travel)
                    makeChips(chips: profile.attributes.travel.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.philosophyOfLife)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: profile.attributes.philosophyOfLife) ])
                    sectionTitle(title: Localizable.petPreferences)
                    makeChips(chips: profile.attributes.petPreferences.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.urbanRural)
                    makeChips(chips: profile.attributes.urbanRural.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.socialMedia)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: profile.attributes.socialMedia) ])
                    sectionTitle(title: Localizable.lifestyle)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: profile.attributes.lifestyle) ])
                    sectionTitle(title: Localizable.religion)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: profile.attributes.religion) ])
                    sectionTitle(title: Localizable.socialPreferences)
                    makeChips(chips: profile.attributes.socialPreferences.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.familyValues)
                    makeChips(chips: profile.attributes.familyValues.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.sexualOrientation)
                    makeChips(chips: profile.attributes.sexualOrientation.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.genderIdentity)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: profile.attributes.genderIdentity) ])
                    sectionTitle(title: Localizable.politicalPositioning)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: profile.attributes.politicalPositioning) ])
                    sectionTitle(title: Localizable.bodyType)
                    makeChips(chips: profile.attributes.bodyType.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.skinColor)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: profile.attributes.skinColor) ])
                    sectionTitle(title: Localizable.mentalHealthDisorder)
                    makeChips(chips: profile.attributes.mentalHealthDisorder.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.healthProblems)
                    makeChips(chips: profile.attributes.healthProblems.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.clothingStyle)
                    makeChips(chips: profile.attributes.clothingStyle.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.communicationStyle)
                    makeChips(chips: profile.attributes.communicationStyle.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.financialManagement)
                    makeChips(chips: profile.attributes.financialManagement.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.lifeGoals)
                    makeChips(chips: profile.attributes.lifeGoals.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.environmentalConcerns)
                    makeChips(chips: profile.attributes.environmentalConcerns.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.humorStyle)
                    makeChips(chips: profile.attributes.humorStyle.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.socializingPreferences)
                    makeChips(chips: profile.attributes.socializingPreferences.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.futureFamilyPlans)
                    makeChips(chips: [ ChipData(backgroundColor: .appBlue, text: profile.attributes.futureFamilyPlans) ])
                    sectionTitle(title: Localizable.personalityTraits)
                    makeChips(chips: profile.attributes.personalityTraits.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.conflictResolutionStyle)
                    makeChips(chips: profile.attributes.conflictResolutionStyle.map { ChipData(backgroundColor: .appPurple, text: $0) })
                    sectionTitle(title: Localizable.privacyIndependence)
                    makeChips(chips: profile.attributes.privacyIndependence.map { ChipData(backgroundColor: .appPurple, text: $0) })
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
        return ProfileLoadingView(viewModel: ProfileViewModel(dependencies: DependencyContainer()))
            .environment(\.locale, .init(identifier: "pt-BR"))
    }
}
