import 'package:chat_app/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget{
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Dark Mode"),
        
            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context).isDarkMode, 
              onChanged: (value) =>
                Provider.of<ThemeProvider>(context, listen: false).toggleTheme(),
            ),
          ],
        ),
      )
      );
    
  }
}