import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid != null) {
        Provider.of<UserController>(context, listen: false).fetchUserData(uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userController = Provider.of<UserController>(context);
    final currentUser = userController.currentUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.red),
            onPressed: () async {
              await AuthController().signOut();
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
            },
          ),
        ],
      ),
      body: userController.isLoading
          ? Center(child: CircularProgressIndicator(color: Colors.blueAccent))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: currentUser == null
            ? Center(child: Text('No user data found'))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12),
            Text(
              currentUser.name.toUpperCase(),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              currentUser.email,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.phone, color: Colors.blue),
                    title: Text('Phone'),
                    subtitle: Text('+123 456 7890'),
                  ),
                  ListTile(
                    leading: Icon(Icons.location_on, color: Colors.blue),
                    title: Text('Location'),
                    subtitle: Text('123 Main Street, City, Country'),
                  ),
                  ListTile(
                    leading: Icon(Icons.work, color: Colors.blue),
                    title: Text('Job'),
                    subtitle: Text('Software Engineer'),
                  ),
                  ListTile(
                    leading: Icon(Icons.school, color: Colors.blue),
                    title: Text('Education'),
                    subtitle: Text('Bachelor\'s Degree in Computer Science'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}





