import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = MovieViewModel()
    @State private var selectedTab = 0

    var body: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)

                VStack(spacing: 0) {
                    // Header with Welcome Message and NavBar
                    ZStack(alignment: .bottom) {
                        LinearGradient(
                            gradient: Gradient(colors: [.red, .black.opacity(0.7)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: 150)  // Increased height to accommodate the welcome message
                        .edgesIgnoringSafeArea(.top)
                        .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 5)

                        VStack(spacing: 10) {
                            Text("Welcome to MovieNight")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .shadow(radius: 10)

                            Picker("", selection: $selectedTab) {
                                Text("Home").tag(0)
                                Text("Favorites").tag(1)
                            }
                            .pickerStyle(SegmentedPickerStyle())
                            .background(Color.clear)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 5)
                            .onChange(of: selectedTab) { _ in
                                UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.gray
                                UIPageControl.appearance().pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.3)
                            }
                        }
                    }

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
                        if viewModel.movies.isEmpty {
                            Text("No favorites yet")
                                .foregroundColor(.white)
                        } else {
                            ScrollView {
                                VStack(spacing: 16) {
                                    ForEach(viewModel.movies.filter { $0.isFavorite }) { movie in
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
        }
    }
}
