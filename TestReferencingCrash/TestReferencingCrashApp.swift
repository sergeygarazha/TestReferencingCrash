import SwiftUI

let viewModel = ViewModel()

@main
struct TestReferencingCrashApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView {
                viewModel.test()
            }
        }
    }
}
