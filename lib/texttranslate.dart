import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:texttospeachapp/utils/Colors.dart';
import 'package:texttospeachapp/utils/languages.dart';
import 'package:translator/translator.dart';

class TextTranslate extends StatefulWidget {
  const TextTranslate({Key? key}) : super(key: key);

  @override
  _TextTranslateState createState() => _TextTranslateState();
}

class _TextTranslateState extends State<TextTranslate> {
  String? selectedto = "Filipino";
  bool isTranslate = true;
  var finaltext = "";

  TextEditingController textController = TextEditingController();
  int initialindex = 1;
  final translator = GoogleTranslator();
  final FlutterTts flutterTts = FlutterTts();
  var output;

  translate(String text, String lang) async {
    await translator.translate(text, to: lang).then((value) {
      setState(() {
        output = value;
        isTranslate = true;
      });
    });
    await flutterTts.setLanguage(lang);
    await flutterTts.setPitch(0.7);
    await flutterTts.speak(output.toString());
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    extendBody: true,
    body: Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 50),
              // Input card
              Card(
                color: colorsUsed.cardcolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 25,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 350,
                    height: 150,
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      controller: textController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Enter Text to Translate',
                        labelStyle: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none, // Removed outline border
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none, // Removed outline border
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 25),// Language selection card
              Padding(
                padding: const EdgeInsets.only(left: 25, right: 25),
                child: Card(
                  color: colorsUsed.buttoncolor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    ),
                    elevation: 25,
                    child: Container(
                      height: 60,
                      width: 350,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text("Translate to:",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        
                        Container(
                          decoration: BoxDecoration(color: colorsUsed.buttoncolor),
                          width: 150,
                          child: DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              hoverColor: colorsUsed.color,
                              fillColor: colorsUsed.buttoncolor,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(Radius.circular(10),
                              ),
                              borderSide: BorderSide(
                                width: 5,
                                color: colorsUsed.buttoncolor,
                              ),
                            ),
                          ),
                          
                          value: selectedto,
                          items: Translation_languages.select_languages
                          .map(
                            (language) => DropdownMenuItem<String>(
                              value: language,
                              child: Text(
                                language,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                          onChanged: (language) =>
                          setState(() => selectedto = language),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                            ),
                            iconSize: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              
              const SizedBox(height: 10),
              Container(
                width: 350,
                height: 150,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: colorsUsed.bottomcolor,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          output == null ? "" : output.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          primary: colorsUsed.bottomcolor,
                          padding: const EdgeInsets.all(16),
                          elevation: 10,
                        ),
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(text: output.toString()),
                            );
                          },
                          child: const Icon(
                            Icons.copy,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 50),
                Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(30),
                          primary: colorsUsed.buttoncolor,
                          elevation: 10, // Set the elevation value for shadow effect
                        ),
                        onPressed: () {
                          setState(() {
                            isTranslate = false;
                          }
                        );
                        output = "";
                        setState(() {
                          finaltext = textController.text;
                          }
                        );
                        translate(
                          finaltext,
                          Translation_languages.getLanguageCode(selectedto!),
                          );
                        },
                        child: isTranslate
                        ? const Icon(
                          Icons.translate,
                          color: Colors.black,
                          size: 30,
                        )
                        : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            color: colorsUsed.textcolor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}