//
//  MovieDetailViewModel.swift
//  WathcListMovie
//
//  Created by Jaime Jazareno IV on 6/20/23.
//

import Combine
import Foundation

protocol MovieDetailViewModelInputs {
    func set(movie: Movie?)
    func addToWatchList()
    func removeFromWatchList()
}

protocol MovieDetailViewModelOutputs {
    var movie: Movie? { get }
}

protocol MovieDetailViewModelTypes: ObservableObject {
    var inputs: MovieDetailViewModelInputs { get }
    var outputs: MovieDetailViewModelOutputs { get }
}

class MovieDetailViewModel: MovieDetailViewModelTypes, MovieDetailViewModelOutputs, MovieDetailViewModelInputs {
    var inputs: MovieDetailViewModelInputs { return self }
    var outputs: MovieDetailViewModelOutputs { return self }

    @Published var movie: Movie?

    private var disposables = Set<AnyCancellable>()

    init() {
        movie = nil

        addToWatchListProperty.receive(on: DispatchQueue.main)
            .sink { value in
               return
            } receiveValue: { [weak self] _ in
                guard let self else { return }
                var watchList = UserDefaults.standard.array(forKey: "watchList")
                if watchList == nil {
                    watchList = [self.movie?.id ?? ""]
                } else {

                    watchList?.append(self.movie?.id ?? "")
                }
                UserDefaults.standard.set(watchList, forKey: "watchList")
                UserDefaults.standard.synchronize()
                var copyOfMovie = self.movie
                copyOfMovie?.isOnWatchList = true
                self.movie = copyOfMovie
            }
            .store(in: &disposables)

        removeFromWatchListProperty.receive(on: DispatchQueue.main)
            .sink { value in
               return
            } receiveValue: { [weak self] _ in
                guard let self else { return }
                var watchList = UserDefaults.standard.array(forKey: "watchList")
                if let index = watchList?.enumerated().first(where: { index, id in
                    let uuid = id as! Int
                    return self.movie?.id ?? 0 == uuid
                }).map({ $0.offset }) {
                    watchList?.remove(at: index)
                    UserDefaults.standard.set(watchList, forKey: "watchList")
                    UserDefaults.standard.synchronize()
                    var copyOfMovie = self.movie
                    copyOfMovie?.isOnWatchList = false
                    self.movie = copyOfMovie
                }
            }
            .store(in: &disposables)

        setMovieProperty
            .receive(on: DispatchQueue.main)
            .sink { _ in
                print("Completed")
            } receiveValue: { [weak self] movie in
                guard let self else { return }
                self.movie = movie
            }
            .store(in: &disposables)
    }

    var setMovieProperty = PassthroughSubject<Movie?, Error>()
    func set(movie: Movie?) {
        setMovieProperty.send(movie)
    }

    var addToWatchListProperty = PassthroughSubject<Void, Error>()
    func addToWatchList() {
        addToWatchListProperty.send(())
    }

    var removeFromWatchListProperty = PassthroughSubject<Void, Error>()
    func removeFromWatchList() {
        removeFromWatchListProperty.send(())
    }
}
