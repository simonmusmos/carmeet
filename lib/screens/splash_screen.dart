import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maps/screens/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();

  // }
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => MainScreen())
    ));
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.black, Colors.black, Colors.black87],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          ),
        ),
        child: const Column(
            children: [
              SizedBox(height: 350,),
              const Image(
                image: AssetImage('assets/animations/intro.gif'),
                  height: 150,
                ),
              SizedBox(height: 0,),
              Text("MEET",
              style: TextStyle(
                color: Colors.white,
                fontSize: 45,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
              ),)
              
            ],
          )
      ),
    );
  }
}