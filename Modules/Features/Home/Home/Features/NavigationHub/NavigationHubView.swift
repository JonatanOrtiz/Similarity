//
//  NavigationHubView.swift
//  HomeSample
//
//  Created by Jonatan Ortiz on 11/07/23.
//

import SwiftUI
import UI
import Profile

struct NavigationHubView<ViewModeling>: View where ViewModeling: NavigationHubViewModeling {
    @StateObject var viewModel: ViewModeling

    init(viewModel: ViewModeling) {
        _viewModel = StateObject(wrappedValue: viewModel)
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $viewModel.currentTab) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    viewModel.viewFor(tab)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .backgroundImage()
                        .tag(tab)
                }
            }
            VStack {
                HStack(spacing: 0) {
                    ForEach(Tab.allCases, id: \.rawValue) { tab in
                        Button {
                            withAnimation(.easeInOut) {
                                viewModel.currentTab = tab
                            }
                        } label: {
                            LinearGradient(
                                colors: viewModel.currentTab == tab ? tabColors(viewModel.currentTab, tab) : [.white.opacity(0.8)],
                                startPoint: .bottomLeading,
                                endPoint: .topTrailing
                            )
                            .mask(
                                Image(systemName: tab.rawValue)
                                    .renderingMode(.template)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: viewModel.currentTab == tab ? 28 : 20)
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

#Preview {
    PreviewDependencyOrchestrator.start()
    return NavigationHubView(viewModel: NavigationHubViewModel())
}

enum Tab: String, CaseIterable {
    case configurations = "gearshape.fill"
    case likes = "arrow.down.heart.fill"
    case profilesList = "flame.fill"
    case matches = "heart.fill"
    case userProfile = "person.fill"
}
