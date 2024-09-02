# MovieApp

MovieApp is a SwiftUI-based application that allows users to browse popular movies, view detailed information about each movie, and mark movies as favorites. The app integrates with The Movie Database (TMDb) API to fetch the latest movie data.

## Features

- **Browse Movies**: View a list of popular movies fetched from TMDb.
- **Movie Details**: View detailed information about a movie, including the title, rating, release date, and overview.
- **Favorites**: Mark movies as favorites and access them easily from the "Favorites" tab.
- **Dynamic UI**: Animated UI elements and a Netflix-inspired design for an immersive user experience.

## Screenshots

<img width="497" alt="Home" src="https://github.com/user-attachments/assets/9eb5b7b1-e22f-49fb-acc9-51f031004e7b">
<img width="497" alt="Movie Detail" src="https://github.com/user-attachments/assets/138bd496-8932-41cf-86bc-7780560e905f">
<img width="453" alt="Favorites" src="https://github.com/user-attachments/assets/dead4308-3598-4fdb-9fae-e77f65d9189f">

## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.3+

## Setup

1. **Clone the Repository**

   ```bash
   git clone https://github.com/your-username/MovieApp.git
   cd MovieApp
   ```

2. **Install Dependencies**

   Ensure that you have the necessary tools and libraries installed:

   - Xcode
   - SwiftUI (comes with Xcode)

3. **Configure the API Key**

   The app uses TMDb API to fetch movie data. You need to obtain an API key from [TMDb](https://www.themoviedb.org/documentation/api) and set it up in the project.

   - Open `MovieViewModel.swift`
   - Replace the `apiKey` property with your own TMDb API key:
     ```swift
     private let apiKey = ProcessInfo.processInfo.environment["MOVIE_API_KEY"] ?? ""
     ```

4. **Run the App**

   Open the project in Xcode and press `Cmd + R` to build and run the app on a simulator or connected device.

## Usage

- **Home Screen**: The home screen displays a list of popular movies. Tap on a movie to view its details.
- **Movie Details**: On the details screen, you can read more about the movie, including its rating, release date, and a brief overview. Tap the heart icon in the top right corner of the movie poster to mark it as a favorite.
- **Favorites Tab**: Access your favorite movies quickly by switching to the "Favorites" tab.

## Contributing

Contributions are welcome! If you'd like to improve the app, feel free to fork the repository and submit a pull request.

1. Fork the repository
2. Create a new branch (`git checkout -b feature-branch`)
3. Commit your changes (`git commit -m 'Add some feature'`)
4. Push to the branch (`git push origin feature-branch`)
5. Open a pull request

## Acknowledgments

- This app uses the [TMDb API](https://www.themoviedb.org/documentation/api) but is not endorsed or certified by TMDb.
- Inspired by Netflix's design and user experience principles.

### Key Sections:

- **Features**: A brief overview of what the app can do.
- **Screenshots**: Placeholders for screenshots of your app to showcase its UI (you can add screenshots to a `screenshots` folder in your repository).
- **Requirements**: Software and hardware requirements to run the app.
- **Setup**: Step-by-step instructions on how to clone the repository, set up the API key, and run the app.
- **Usage**: Instructions on how to use the main features of the app.
- **Contributing**: Guidelines for contributing to the project.
- **License**: Information about the project’s licensing.
- **Acknowledgments**: Credits and acknowledgment for any third-party resources or inspiration.
