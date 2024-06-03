# Priority Soft Test Project

This Flutter project is part of a technical evaluation for Priority Soft, aimed at showcasing my skills in mobile application development using Flutter and Firebase.

## Getting Started

This project demonstrates the implementation of a comprehensive mobile application with various features, including user authentication, product reviews, cart management, and an admin system.

### Features

- **Login and Sign Up**: Integrated with Firebase Authentication and Firestore for secure user authentication.
- **Stay-In Feature**: Keeps users logged in and checks their state to determine if they are an admin or a regular user.
- **Optimized Review System**: Allows users to add reviews and includes a Firebase function to calculate average ratings based on the number of reviews. Users can filter reviews by star ratings.
- **Cart Management**: Enables users to delete products from the cart, and if the cart is empty, a button redirects the user to add more products.
- **Profile Page**: Displays the current user's data with a logout button.
- **Checkout Page**: Allows users to add and view orders, which are also visible on the admin side.
- **Admin System**: Provides a complete system for managing all operations and viewing user orders.

### Screenshots
<div style="display: flex; flex-wrap: wrap;">
  <img src="https://github.com/gaelxxl34/Shoesly/blob/main/assets/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202024-06-03%20at%2014.41.05.png" alt="Screenshot 1" width="200" style="margin-right: 20px;">
  <img src="https://github.com/gaelxxl34/Shoesly/blob/main/assets/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202024-06-03%20at%2014.41.14.png" alt="Screenshot 1" width="200" style="margin-right: 20px;">
  <img src="https://github.com/gaelxxl34/Shoesly/blob/main/assets/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202024-06-03%20at%2014.41.18.png" alt="Screenshot 2" width="200" style="margin-right: 20px;">
  <img src="https://github.com/gaelxxl34/Shoesly/blob/main/assets/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202024-06-03%20at%2014.41.23.png" alt="Screenshot 3" width="200" style="margin-right: 20px;">
  <img src="https://github.com/gaelxxl34/Shoesly/blob/main/assets/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202024-06-03%20at%2014.42.07.png" alt="Screenshot 3" width="200" style="margin-right: 20px;">
  <img src="https://github.com/gaelxxl34/Shoesly/blob/main/assets/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202024-06-03%20at%2014.42.46.png" alt="Screenshot 3" width="200" style="margin-right: 20px;">
  <img src="https://github.com/gaelxxl34/Shoesly/blob/main/assets/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202024-06-03%20at%2014.43.10.png" alt="Screenshot 3" width="200" style="margin-right: 20px;">
  <img src="https://github.com/gaelxxl34/Shoesly/blob/main/assets/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202024-06-03%20at%2014.43.43.png" alt="Screenshot 3" width="200" style="margin-right: 20px;">
  <img src="https://github.com/gaelxxl34/Shoesly/blob/main/assets/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202024-06-03%20at%2014.44.21.png" alt="Screenshot 3" width="200" style="margin-right: 20px;">
  <img src="https://github.com/gaelxxl34/Shoesly/blob/main/assets/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202024-06-03%20at%2014.45.40.png" alt="Screenshot 3" width="200" style="margin-right: 20px;">
  <img src="https://github.com/gaelxxl34/Shoesly/blob/main/assets/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202024-06-03%20at%2014.45.50.png" alt="Screenshot 3" width="200" style="margin-right: 20px;">
  <img src="https://github.com/gaelxxl34/Shoesly/blob/main/assets/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202024-06-03%20at%2014.46.02.png" alt="Screenshot 3" width="200" style="margin-right: 20px;">
  <img src="https://github.com/gaelxxl34/Shoesly/blob/main/assets/Simulator%20Screenshot%20-%20iPhone%2015%20Pro%20Max%20-%202024-06-03%20at%2014.45.44.png" alt="Screenshot 3" width="200" style="margin-right: 20px;">
</div>


### Challenges
- **Integrating Firebase Authentication and Firestore while maintaining a seamless user experience.**
- **Optimizing the review system and ensuring accurate calculation of average ratings.**

### Technologies Used

- **Flutter**: For building the mobile application.
- **Firebase**: For backend services including Authentication, Firestore, and Cloud Functions.

### Packages Required

Add the following packages to your `pubspec.yaml` file:
cupertino_icons: ^1.0.2
provider: ^6.1.2
firebase_core: ^2.27.0
cloud_firestore: ^4.15.8
firebase_analytics: ^10.8.9
firebase_auth: ^4.17.8
flutter_launcher_icons: ^0.13.1

### Setup Instructions
1. Clone the repository:
bash
Copy code
git clone <repository-url>
cd <repository-directory>

2. Install the dependencies:
Copy code
flutter pub get

3. Set up Firebase:
Create a new Firebase project.
Enable Authentication, Firestore, and other necessary services.
Add the google-services.json (for Android) and GoogleService-Info.plist (for iOS) files to your Flutter project.

5. Run the application:
flutter run

### Additional Information
This project was built to meet the functional requirements outlined by Priority Soft, including:

<ul>
  <li>Displaying a grid list of shoes with infinite scroll and filtering options.</li>
  <li>Product detail pages with multiple images, selectable options, and reviews.</li>
  <li>A reviews page with filtering options.</li>
  <li>A cart page with the ability to adjust quantities and remove items.</li>
  <li>A checkout page with order summary and payment details.</li>
  <li>Proper error handling for API requests.</li>
  <li>Full responsiveness and adherence to the provided Figma design.</li>
  <li>Clean, modular, and maintainable code.</li>
</ul>

### Additional Features
<ul>
  <li>Login and Sign Up pages with Firebase Authentication.</li>
  <li>Stay-In feature to manage user sessions.</li>
  <li>Optimized review system with filtering options.</li>
  <li>Cart management features with redirection if the cart is empty.</li>
  <li>Profile page with user data display and logout functionality.</li>
  <li>Checkout page functionality for both users and admins.</li>
  <li>Complete admin system for managing operations and viewing orders.</li>
</ul>

### Conclusion
This project demonstrates my ability to integrate multiple features and maintain high code quality while ensuring a seamless user experience. The additional features enhance the overall functionality and usability of the application. I have successfully implemented all required functionalities and added extra features to improve the user experience and administrative capabilities.

For further resources and assistance with Flutter development, please refer to the Flutter online documentation, which offers tutorials, samples, and comprehensive guidance on mobile development.

