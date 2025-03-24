import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProfileProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Profile',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserProfileScreen(),
    );
  }
}

class UserProfileProvider extends ChangeNotifier {
  String _username = "John Doe";
  String _email = "johndoe@example.com";

  String get username => _username;
  String get email => _email;

  void updateUsername(String newUsername) {
    _username = newUsername;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    _email = newEmail;
    notifyListeners();
  }
}

class UserProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: constraints.maxWidth * 0.15,
                    backgroundImage: AssetImage('assets/profile_placeholder.png'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Username:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userProvider.username,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Email:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    userProvider.email,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AccountManagementScreen()),
                      );
                    },
                    child: Text('Manage Account'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Text('Settings Screen'),
      ),
    );
  }
}

class AccountManagementScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProfileProvider>(context);

    _usernameController.text = userProvider.username;
    _emailController.text = userProvider.email;

    return Scaffold(
      appBar: AppBar(
        title: Text('Account Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                try {
                  userProvider.updateUsername(_usernameController.text);
                  userProvider.updateEmail(_emailController.text);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Account updated successfully')),
                  );
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error updating account: $e')),
                  );
                }
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
