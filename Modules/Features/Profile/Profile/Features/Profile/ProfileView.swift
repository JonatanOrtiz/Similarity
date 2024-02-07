//
//  ProfileContentView.swift
//  Profile
//
//  Created by Jonatan Ortiz on 03/08/23.
//

import SwiftUI
import UI

public struct ProfileView: View {
    public init() {}

    @State private var selectedImageIndex = 0

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
        .backgroundImage()
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
            Text("Natalie, 23")
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
        ProfileView()
            .environment(\.locale, .init(identifier: "pt-BR"))
    }
}
