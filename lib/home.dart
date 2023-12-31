import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:texttospeachapp/Speachtotexttranslate.dart';
import 'package:texttospeachapp/texttranslate.dart';
import 'package:texttospeachapp/utils/Colors.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  
  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  var initialindex = 0;
  var currentindex = 0;
  var screens = [
    const TextTranslate(),
    const SpeachToTextTranslate()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    extendBody: true,
    appBar: AppBar(
      backgroundColor: colorsUsed.bottomcolor,
      title: Center(
        child: Text(
          "TransLingo",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
        )),
      ),
      ),
    ),
      body: screens[currentindex],
      bottomNavigationBar: CurvedNavigationBar(
        
        color: colorsUsed.bottomcolor,
        index: initialindex,
        height: 50,
        backgroundColor: Colors.transparent,
        items: iconUsed.items,
        onTap: (index) {
          setState(() {
                      currentindex = index;

          });

          // if (index == 0) {
          // } else if (index == 1) {
          //   Navigator.pushReplacement(
          //     context,
          //     PageRouteBuilder(
          //       pageBuilder: (context, animation1, animation2) =>
          //           TextTranslate(),
          //       transitionDuration: Duration(seconds: 0),
          //     ),
          //   );
          //   // Navigator.pushReplacement(context,
          //   //     MaterialPageRoute(builder: (context) => const TextTranslate()));
          // } else if (index == 2) {
          //   Navigator.pushReplacement(
          //     context,
          //     PageRouteBuilder(
          //       pageBuilder: (context, animation1, animation2) =>
          //           SpeachToTextTranslate(),
          //       transitionDuration: Duration(seconds: 0),
          //     ),
          //   );
          // Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => const SpeachToTextTranslate()));
          // }
        },
      ),
    );
  }
}
