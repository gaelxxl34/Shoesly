import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../util/constraints/text.dart';


class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final appState = Provider.of<AppState>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [Colors.blue, Colors.red, Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ).createShader(bounds),
                    child: Text(
                      AppText.appTitle,
                      style: TextStyle(
                        fontSize: screenWidth * 0.1, // Adjust font size based on screen width
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // This color will be masked by the gradient
                      ),
                    ),
                  ),


                  Center(
                    child: Text(
                      AppText.welcomeMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: screenWidth * 0.035, // Adjust font size based on screen width
                      ),
                    ),
                  ),
                ],
              ),
              Image.asset(
                'assets/welcome.png',
                height: screenHeight * 0.4, // 30% of screen height
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                        Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blue, backgroundColor: Colors.black, // This will change the text color when the button is pressed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015), // Adjust padding based on screen height
                    ),
                    child: Center(
                      child: Text(
                        AppText.loginButton,
                        style: TextStyle(
                          fontSize: screenWidth * 0.045, // Adjust font size based on screen width
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01), // Adjust size based on screen height
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.blue, backgroundColor: Colors.black, // This will change the text color when the button is pressed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015), // Adjust padding based on screen height
                    ),
                    child: Center(
                      child: Text(
                        AppText.registerButton,
                        style: TextStyle(
                          fontSize: screenWidth * 0.045, // Adjust font size based on screen width
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
