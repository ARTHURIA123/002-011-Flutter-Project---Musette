import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';
class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}
class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Reset Page",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "Enter Your Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20))),
             ),
           ),
         ElevatedButton(onPressed: () {
           FirebaseAuth.instance.sendPasswordResetEmail(email: controller.text).then((value){
             Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()));
           });
         }, child: Text("Reset Password"))
       ],
     ),
    );
  }

}