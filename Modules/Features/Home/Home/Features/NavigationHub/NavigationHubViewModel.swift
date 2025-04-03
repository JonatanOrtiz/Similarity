import SwiftUI

protocol NavigationHubViewModeling: ObservableObject {
    var currentTab: Tab { get set }
    @MainActor func viewFor(_ tab: Tab) -> AnyView
}

final class NavigationHubViewModel: NavigationHubViewModeling {
    @Published var currentTab: Tab = .profilesList

    weak var coordinator: NavigationHubCoordinating?

    @MainActor
    func viewFor(_ tab: Tab) -> AnyView {
        coordinator?.view(for: tab) ?? AnyView(EmptyView())
    }
}
