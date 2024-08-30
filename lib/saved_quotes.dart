import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedQuotes extends StatelessWidget {
  const SavedQuotes(this.savedQuotes, this.screenSwitch, {super.key});

  final List<String> savedQuotes;
  final void Function (String q) screenSwitch;

  @override
  Widget build(context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40,),
            Center(
              child: Text(
                'Saved Quotes',
                style: GoogleFonts.montserrat(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                ),
                )),
            const SizedBox(height: 30,),
            ...savedQuotes.map((value){
              return Text(
                '-$value',
                style: GoogleFonts.oswald(
                                color: Colors.white,
                                fontSize: 22,
                              ),
                      
                );
            }),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: (){
                    screenSwitch('start-screen');
                  },
                  child: const Text(
                    'Home Screen',
                    style: TextStyle(
                      color: Colors.black
                    ),
                    ),
                ),
              ],
            ),
            const SizedBox(height: 800,),
          ],
        
        ),
      ),
    );
  }
}