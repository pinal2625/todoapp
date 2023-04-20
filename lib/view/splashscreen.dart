import 'package:flutter/material.dart';
import 'package:todoapp/res/constant/app_strings.dart';
import 'package:todoapp/res/constant/image.dart';
import 'package:todoapp/view/home_todo.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  nextScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
        (route) => false,
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    nextScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: SafeArea(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(SplashImage.appImage),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    AppStings.appName,
                    style: TextStyle(
                      color: Color(0xFFFF7074),
                      fontSize: 54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Gonuts with Donuts is a Sri Lanka"
                    "\ndedicated food outlets for specialize"
                    "\nmanufacturing of Donuts in Colombo,"
                    "\n Sri Lanka.",
                    style: TextStyle(color: Color(0xFFFF9494), fontSize: 18),
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
