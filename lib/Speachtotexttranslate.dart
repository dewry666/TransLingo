import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translator/translator.dart';
import 'package:avatar_glow/avatar_glow.dart';

import 'package:texttospeachapp/utils/Colors.dart';
import 'package:texttospeachapp/utils/languages.dart';

class SpeachToTextTranslate extends StatefulWidget {
  const SpeachToTextTranslate({Key? key}) : super(key: key);

  @override
  _SpeachToTextTranslateState createState() => _SpeachToTextTranslateState();
}

class _SpeachToTextTranslateState extends State<SpeachToTextTranslate> {
  String? selectedto = "Filipino";
  bool isTranslate = true;
  var finaltext = "";
  final stt.SpeechToText _speachtotext = stt.SpeechToText();

  bool isListening = false;
  String speechToText = "Press mic and start speaking....";
  int initialindex = 2;
  final translator = GoogleTranslator();
  final FlutterTts flutterTts = FlutterTts();
  var output;

  Future<void> translate(String text, String lang) async {
    setState(() {
      isTranslate = true;
      output = null;
    });

    try {
      final translatedText = await translator.translate(text, to: lang);
      setState(() {
        output = translatedText;
      });

      await flutterTts.setLanguage(lang);
      await flutterTts.setPitch(0.7);
      await flutterTts.speak(output.toString());
    } catch (error) {
      setState(() {
        
        isTranslate = false;
        output = null;
      });
    }
  }

  void listen() async {
    if (isListening == false) {
      bool available = await _speachtotext.initialize(
        onStatus: (v) => {},
        onError: (v) => {},
      );
      if (available) {
        setState(() {
          isListening = true;
        });
        _speachtotext.listen(onResult: (value) {
          setState(() {
            speechToText = value.recognizedWords;
          });
        });
      }
    } else {
      setState(() {
        isListening = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
               const SizedBox(height: 50,),
               Container(
                width: 370,
                height: 170,
                decoration: BoxDecoration(
                  color: colorsUsed.cardcolor,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.25),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned(top: 20, left: 20,
                  child: Text(
                    speechToText,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 10,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: colorsUsed.cardcolor,
                        padding: const EdgeInsets.all(16),
                        elevation: 10,
                      ),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: speechToText));},
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
                  
                  const SizedBox(height: 25,),
                  Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Card(
                      color: colorsUsed.buttoncolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                        elevation: 25,
                        child: SizedBox(
                          height: 60,
                          width: 350,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text("Translate to:",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                                ),

                                Container(
                                  decoration: BoxDecoration(color: colorsUsed.buttoncolor),
                                  width: 150,
                                  child: DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      hoverColor: colorsUsed.color,
                                      fillColor: colorsUsed.buttoncolor,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                                        borderSide: BorderSide(
                                          width: 5,
                                          color: colorsUsed.buttoncolor),
                                          ),
                                        ),
                                        value: selectedto,
                                        items: Translation_languages.select_languages
                                        .map((language) => DropdownMenuItem<String>(
                                          value: language,
                                          child: Text(language,
                                          style:
                                          const TextStyle(
                                            color: Colors.black),
                                            ),
                                          )
                                        )
                                        .toList(),
                                        onChanged: (language) => setState(() => selectedto = language),
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.black,
                                        ),
                                        iconSize: 42,
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
                                    offset: const Offset(0, 3),
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
                                            backgroundColor: colorsUsed.bottomcolor,
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
                                                size: 30,),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        
                                        const SizedBox(width: 350, // Adjust the width of the SizedBox
                                        height: 20,
                                        ),
                                        Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              AvatarGlow(
                                                animate: isListening,
                                                glowColor: colorsUsed.iconcolor,
                                                endRadius: 50,
                                                duration: const Duration(milliseconds: 2000),
                                                repeatPauseDuration: const Duration(milliseconds: 100),
                                                repeat: true,
                                                
                                                child: SizedBox(
                                                  width: 75, // Adjust the width of the FloatingActionButton
                                                  height: 75, // Adjust the height of the FloatingActionButton
                                                  child: FloatingActionButton(
                                                    backgroundColor: colorsUsed.buttoncolor,
                                                    elevation: 10,
                                                    onPressed: () {
                                                      listen();
                                                      },
                                                      child: isListening
                                                      ? const Icon(
                                                        Icons.mic,
                                                        color: Colors.black,
                                                        size: 30, // Adjust the size of the mic icon
                                                        )
                                                        : const Icon(
                                                          Icons.mic_none,
                                                          color: Colors.black,
                                                          size: 30, // Adjust the size of the mic icon
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  
                                                  const SizedBox(width: 20),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      shape: const CircleBorder(),
                                                      padding: const EdgeInsets.all(30),
                                                      backgroundColor: colorsUsed.buttoncolor,
                                                      elevation: 10,
                                                      ),
                                                      onPressed: () {
                                                        setState(() {
                                                          isTranslate = false;
                                                          }
                                                        );
                                                        output = "";
                                                        setState(() {
                                                          finaltext = speechToText;
                                                          });
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
                                                        ]
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
