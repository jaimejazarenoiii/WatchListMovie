//
//  MovieDetailView.swift
//  WathcListMovie
//
//  Created by Jaime Jazareno IV on 6/20/23.
//

import SwiftUI

struct MovieDetailView<ViewModel>: View where ViewModel: MovieDetailViewModelTypes {
    @ObservedObject private var viewModel: ViewModel
    let dateFormatter = DateFormatter()

    init(movie: Movie?, viewModel: ViewModel) {
        self.viewModel = viewModel
        viewModel.inputs.set(movie: movie)
        dateFormatter.dateFormat = "YYYY, d MMMM"
    }

    var body: some View {
        VStack(alignment: .leading) {
            Group {
                Divider()
                HStack(alignment: .top) {
                    if let movie = viewModel.outputs.movie {
                        movie.cover
                            .resizable()
                            .frame(width: 100, height: 150)
                            .aspectRatio(contentMode: .fill)
                            .shadow(radius: 7)
                    }
                    VStack(alignment: .leading) {
                        HStack(alignment: .top) {
                            Text(viewModel.outputs.movie?.title ?? "")
                                .bold()
                                .font(.headline)
                            Spacer()
                            Text("\(String(format: "%.1f", viewModel.outputs.movie?.rating.rounded(toPlaces: 1) ?? 0))")
                                .bold()
                                .font(.headline)
                        }
                        Spacer()
                            .frame(height: 30)
                        if viewModel.outputs.movie?.isOnWatchList ?? true {
                            Button(action: {
                                viewModel.inputs.removeFromWatchList()
                            }) {
                                Text("REMOVE FROM WATCHLIST")
                                    .font(.system(size: 10))
                                    .foregroundColor(.black)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(Color.gray)
                            .cornerRadius(25)
                        } else {
                            Button(action: {
                                viewModel.inputs.addToWatchList()
                            }) {
                                Text("+ ADD TO WATCHLIST")
                                    .font(.system(size: 10))
                                    .foregroundColor(.black)
                            }
                            .buttonStyle(.borderedProminent)
                            .tint(Color.gray)
                            .cornerRadius(25)
                        }
                        Spacer()
                            .frame(height: 10)
                        if let url = URL(string: viewModel.outputs.movie?.trailerLink ?? "") {
                            Button(action: {
                                print("sign up bin tapped")
                            }) {
                                Link("WATCH TRAILER", destination: url)
                                    .font(.system(size: 10))
                                    .foregroundColor(.black)
                            }
                            .buttonStyle(.bordered)
                            .tint(Color.white)
                            .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 1))
                        }
                    }

                }
                .padding(.vertical, 10)
                Divider()
            }
            Group {
                Text("Short description")
                    .bold()
                    .font(.headline)
                    .padding(.vertical, 10)
                Text(viewModel.outputs.movie?.description ?? "")
                    .font(.caption2)
                Divider()
            }
            Group {
                Text("Details")
                        .bold()
                        .font(.headline)
                HStack {
                    Text("Genre")
                        .bold()
                        .font(.caption2)
                        .padding(.vertical, 10)
                    Text("\(viewModel.outputs.movie?.genre.joined(separator: ", ") ?? "")")
                        .font(.caption2)
                }
                HStack {
                    Text("Released date")
                        .bold()
                        .font(.caption2)
                    Text("\(dateFormatter.string(from: viewModel.outputs.movie?.releaseDate ?? Date()))")
                        .font(.caption2)
                }
            }
            Spacer()
        }
        .frame(alignment: .leading)
        .padding(.horizontal, 10)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: nil, viewModel: MovieDetailViewModel())
    }
}
