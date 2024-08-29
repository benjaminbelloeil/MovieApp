import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
            // Full-Screen Background
            LinearGradient(
                gradient: Gradient(colors: [.black, .gray]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)  // Ensure the background fills the entire screen

            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    // Movie Image
                    if let posterURL = movie.posterURL {
                        AsyncImage(url: posterURL) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity)
                                .frame(height: 300)
                                .clipped()
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        } placeholder: {
                            Color.gray
                                .frame(height: 300)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                    }

                    // Movie Title
                    Text(movie.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                        .shadow(radius: 5)

                    // Movie Rating
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text("\(movie.voteAverage ?? 0.0, specifier: "%.1f") / 10")
                            .font(.title2)
                            .foregroundColor(.white)
                            .shadow(radius: 5)
                    }
                    .padding(.bottom, 5)

                    // Release Date
                    Text("Release Date: \(movie.releaseDate ?? "N/A")")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.bottom, 10)
                        .shadow(radius: 3)

                    // Overview Title
                    Text("Overview")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                        .shadow(radius: 3)

                    // Movie Overview
                    Text(movie.overview)
                        .font(.body)
                        .foregroundColor(.white.opacity(0.9))
                        .padding()
                        .background(Color.black.opacity(0.6))
                        .cornerRadius(10)
                        .shadow(radius: 5)
                }
                .padding()
            }

            // Custom Back Button
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                            Text("Back")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.red.opacity(0.8))
                        .cornerRadius(8)
                        .shadow(radius: 5)
                    }
                    .padding()
                    Spacer()
                }
                Spacer()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)  // Hide the default navigation bar to use the custom back button
    }
}
