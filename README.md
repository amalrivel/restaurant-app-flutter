# Restaurant App

A Flutter application that helps users discover and explore restaurants, read reviews, and search for restaurants based on keywords. This app was developed as part of the Dicoding "Belajar Fundamental Aplikasi Flutter" course.

## Features

- **Restaurant Listing**: Browse through a curated list of restaurants with key information including name, location, rating, and a brief description.
- **Detailed Restaurant Information**: View complete details of restaurants including food and drink menus, customer reviews, and address information.
- **Search Functionality**: Search for restaurants by name, category, or menu items.
- **Review System**: Read and add reviews to restaurants.
- **Theme Switching**: Toggle between light and dark themes based on your preference.
- **Responsive Design**: Works seamlessly across different screen sizes and orientations.
- **Hero Animations**: Smooth transitions between screens enhance user experience.

## Technologies Used

- **Flutter**: UI framework for building natively compiled applications
- **Provider**: State management solution for efficient app state handling
- **HTTP**: For API communication
- **Material Design 3**: Modern and visually appealing UI components
- **Sealed Classes**: Used for robust state management
- **Hero Animations**: For smooth transitions between screens

## Architecture

The project follows a clean architecture approach with:

- **Data Layer**: API services and models
- **Provider Layer**: State management
- **UI Layer**: Screens and widgets
- **Utils**: Helper classes and utility functions

### Project Structure

```
lib/
├── config/        # Configuration files (themes, constants)
├── data/          # Data layer
│   ├── api/       # API services
│   └── models/    # Data models
├── providers/     # State management
├── ui/           
│   ├── screens/   # App screens
│   └── widgets/   # Reusable UI components
└── utils/         # Utility classes and functions
```

## Installation

1. Ensure you have Flutter installed. For installation instructions, refer to the [official Flutter documentation](https://flutter.dev/docs/get-started/install).

2. Clone this repository:
   ```bash
   git clone https://github.com/amalrivel/restaurant-app-flutter.git
   ```

3. Navigate to the project directory:
   ```bash
   cd restaurant-app-flutter
   ```

4. Get dependencies:
   ```bash
   flutter pub get
   ```

5. Run the app:
   ```bash
   flutter run
   ```

## API Reference

This app uses the restaurant API provided by Dicoding:
- Base URL: https://restaurant-api.dicoding.dev
- Endpoints:
  - List Restaurants: `/list`
  - Restaurant Detail: `/detail/{id}`
  - Search Restaurants: `/search?q={query}`
  - Add Review: `/review` (POST)

## What I Learned

- Implementing proper state management using Provider
- Working with REST APIs in Flutter
- Using sealed classes for robust state handling
- Creating smooth transitions with Hero animations
- Implementing search functionality with debouncing
- Creating dark/light theme support
- Building responsive UI for multiple screen sizes

## Future Enhancements

- Restaurant favorites functionality
- Offline support with local database
- Location-based restaurant recommendations
- Advanced filtering options
- User authentication
- Reservation system

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgements

- [Dicoding Indonesia](https://www.dicoding.com/) for providing the learning materials and API
- [Flutter](https://flutter.dev/) for the amazing framework
- [Material Design](https://material.io/design) for design guidelines

---

Developed by [amalrivel](https://github.com/amalrivel)
