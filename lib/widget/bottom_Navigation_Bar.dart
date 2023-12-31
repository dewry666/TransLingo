import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:texttospeachapp/texttranslate.dart';

class BottomNavigationBar extends StatefulWidget {
  const BottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<BottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    Color bottomcolor = Colors.grey.shade400;
    int initialindex = 0;
    final items = <Widget>[
      const Icon(Icons.text_fields_rounded, color: Colors.deepPurpleAccent),
    ];
    return CurvedNavigationBar(
      color: bottomcolor,
      index: initialindex,
      height: 50,
      backgroundColor: Colors.transparent,
      items: items,
      onTap: (index) {
        if (index == 0) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TextTranslate()));
        }
      },
    );
  }
}
