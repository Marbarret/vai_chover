//
//  vai_choverApp.swift
//  vai_chover
//
//  Created by Marcylene Barreto on 20/11/23.
//

import SwiftUI

@main
struct vai_choverApp: App {
    var body: some Scene {
        WindowGroup {
            ContentViewExe(viewModel: WeatherViewModel())
        }
    }
}
