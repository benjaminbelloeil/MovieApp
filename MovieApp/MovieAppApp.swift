import SwiftUI

@main
struct MovieAppApp: App {
    @StateObject private var viewModel = MovieViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)  // Injecting the view model into the environment
        }
    }
}
