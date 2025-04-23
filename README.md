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

## 📲 App Logic & Features

### 👤 Authentication Flow

- **LoginScreen**: Enter email (must be valid format) + password (not empty)  
  → Press **Log in** → Navigates to `HomeScreen`
- **RegisterScreen**: Fill email, password, confirm password  
  → No real validation logic – just field checks
- Toggle between Login and Register using **Sign up / Sign in** buttons

### 🏠 HomeScreen

- Displays a grid of products loaded from a local JSON file
- Search bar (UI only)
- Filter modal with:
  - **Category**
  - **Color**
  - **Price Range**

### 📦 Product Detail Screen

- Tapping a product navigates to a detail screen with:
  - Product image, name, price, description
  - **Buy Now** button (UI only)
  - **Cart button** (UI only)

### 🧱 Tech Stack

- Flutter + Dart
- Provider for state management
- Clean Architecture (data / domain / presentation)
- Local JSON for mock data
- `OpenContainer` from animations for smooth transitions
