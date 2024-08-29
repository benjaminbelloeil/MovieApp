import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = MovieViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)

                if viewModel.movies.isEmpty {
                    Text("No favorites yet")
                        .foregroundColor(.white)
                } else {
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(viewModel.movies) { movie in
                                if movie.isFavorite {
                                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                                        MovieRowView(movie: movie)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                    .navigationTitle("My Favorites")
                    .foregroundColor(.white)
                }
            }
        }
        .onAppear {
            viewModel.fetchMovies()
        }
    }
}
