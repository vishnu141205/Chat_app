import 'package:chat_app/components/my_drawer.dart';
import 'package:chat_app/components/user_tile.dart';
import 'package:chat_app/pages/chat_page.dart';
import 'package:chat_app/service/auth/auth_service.dart';
import 'package:chat_app/service/chat/chat_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Home Page'),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey,
        elevation: 0,
        
      ),
      drawer: const MyDrawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading...");
        }

        return ListView(
          children: snapshot.data!.map<Widget>((userData) => _buildUserListItem(
            userData, context,
          )).toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
    Map<String, dynamic> userData, BuildContext context) {
    
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData['email'],
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) => ChatPage(
              receiverEmail: userData['email'],
               receiverID: userData['uid'],
            ),
          ));
        },
      );
    } else {
      return Container(); // Hide the current user's tile
    }
  }
}

