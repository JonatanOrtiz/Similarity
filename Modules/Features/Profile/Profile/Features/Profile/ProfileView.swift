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

    let imageUrls: [AssetImage] = [.someImageExample1, .someImageExample2, .someImageExample3, .someImageExample4, .someImageExample5, .someImageExample6]
    
    public var body: some View {
        VStack {
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
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    ImagesCarrousel
                    AboutMeView
                }
                .padding(.bottom, 60)
            }
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
        }
        .backgroundImage()
    }

    var ImagesCarrousel: some View {
        TabView(selection: $selectedImageIndex) {
            ForEach(0..<imageUrls.count, id: \.self) { index in
                ImageContainerView(image: imageUrls[index],
                                   onTapLeft: {
                    if selectedImageIndex > 0 { selectedImageIndex -= 1 }
                },
                                   onTapRight: {
                    if selectedImageIndex < imageUrls.count - 1 { selectedImageIndex += 1 }
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
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
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
            .padding(.bottom, 1)
        }
        .allowsHitTesting(false)
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 1, trailing: 0))
        .padding()
    }
    
    var AboutMeView: some View {
        VStack(alignment: .leading, spacing: 15) {
            Text.localized(LocalizedStringKey(Strings.Profile.aboutMe))
                .secondaryTitleBold(.appWhite)
                .fixedSize(horizontal: false, vertical: true)
            Text("I do some modeling jobs.\nIf I don't answer here, follow me on the other network and send me a message and I'll always answer.\n@andr_essa_novais \u{2764}")
                .bodyBold(.white)
                .lineSpacing(7)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(18)
        .flatGlassCard(color: .appPurple)
        .padding(.bottom, 500)
    }

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

struct ProfileContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environment(\.locale, .init(identifier: "pt-BR"))
    }
}
