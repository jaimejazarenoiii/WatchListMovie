//
//  WathcListMovieApp.swift
//  WathcListMovie
//
//  Created by Jaime Jazareno IV on 6/19/23.
//

import SwiftUI

@main
struct WathcListMovieApp: App {
    var body: some Scene {
        WindowGroup {
            MovieListView(viewModel: MovieListViewModel())
        }
    }
}
