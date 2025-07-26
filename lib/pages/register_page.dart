import 'package:chat_app/service/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/components/my_button.dart';
import 'package:chat_app/components/my_text.dart';

class RegisterPage extends StatelessWidget{
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    final void Function()? onTap;


  RegisterPage({super.key, required this.onTap});

  void register(BuildContext context) {
    final _auth = AuthService();

    if (passwordController.text == confirmPasswordController.text){
      try {
        _auth.registerWithEmailAndPassword(emailController.text, passwordController.text);
      } catch (e) {
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text(e.toString())
      ));
    }
    }

    else {
      
      showDialog(context: context, builder: (context) => AlertDialog(
        title: Text("Password do not match")
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
            Text("Create a new account",
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

            MyTextField(
              hintText: "ConfirmPassword",
              obscureText: true,
              controller: confirmPasswordController,
            ),

            const SizedBox(height: 20),

            MyButton(
              text: "Register",
              onTap: () => register(context), 
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text("Login now",
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