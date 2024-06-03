import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:priority_soft_test_project/screens/AdminMainScreen.dart';
import 'package:priority_soft_test_project/screens/MainScreen.dart';
import 'package:priority_soft_test_project/screens/cart_page.dart';
import 'package:priority_soft_test_project/screens/discover_page.dart';
import 'package:priority_soft_test_project/screens/login_page.dart';
import 'package:priority_soft_test_project/screens/profile.dart';
import 'package:priority_soft_test_project/screens/review_page.dart';
import 'package:priority_soft_test_project/screens/sign_up_screen.dart';
import 'package:priority_soft_test_project/screens/welcome_page.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'controllers/cart_controller.dart';
import 'controllers/order_ccontroller.dart';
import 'controllers/product_controller.dart';
import 'controllers/review_controller.dart';
import 'controllers/user_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => UserController()),
        ChangeNotifierProvider(create: (_) => ProductController()),
        ChangeNotifierProvider(create: (_) => ReviewController()),
        ChangeNotifierProvider(create: (_) => CartController()),
        ChangeNotifierProvider(create: (_) => OrderController()),
      ],
      child: ShoeslyApp(),
    ),
  );
}

class ShoeslyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shoesly',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthWrapper(),
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/discover': (context) => DiscoverPage(),
        '/main': (context) => MainScreen(),
        '/review': (context) => ReviewPage(),
        '/cart': (context) => CartPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, userController, _) {
        final user = FirebaseAuth.instance.currentUser;

        if (userController.isLoading) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (user == null) {
          return WelcomePage();
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (userController.currentUser != null) {
            if (userController.currentUser!.role == 'admin') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => AdminMainScreen()),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
              );
            }
          }
        });

        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}





