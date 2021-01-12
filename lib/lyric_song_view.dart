import 'package:flutter/material.dart';


class LyricsView extends StatelessWidget {
  final String lyric;
  LyricsView(this.lyric);
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Lyrics Songs')),
      ),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Text(lyric, textAlign: TextAlign.center,style: TextStyle(color: Colors.black,fontSize: 20,),),
        ),),
    );
  }
}





