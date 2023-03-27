
import 'package:chat_app/Screens/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChatScreen extends StatefulWidget {
  
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  @override  
  Widget build(BuildContext context) {
   final TextEditingController searchController=TextEditingController();
   final user=FirebaseAuth.instance.currentUser;
   
    return Scaffold(
      appBar: AppBar(title: Text("Community"),),
      drawer: drawer(),
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
           
          SizedBox(child:StreamBuilder(stream:FirebaseFirestore.instance.collection("Chats").orderBy("createdAt").snapshots(),builder:(ctx,stream){
           if(stream.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
           }
            final document=stream.data?.docs;
            return
            ListView.builder(itemCount:document?.length,itemBuilder: (context, index) {
            return !(document?[index]["uid"]==user?.uid)? Align(alignment: Alignment.topLeft,child: Container(decoration: BoxDecoration(color: Colors.white  ,borderRadius: BorderRadius.all(Radius.circular(20))),child: Stack(children: [Text(document![index]["text"]),SizedBox(height: 2,)]),padding:EdgeInsets.all(12.0) ,)):
            Align(alignment: Alignment.topRight,child: Container(decoration: BoxDecoration(color: Colors.lightBlue,borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight:Radius.circular(20),bottomLeft: Radius.circular(20 ) )),child: Stack(children: [Text(document![index]["text"]),SizedBox(height: 2,)]),padding:EdgeInsets.all(12.0) ,));
          
          },);
          } ) ,height: 300,) 
               ,Align(child: Padding(
          padding: EdgeInsets.all(3.0),
          child:
          TextField(
            controller: searchController,
            decoration: InputDecoration(
                icon: Icon(Icons.messenger),
                hintText: "Chat ...",
                border: OutlineInputBorder()
            ), //decoration
          ), //textfield
        ), // padding,alignment: Alignment.bottomRight   ,),
         
      )],
      ),
  floatingActionButton: FloatingActionButton(child:Icon(Icons.send) ,onPressed: () async{

    await FirebaseFirestore.instance.collection("Chats").add({"text":searchController.text,
       "createdAt":Timestamp.now(),
       "uid":user?.uid});
    searchController.clear();
    FocusScope.of(context).unfocus();
    
  },), );
      }
}