import 'package:chat_app/Screens/Homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class drawer extends StatefulWidget {
  const drawer({super.key});

  @override
  State<drawer> createState() => _drawerState();
}

class _drawerState extends State<drawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(child:Column(children: [SizedBox(height: 40,),CircleAvatar(radius: 50,backgroundImage:NetworkImage("https://images.pexels.com/photos/15130357/pexels-photo-15130357.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load") ,),TextButton(onPressed: ()async{

   await  FirebaseAuth.instance.signOut().then((value) => Navigator.pushNamed(context,"/"));
    

      
    }, child:Row(children: [Text("Logout"),Icon(Icons.exit_to_app_sharp)],))],), );
  }
}
//