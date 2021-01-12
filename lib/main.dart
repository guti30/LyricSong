import 'package:flutter/material.dart';
import 'package:lyrics_song/home_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lyrics Songs',

      theme: ThemeData(

        primaryColor: Colors.blueGrey,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text('Lyrics Songs')),
        ),
        body: HomeScreen() ,
      ),
    );
  }
}

