//
//  ContentView.swift
//  WathcListMovie
//
//  Created by Jaime Jazareno IV on 6/19/23.
//

import SwiftUI

struct MovieListView<ViewModel>: View where ViewModel: MovieListViewModelTypes {
    @ObservedObject private var viewModel: ViewModel
    @State private var showingSortOptions = false

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            if viewModel.outputs.isLoading {
                ProgressView()
            } else {
                ListView(movies: viewModel.outputs.movies)
                    .navigationBarTitle("Movies")
                    .toolbar {
                        Button("Sort") {showingSortOptions.toggle()}
                            .foregroundColor(.black)
                            .sheet(isPresented: $showingSortOptions) {
                                VStack {
                                    Button("Title") {}
                                    Button("Release Date") {}
                                }
                                    .presentationDetents([.medium, .large])
                                    .presentationDragIndicator(.hidden)
                            }
                    }
                    .onAppear {
                        print("ZXCXZ")
                        viewModel.inputs.fetchList()
                    }
            }
        }

    }
}

private struct ListView: View {
    var movies: [Movie] = []
    var body: some View {
        List(movies, id: \.id) { movie -> NavigationLink<MovieCell, MovieDetailView> in
            NavigationLink(
                destination: MovieDetailView(movie: movie, viewModel: MovieDetailViewModel())
            ) {
                MovieCell(movie: movie)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(viewModel: MovieListViewModel())
    }
}
