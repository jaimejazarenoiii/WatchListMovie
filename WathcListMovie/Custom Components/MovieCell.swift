//
//  MovieCell.swift
//  WathcListMovie
//
//  Created by Jaime Jazareno IV on 6/19/23.
//

import SwiftUI

struct MovieCell: View {
    var movie: Movie?
    var body: some View {
        HStack(alignment: .center) {
            if let movie {
                movie.cover
                    .resizable()
                    .frame(width: 100, height: 150)
                    .aspectRatio(contentMode: .fill)
                    .shadow(radius: 7)
            }
            VStack(alignment: .leading) {
                Text(movie?.title ?? "")
                    .bold()
                    .font(.caption)
                Spacer()
                    .frame(height: 10)
                Text("\(movie?.duration ?? "") - \(movie?.genre.joined(separator: ", ") ?? "")")
                    .font(.caption2)
                    .foregroundColor(.gray)

                if movie?.isOnWatchList ?? true {
                    Spacer()
                        .frame(height: 20)
                    Text("ON MY WATCHLIST")
                        .font(.caption2)
                }
            }

        }
        .padding(.vertical, 10)
        .alignmentGuide(.listRowSeparatorLeading) { viewDimensions in
            0
        }
    }
}

struct MovieCelll_Previews: PreviewProvider {
    static var previews: some View {
        MovieCell(movie: nil)
    }
}
