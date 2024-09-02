import SwiftUI

struct MovieRowView: View {
    @EnvironmentObject var movieViewModel: MovieViewModel
    let movie: Movie

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let posterURL = movie.posterURL {
                AsyncImage(url: posterURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.6), radius: 10, x: 0, y: 5)
                } placeholder: {
                    Color.gray
                        .frame(height: 200)
                        .cornerRadius(16)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white.opacity(0.2), lineWidth: 1)
                        )
                        .shadow(color: .black.opacity(0.6), radius: 10, x: 0, y: 5)
                }
            }

            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.8)]),
                startPoint: .center,
                endPoint: .bottom
            )
            .cornerRadius(16)
            .frame(height: 200)

            VStack(alignment: .leading, spacing: 4) {
                Text(movie.title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .lineLimit(2)

                if let voteAverage = movie.voteAverage {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(voteAverage, specifier: "%.1f")/10")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                }

                Text(movie.releaseDate ?? "N/A")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()

            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        print("Heart button pressed for movie: \(movie.title)")
                        movieViewModel.toggleFavorite(movie: movie)
                    }) {
                        Image(systemName: movieViewModel.isFavorite(movie: movie) ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .font(.system(size: 25))
                            .padding()
                    }
                    Spacer()
                }
            }
        }
        .padding(.horizontal)
        .contentShape(Rectangle()) // Ensures the entire card is tappable
    }
}
