import Foundation

class MovieViewModel: ObservableObject {
    @Published var movies = [Movie]()
    @Published var showError = false
    @Published var errorMessage: String?
    
    private let apiKey = "25cf32747c4f8222196450febb21f5bb"

    func fetchMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    self.errorMessage = error.localizedDescription
                    self.showError = true
                    return
                }

                guard let data = data else {
                    self.errorMessage = "No data returned"
                    self.showError = true
                    return
                }

                do {
                    let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                    self.movies = movieResponse.results
                    print("Fetched \(self.movies.count) movies")  // Debug output
                } catch {
                    self.errorMessage = "Failed to decode response"
                    self.showError = true
                    print("Decoding error: \(error.localizedDescription)")  // Debug output
                }
            }
        }.resume()
    }
}
