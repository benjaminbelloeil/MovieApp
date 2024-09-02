import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var movieViewModel: MovieViewModel

    var body: some View {
        VStack {
            Text("Total Favorites: \(movieViewModel.favoriteMovies.count)")
                .foregroundColor(.white)
                .padding()

            if movieViewModel.favoriteMovies.isEmpty {
                Text("No favorites yet")
                    .foregroundColor(.white)
            } else {
                List(movieViewModel.favoriteMovies) { movie in
                    Text(movie.title)
                        .foregroundColor(.white)
                }
            }
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            print("FavoritesView appeared. Current favorites count: \(movieViewModel.favoriteMovies.count)")
        }
        .onChange(of: movieViewModel.favoriteMovies) {
            // UI will refresh automatically when favoriteMovies changes
            print("Favorites updated.")
        }
    }
}
