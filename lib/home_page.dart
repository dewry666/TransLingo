import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:texttospeachapp/Speachtotexttranslate.dart';
import 'package:texttospeachapp/texttranslate.dart';
import 'package:texttospeachapp/utils/Colors.dart';

class Home_Page extends StatefulWidget {
  const Home_Page({Key? key}) : super(key: key);

  @override
  State<Home_Page> createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {
  @override
  Widget build(BuildContext context) {
    int pageno = 1;
    whichpage() {
      if (pageno == 0) {
      } else if (pageno == 1) {
        return const SpeachToTextTranslate();
      } else {
        return const TextTranslate();
      }
    }

    return Scaffold(
      body: whichpage(),
      bottomNavigationBar: CurvedNavigationBar(
        color: colorsUsed.buttoncolor,
        index: 1,
        height: 40,
        backgroundColor: Colors.transparent,
        items: iconUsed.items,
        onTap: (index) {
          if (index == 0) {
            setState(() {
              pageno = 0;
            });
            whichpage();
          } else if (index == 1) {
            setState(() {
              pageno = 1;
            });
          }
        },
      ),
    );
  }
}
