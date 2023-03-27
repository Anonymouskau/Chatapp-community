import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Signin extends StatefulWidget {
  


  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  
   final TextEditingController cont1=TextEditingController();
   final TextEditingController cont2=TextEditingController();
   
  bool setlogin=false;
  @override
  Widget build(BuildContext context) {
    return   Column(children: [SizedBox(height: 50,),Center(child:Column(children: [ Icon(Icons.message,size: 100,color: Colors.blue,),Text(setlogin?"Welcome to WeChat!!":"WeChat ....",style: TextStyle(fontSize: 22),)],),),SizedBox(height: 50,),Container(alignment:Alignment.center,
    padding: EdgeInsets.all(7.0),
  
    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(30)),color: Colors.red.shade50),
   constraints: BoxConstraints(maxHeight: 300.0,
          // maxWidth: 200.0,
          minWidth: 150.0,
          minHeight: 150.0),
   child: Form(child: Column(children: [
    TextFormField(controller: cont1,keyboardType: TextInputType.emailAddress,decoration:InputDecoration(labelStyle: null,label: Text("Email",style: TextStyle(color: Colors.black,),)),)
  ,
   if(setlogin)
    TextFormField(autocorrect: true,keyboardType: TextInputType.emailAddress,decoration:InputDecoration(label: Text("Username",style: TextStyle(color: Colors.black),)),)
 ,
    TextFormField(controller: cont2,validator: (value)  {
    
    if(cont2.text.length>6){
      return "validUser";

    }
  
    }, obscureText: true,keyboardType: TextInputType.emailAddress,decoration:InputDecoration(label: Text("Password",style: TextStyle(color: Colors.black))),)
   
   ,
   SizedBox(height: 13,),
   ElevatedButton(onPressed: ()async{
    
    try{
        if(setlogin){
            await  FirebaseAuth.instance.createUserWithEmailAndPassword(email:cont1.text, password:cont2.text);
        }
        else{
          await FirebaseAuth.instance.signInWithEmailAndPassword(email: cont1.text, password: cont2.text).then((value) => Navigator.pushNamed(context,'/chat')).catchError((err)=>{
              
              print(err),
              showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Oops...😵‍💫😵😵😵'),
          content: const Text('Invalid credentials'),
          actions: <Widget>[
            
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),

   )});
        }
        
    }on FirebaseAuthException catch(e) {
      print(e);
                    
    } 
 
   }, child: Text(setlogin?"Sign Up":"Login")),
   TextButton(onPressed:(){
    setState(() {
      setlogin=!setlogin;
    });

    

   } , child: Text(setlogin?"Already have account?":"Create an account"))
       
   ],)),


    )],);
  }
}