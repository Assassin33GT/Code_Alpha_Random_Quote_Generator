import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:random_quote_generator/data.dart';
import 'package:share_plus/share_plus.dart';

class StartScreen extends StatefulWidget {
  const StartScreen(this.newImageC, this.screenSwitch, this.getQuote, {super.key});

  final void Function(String image) newImageC;
  final void Function(String s) screenSwitch;
  final void Function(String q) getQuote;
  @override
  State<StartScreen> createState(){
    return _StartScreenState();
  }  
}

class _StartScreenState extends State<StartScreen>{

  var newQuote = '';
  var newImage = '';
  var showHead = true;
  var showQuote = false;
  var showImage = false;

  String generateQuote(){
    final copyQuotes = List.of(quotes);
    copyQuotes.shuffle();
    if(copyQuotes[0] == newQuote){
      return copyQuotes[1];
    }
    else{
      return copyQuotes[0];
    }
  }

  String randomImages(){
    final copyImages = List.of(images);
    copyImages.shuffle();
    if(copyImages[0] == newImage){
      return copyImages[1];
    }else{
      return copyImages[0];
    }
  }

void showTextWithDelay() {
    setState(() {
      showQuote = false;
      
    });

    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        newQuote = generateQuote();
      });
    });

    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        showQuote = true;
      });
    });
  }

void showImageWithDelay(){
  setState(() {
    showHead = false;
    newImage = randomImages();
  });

  Timer(const Duration(milliseconds: 500),() {
    setState(() {
      widget.newImageC(newImage);
      showImage = true;
    });
  });
}
  @override
  Widget build(context){
    return Center(
      child: Stack(
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      if(showHead == true)
                      Center(
                        child: Text(
                          'Random Quote Generator',
                          style: GoogleFonts.montserrat(
                            fontSize: 46,
                            fontWeight: FontWeight.bold
                          ),
                          textAlign: TextAlign.center,
                          )),
                      Center(
                        child: AnimatedOpacity(
                          opacity: showQuote ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 900),
                          child: Text(
                            newQuote,
                            style: GoogleFonts.oswald(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                            textAlign: TextAlign.center,
                            ),
                        ),
                      ),
                        const SizedBox(height: 20,),
                     
                          Align(
                            alignment: const Alignment(0,0.4),
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: ElevatedButton(
                                  onPressed:(){
                                    setState(() {
                                      showTextWithDelay();
                                      showImageWithDelay();
                                    });
                                      showHead = false;
                                    },
                                  child: const Text(
                                    "Generate",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)
                                    ),
                                    )
                              ),
                            ),
                          ),
                          Align(
                            alignment: const Alignment(-0.7, 0.6),
                            child: ElevatedButton.icon(
                              onPressed: (){
                                if(newQuote.isEmpty){
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return const AlertDialog(
                                        content: Text('Generate a quote first!'),
                                      );
                                    }
                                    );
                                }
                                else{
                                  Share.share(newQuote);
                                }
                                },
                                icon: const Icon(Icons.share),
                              label: const Text(
                                'Share the quote',
                                style: TextStyle(
                                  color: Colors.black
                                ),
                                )
                              ),
                          ),
                          Align(
                            alignment: const Alignment(0.8, 0.6),
                            child: ElevatedButton.icon(
                              onPressed: (){
                                widget.getQuote(newQuote);
                              },
                              icon: const Icon(Icons.save_sharp),
                              label: const Text(
                                'Save the quote',
                                style: TextStyle(
                                  color: Colors.black
                                ),
                                ),
                              ),
                          ),
                          Align(
                            alignment: const Alignment(0.05, 0.75),
                            child: ElevatedButton(
                              onPressed: (){
                                widget.screenSwitch('saved-quotes');
                              },
                              child: const Text(
                                'Saved quotes',
                                style: TextStyle(
                                  color: Colors.black
                                ),
                                ),
                              ),
                          ),
                        ]
                      ),
              );
  }
}