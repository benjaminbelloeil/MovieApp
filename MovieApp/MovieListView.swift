import SwiftUI

struct MovieListView: View {
    let movies: [Movie]

    var body: some View {
        List(movies) { movie in
            NavigationLink(destination: MovieDetailView(movie: movie)) {
                MovieRowView(movie: movie)
            }
        }
        .listStyle(PlainListStyle())
    }
}
