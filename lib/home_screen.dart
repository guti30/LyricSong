import 'package:flutter/material.dart';
import 'package:lyrics_song/lyrics_history.dart';
import 'package:lyrics_song/lyrics_search.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          Container(
            constraints: BoxConstraints.expand(height: 50),
            child: TabBar(
              labelColor: Colors.blueAccent,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(icon: Icon(Icons.music_note)),
                Tab(icon: Icon(Icons.history))
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: TabBarView(children: [
                LyricsSearch(),
                LyricsHistory(),
              ],
              ),
            ),
          )
        ],
      ),
    );
  }
}