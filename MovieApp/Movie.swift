import Foundation

struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    var isFavorite: Bool = false

    // Coding keys to map the JSON keys to Swift property names
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }

    var posterURL: URL? {
        if let posterPath = posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        }
        return nil
    }
}

struct MovieResponse: Codable {
    let results: [Movie]
}
