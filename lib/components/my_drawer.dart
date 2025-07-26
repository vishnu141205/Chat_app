import 'package:chat_app/service/auth/auth_service.dart';
import 'package:chat_app/pages/setting_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget{
  const MyDrawer({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              
              
            ),
            
            child: Text(
              'Chat App',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading:const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(context, MaterialPageRoute(
                builder: (context) => SettingPage(),
              ));
            },
          ),
          
          
          
          
          const SizedBox(height: 400),
          Spacer(),
          
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: logout,
          ),
        ],
      ),
    );
  }
}