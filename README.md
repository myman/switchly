# Switchly

Switchly is a demo e-commerce Flutter app built with Clean Architecture and Provider. It loads product data from a local JSON file and supports filtering, navigation, and responsive UI.

---

## 🚀 How to Run the App

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/myman/switchly.git
   cd switchly
   ```
2. Install Dependencies:
   flutter pub get
3. Run the App:
   flutter run
   📲 App Logic & Features
   👤 Authentication Flow
   LoginScreen: enter email (must be valid format) + password (not empty) → press Log in → goes to HomeScreen
   RegisterScreen: basic form (email, password, confirm password), no real validation logic — just UI + field check
   Toggle between Login and Register using Sign up / Sign in buttons
   🏠 HomeScreen
   Displays a grid of products loaded from a local JSON file
   Includes a search bar (UI only), filter button
   Filter modal supports:
   Category  
    Color
   Price Range
   📦 Product Detail Screen
   Tapping a product navigates to detail screen with:
   Product image, name, price, description
   Buy Now button (no real functionality)
   Cart button (UI only)
   💡 Tech Stack
   Flutter + Dart
   Provider for state management
   Clean Architecture (data / domain / presentation)
   Local JSON for mock data
   OpenContainer from animations for smooth transitions
