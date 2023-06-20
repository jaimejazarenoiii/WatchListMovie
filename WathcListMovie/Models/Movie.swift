//
//  Movie.swift
//  WathcListMovie
//
//  Created by Jaime Jazareno IV on 6/19/23.
//

import Foundation
import SwiftUI

struct Movie: Identifiable {
    var id: Int = 0
    var title: String
    var description: String
    var rating: Double
    var duration: String
    var genre: [String]
    var releaseDate: Date
    var trailerLink: String
    var cover: Image
    var isOnWatchList: Bool = false

    static var sampleList: [Movie] = [
        Movie(title: "Tenet",
              description: "Armed with only one word, Tenet, and fighting for the survival of the entire world, aProtagonist journeys through a twilight world of international espionage on a mission that willunfold in something beyond real time.",
              rating: 7.8,
              duration: "2h 30min",
              genre: ["Action", "Sci-Fi"],
              releaseDate: Date("2020/09/03"),
              trailerLink: "https://www.youtube.com/watch?v=LdOM0x0XDMo",
              cover: Image("Tenet")),
        Movie(id: 1,
              title: "Spider-Man: Into the Spider-Verse",
              description: "Teen Miles Morales becomes the Spider-Man of his universe, and must join with fivespider-powered individuals from other dimensions to stop a threat for all realities.",
              rating: 8.4,
              duration: "1h 57min",
              genre: ["Action", "Animation", "Adventure"],
              releaseDate: Date("2018/12/14"),
              trailerLink: "https://www.youtube.com/watch?v=tg52up16eq0",
              cover: Image("Spider Man")),
        Movie(id: 2,
              title: "Knives Out",
              description: "A detective investigates the death of a patriarch of an eccentric, combative family.",
              rating: 7.9,
              duration: "2h 10min",
              genre: ["Comedy", "Crime", "Drama"],
              releaseDate: Date("2019/11/27"),
              trailerLink: "https://www.youtube.com/watch?v=qGqiHJTsRkQ",
              cover: Image("Knives Out")),
        Movie(id: 3,
              title: "Guardians of the Galaxy",
              description: "A group of intergalactic criminals must pull together to stop a fanatical warrior withplans to purge the universe.",
              rating: 8.0,
              duration: "2h 1min",
              genre: ["Action", "Adventure", "Comedy"],
              releaseDate: Date("2014/08/01"),
              trailerLink: "https://www.youtube.com/watch?v=d96cjJhvlMA",
              cover: Image("Guardians of The Galaxy")),
        Movie(id: 4,
              title: "Avengers: Age of Ultron",
              description: "When Tony Stark and Bruce Banner try to jump-start a dormant peacekeepingprogram called Ultron, things go horribly wrong and it's up to Earth's mightiest heroes to stop thevillainous Ultron from enacting his terrible plan.",
              rating: 7.3,
              duration: "2h 21min",
              genre: ["Action", "Adventure", "Sci-Fi"],
              releaseDate: Date("2015/05/01"),
              trailerLink: "https://www.youtube.com/watch?v=tmeOjFno6Do",
              cover: Image("Avengers")),
    ]
}
