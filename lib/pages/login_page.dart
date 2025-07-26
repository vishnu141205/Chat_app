import 'package:chat_app/service/auth/auth_service.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final void Function()? onTap;

  LoginPage({
    super.key, 
    required this.onTap
  });

  void login(BuildContext context) async{

    final authService = AuthService();

    try {
      await authService.signInWithEmailAndPassword(emailController.text, passwordController.text);
    }
    catch (e) {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text(e.toString())
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.message, size: 100, color: Theme.of(context).colorScheme.primary),

            const SizedBox(height: 20),
            Text("Welcome to Chat App",
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),

            const SizedBox(height: 20),
            
            MyTextField(
              hintText: "Email",
              obscureText: false,
              controller: emailController,

            ),

            const SizedBox(height: 10),

            MyTextField(
              hintText: "Password",
              obscureText: true,
              controller: passwordController,
            ),

            const SizedBox(height: 20),

            MyButton(
              text: "Login",
              onTap: () => login(context), 
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Register now",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            

          ],
        ),
      ),
    );
   }
}
