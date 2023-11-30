import SwiftUI

@main
struct vai_choverApp: App {
    @ObservedObject var viewModel = WeatherViewModel()
    var body: some Scene {
        WindowGroup {
            if viewModel.weather != nil {
                InitialView(viewModel: viewModel)
            } else {
                FakeInitialView(viewModel: viewModel)
            }
        }
    }
}
