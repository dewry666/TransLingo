import 'package:flutter/material.dart';

class colorsUsed {
  static final Color color = Colors.grey.shade200;
  static final Color buttoncolor = Color.fromARGB(255, 249, 217, 73);
  static final Color cardcolor = Color.fromARGB(255, 57, 63, 70);
  static final Color appbarbackgroundColor = Colors.grey.shade200;
  static final Color bottomcolor = Color.fromARGB(255, 109, 152, 134);
  static final Color dropdowncolor = Colors.grey.shade200;
  static final Color textcolor = Colors.deepPurpleAccent.shade700;
  static final Color iconcolor =  Color.fromARGB(255, 249, 217, 73);
}

class iconUsed {
  static final items = <Widget>[
   
     Icon(Icons.text_fields_rounded, color: colorsUsed.iconcolor),
    Icon(
      Icons.mic_sharp,
      color: colorsUsed.iconcolor,
    ),
  ];
}
