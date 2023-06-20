//
//  MovieListViewModel.swift
//  WathcListMovie
//
//  Created by Jaime Jazareno IV on 6/19/23.
//

import Combine
import Foundation

protocol MovieListViewModelInputs {
    func fetchList()
    func sortBy(sortType: SortType)
}

protocol MovieListViewModelOutputs {
    var movies: [Movie] { get }
    var isLoading: Bool { get }
}

protocol MovieListViewModelTypes: ObservableObject {
    var inputs: MovieListViewModelInputs { get }
    var outputs: MovieListViewModelOutputs { get }
}

class MovieListViewModel: MovieListViewModelTypes, MovieListViewModelOutputs, MovieListViewModelInputs {
    var inputs: MovieListViewModelInputs { return self }
    var outputs: MovieListViewModelOutputs { return self }

    @Published var movies: [Movie]
    @Published var isLoading: Bool

    private var disposables = Set<AnyCancellable>()

    init() {
        movies = []
        isLoading = false

        fetchListProperty
            .receive(on: DispatchQueue.main)
            .sink { [weak self] value in
                guard let self else { return }
                switch value {
                case .failure:
                    self.movies = []
                case .finished:
                    break
                }
            } receiveValue: { [weak self] _ in
                guard let self else { return }
                var movies = Movie.sampleList
                let watchList = UserDefaults.standard.array(forKey: "watchList")
                movies.enumerated().forEach { index, movie in
                    guard let _ = watchList?.first(where: { ($0 as! Int) == movie.id }) else { return }
                    movies[index].isOnWatchList = true
                }
                self.movies = movies
            }
            .store(in: &disposables)

        sortByProperty
            .receive(on: DispatchQueue.main)
            .sink { _ in
                print("Completed")
            } receiveValue: { [weak self] sortedType in
                guard let self else { return }
                self.movies = Movie.sampleList.sorted(by: { first, second in
                    if sortedType == .title {
                        return first.title < second.title
                    } else {
                        return first.releaseDate < second.releaseDate
                    }
                })
            }
            .store(in: &disposables)
    }

    var fetchListProperty = PassthroughSubject<Void, Error>()
    func fetchList() {
        fetchListProperty.send(())
    }

    var sortByProperty = PassthroughSubject<SortType, Error>()
    func sortBy(sortType: SortType) {
        sortByProperty.send(sortType)
    }
}
