import 'package:flutter/material.dart';
import '../Components/userInput.dart';

class LoginPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Login"),
      ),
      body: UserInput(),
    );
  }
}