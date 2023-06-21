import 'dart:async';
import 'package:flutter/material.dart';
import 'package:texttospeachapp/home.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool selected = false;
  bool visible = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    settimer2();
    settimer();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Timer to set 'selected' and 'visible' variables
  settimer2() async {
    var duration = const Duration(seconds: 1);
    return Timer(duration, settrue);
  }

  // Set 'selected' and 'visible' variables
  settrue() {
    setState(() {
      selected = true;
      visible = true;
    });
  }

  // Timer to navigate to the second page
  settimer() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, secondpage);
  }

  // Navigate to the second page
  secondpage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  width: selected ? 250.0 : 100.0,
                  height: selected ? 250.0 : 100.0,
                  duration: const Duration(seconds: 1),
                  alignment: Alignment.center,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/translate-word.png"),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
    
          Positioned(
            bottom: 50, 
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FadeTransition(
                opacity: _animation,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    "TransLingo",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
