//
//  NavigationHubView.swift
//  HomeSample
//
//  Created by Jonatan Ortiz on 11/07/23.
//

import SwiftUI
import UI
import Profile

public struct NavigationHubView: View {
    public init() {
        UITabBar.appearance().isHidden = true
    }

    @State var currentTab: Tab = .profilesList

    public var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $currentTab) {
                Text("Screen1")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .backgroundImage()
                    .tag(Tab.configurations)

                Text("Screen2")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .backgroundImage()
                    .tag(Tab.likes)

                Text("Screen3")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .backgroundImage()
                    .tag(Tab.profilesList)

                Text("Screen4")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .backgroundImage()
                    .tag(Tab.matches)

                ProfileFactory.make()
                    .tag(Tab.userProfile)
            }
            VStack {
                HStack(spacing: 0) {
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                        Button {
                            withAnimation(.easeInOut) {
                                currentTab = tab
                            }
                        } label: {
                            LinearGradient(
                                colors: currentTab == tab ? tabColors(currentTab, tab) : [.white.opacity(0.8)],
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            )
                            .mask(
                                Image(systemName: tab.rawValue)
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: currentTab == tab ? 28 : 20)
                                    .frame(maxWidth: .infinity)
                                    .foregroundColor(.white)
                                    .padding(.bottom, 15)
                            )
                        }
                    }
                }
                .frame(maxWidth: .infinity)
            }
            .edgesIgnoringSafeArea(.bottom)
            .frame(height: 70)
            .flatGlass()
        }
        .edgesIgnoringSafeArea(.bottom)
    }

    func tabOpacity(_ currentTab: Tab, _ tab: Tab) -> Double {
        currentTab == tab ? 1 : 0.6
    }

    func tabColors(_ currentTab: Tab, _ tab: Tab) -> [Color] {
        [
            .appPurple.opacity(tabOpacity(currentTab, tab)),
            .appPurple.opacity(tabOpacity(currentTab, tab)),
            .appPurple.opacity(tabOpacity(currentTab, tab)),
            .appBlue.opacity(tabOpacity(currentTab, tab)),
            .white.opacity(tabOpacity(currentTab, tab)),
            .white.opacity(tabOpacity(currentTab, tab))
        ]
    }
}

struct HomeContentView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewDependencyOrchestrator.start()
        return NavigationHubView()
    }
}

enum Tab: String, CaseIterable {
    case configurations = "gearshape.fill"
    case likes = "arrow.down.heart.fill"
    case profilesList = "flame.fill"
    case matches = "heart.fill"
    case userProfile = "person.fill"
}
