import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: MovieViewModel
    @State private var selectedTab = 0
    @State private var animateTitle = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 0) {
                    // Header with Animated Title and NavBar
                    ZStack(alignment: .bottom) {
                        LinearGradient(
                            gradient: Gradient(colors: [.red, .black.opacity(0.7)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 150)
                        .edgesIgnoringSafeArea(.top)
                        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)

                        VStack(spacing: 10) {
                            // Netflix-style Animated Title
                            Text("MOVIE NIGHT")
                                .font(.system(size: 50, weight: .bold, design: .default))
                                .foregroundColor(.red)
                                .shadow(color: .red.opacity(0.8), radius: 4, x: 0, y: 0)
                                .scaleEffect(animateTitle ? 1.05 : 1.0)
                                .animation(Animation.easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: animateTitle)
                                .onAppear {
                                    animateTitle = true
                                }

                            Picker("", selection: $selectedTab) {
                                Text("Home").tag(0)
                                Text("Favorites").tag(1)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .background(Color.clear)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 5)
                            .onChange(of: selectedTab) {
                                UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.gray
                                UIPageControl.appearance().pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.3)
                            }
                        }
                    }

                    Spacer() // Ensure content starts below the header

                    // Content based on the selected tab
                    if selectedTab == 0 {
                        if viewModel.movies.isEmpty {
                            ProgressView("Loading Movies...")
                                .foregroundColor(.white)
                                .onAppear {
                                    viewModel.fetchMovies()
                                }
                        } else {
                            ScrollView {
                                VStack(spacing: 16) {
                                    ForEach(viewModel.movies) { movie in
                                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                                            MovieRowView(movie: movie)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.vertical)
                            }
                            .foregroundColor(.white)
                        }
                    } else {
                        if viewModel.favoriteMovies.isEmpty {
                            Spacer()
                            Text("No favorites yet")
                                .foregroundColor(.white)
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .padding()
                                .onAppear {
                                    print("Favorite movies: \(viewModel.favoriteMovies.map { $0.title })")
                                }
                            Spacer()
                        } else {
                            ScrollView {
                                VStack(spacing: 16) {
                                    ForEach(viewModel.favoriteMovies) { movie in
                                        NavigationLink(destination: MovieDetailView(movie: movie)) {
                                            MovieRowView(movie: movie)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                                .padding(.vertical)
                            }
                            .foregroundColor(.white)
                            .onAppear {
                                print("Favorite movies: \(viewModel.favoriteMovies.map { $0.title })")
                            }
                        }
                    }
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .alert(isPresented: $viewModel.showError) {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.errorMessage ?? "Unknown error"),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .onAppear {
            // Apply custom appearance to the Segmented Picker
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor.gray
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView_PreviewWrapper()
    }

    struct ContentView_PreviewWrapper: View {
        @StateObject private var viewModel = MovieViewModel()

        var body: some View {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
