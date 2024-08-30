import 'package:flutter/material.dart';
import 'package:random_quote_generator/saved_quotes.dart';
import 'package:random_quote_generator/start_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  List<String> quotes = [];

  Future<void> saveQuotes(List<String> quotes) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('quotes', quotes);
  }

  Future<List<String>> getPrefs() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('quotes') ?? [];
  }

  @override
  void initState() {
    super.initState();
    _loadSavedQuotes();
  }
  
  Future<void> _loadSavedQuotes() async {
  quotes = await getPrefs();
  setState(() {});
}
  void screenSwitch(String s){
    setState(() {
      activeScreen = s;
    });
  }

  void newImageC(String image){
    setState(() {
      im = image;  
    });
  }

  BoxDecoration changeImage(){
    if (i == 0 && im == '')
    {
      i++;
      if(im == '')
        {
          i = 0;
        }
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

  void getQuote(String q) {
    bool check = false;
    for(int i = 0;i<quotes.length;i++){
      if(quotes[i] == q){
        check = true;
      }
    }
    if(check == false && q != ''){
      quotes.add(q);
      saveQuotes(quotes);
    }
  }
  
  @override
  Widget build(contex) {
    Widget screenWidget = StartScreen(newImageC, screenSwitch, getQuote);

    if (activeScreen == 'saved-quotes'){
      im = '';
      screenWidget = SavedQuotes(quotes, screenSwitch);
    }
    if (activeScreen == 'start-screen'){
      screenWidget = StartScreen(newImageC, screenSwitch, getQuote);
    }
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