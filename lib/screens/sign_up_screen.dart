import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_notifier.dart';

class SignUpScreen extends StatelessWidget {
  // TODO: Add TextEditting Controller for email & password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // TODO: Connect AuthNotfier
    final authNotifier = Provider.of<AuthNotifier>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: screenWidth * 0.05),
            TextField(
              // TODO: Add email controller
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: screenWidth * 0.05),
            TextField(
              // TODO: Add password controller
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: screenWidth * 0.05),
            // TODO: Add Sign Up Button
            ElevatedButton(
                onPressed: authNotifier.isLoading ? null: () async{
                  bool success = await authNotifier.signUp(
                    emailController.text,
                    passwordController.text,
                  );
                  if (success) {
                    Navigator.pop(context);
                  } else {
                    print("Gagal Sign Up");
                  };
                },
                child: authNotifier.isLoading ? CircularProgressIndicator():
                Text('Register')
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Sudah punya akun? Sign In'),
            )
          ],
        ),
      ),
    );
  }
}