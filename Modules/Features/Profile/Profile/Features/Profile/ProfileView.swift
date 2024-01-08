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
    
    let imageUrls: [AssetImage] = [.someImageExample1, .someImageExample2, .someImageExample3, .someImageExample4, .someImageExample5, .someImageExample6]
    
    public var body: some View {
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
        .backgroundImage()
    }
    
    var ImagesCarrousel: some View {
        TabView {
            ForEach(0..<imageUrls.count, id: \.self) { index in
                ImageContainerView(image: imageUrls[index])
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
        .tabViewStyle(PageTabViewStyle())
        .frame(height: UIScreen.main.bounds.height / 1.5)
        .cornerRadius(20, corners: [.bottomRight, .bottomLeft])
        .overlay(alignment: .bottomLeading) {
            ProfileDataView
        }
    }
    
    var ProfileDataView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Andressa, 23")
                .secondaryTitleBold(.white)
            HStack {
                Image.assetIcon(.suitcase)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                Text("Designer")
                    .calloutBold(.white)
            }
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
        .padding()
    }
    
    var AboutMeView: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text.localized(LocalizedStringKey(Strings.Profile.aboutMe))
                .secondaryTitleBold()
                .fixedSize(horizontal: false, vertical: true)
                .padding(EdgeInsets(top: 20, leading: 15, bottom: 0, trailing: 20))
            Text("Hello, my name is Emily and I like to walk my dog.\nI like to go to concerts, watch series and movies and discover new places and different foods. I like both the beach and the mountains and tourist cities and I love all animals.\nI do some modeling jobs.\nIf I don't answer here, follow me on the other network and send me a message and I'll always answer.\n@andr_essa_novais \u{2764}")
                .calloutBold()
                .fixedSize(horizontal: false, vertical: true)
                .padding()
                .padding(.bottom, 500)
        }
    }
    
    struct ImageContainerView: View {
        let image: AssetImage
        var body: some View {
            Color.clear
                .overlay(
                    Image.assetImage(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                )
                .clipped()
        }
    }
}

struct ProfileContentView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environment(\.locale, .init(identifier: "pt-BR"))
    }
}
