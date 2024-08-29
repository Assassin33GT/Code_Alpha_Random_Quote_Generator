import 'package:flutter/material.dart';
import 'package:random_quote_generator/start_screen.dart';
//import 'package:video_player/video_player.dart';


class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() {
    return _StartPageState();
  }
}

class _StartPageState extends State<StartPage>{

  var activeScreen = 'start-screen';
  String im = '';
  
  var i = 0;
  void newImageC(String image){
    setState(() {
      im = image;  
    });
  }

  BoxDecoration changeImage(){
    if (i == 0)
    {
      i++;
      return const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.yellow,
                    Colors.orange
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight
                  ),
                );
        
    }else{
      return BoxDecoration(
              image: DecorationImage(
                image: AssetImage(im),
                fit: BoxFit.cover
                )
            );
    }
  }
  
  @override
  Widget build(contex) {
    Widget screenWidget = StartScreen(newImageC);
    
    return MaterialApp(
      home: Scaffold(
        body: AnimatedContainer(
          duration: const Duration(seconds: 1),
            decoration: changeImage(),
                child: screenWidget,
          ),
        ),
    );
  }
}