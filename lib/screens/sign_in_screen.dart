import 'package:flutter/material.dart';
import 'package:modul_6/screens/sign_up_screen.dart';
import 'package:provider/provider.dart';
import '../provider/auth_notifier.dart';
import '../utils/snackbar_helper.dart';

class SignInScreen extends StatelessWidget {
  // TODO: Add TextEditting Controller for email & password
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInScreen({super.key});

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
              'Sign In',
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
            // TODO: Add Login Button
            ElevatedButton(
                onPressed: authNotifier.isLoading ? null : () async {
                  bool success = await authNotifier.signIn(
                    emailController.text,
                    passwordController.text,
                  );
                  if (!success) {
                    SnackBarHelper.show(context, 'Email/Password Salah');
                  }
                },
                child: authNotifier.isLoading
                    ? CircularProgressIndicator()
                    : Text('Login')
            ),

            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SignUpScreen()),
              ),
              child: Text('Belum punya akun? Sign Up'),
            )
          ],
        ),
      ),
    );
  }
}