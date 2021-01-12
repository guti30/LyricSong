import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:lyrics_song/constants.dart' as Constants;
import 'package:lyrics_song/lyric_song_view.dart';

class LyricsHistory extends StatefulWidget {
  LyricsHistory();
  @override
  _LyricsHistoryState createState() => _LyricsHistoryState();
}

class _LyricsHistoryState extends State<LyricsHistory>
    with SingleTickerProviderStateMixin {
  final LocalStorage storage = new LocalStorage(Constants.LOCAL_STORAGE_KEY);
  bool emptyList = true;
  List songsHistory;

  @override
  void initState() {
    super.initState();
    songsHistory = storage.getItem(Constants.LOCAL_STORAGE_KEY) ?? [];
    if (songsHistory != []) {
      emptyList = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return emptyList
        ? Center(
            child: Text("The history is empty", style: TextStyle(fontSize: 18)))
        : ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(
                  songsHistory[index].title,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  songsHistory[index].artist,
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LyricsView(songsHistory[index].lyric)),
                  );
                },
                //subtitle: Text(user.email),
              );
            },
            separatorBuilder: (context, index) => Divider(
                  color: Colors.black12,
                  thickness: 2,
                ),
            itemCount: songsHistory.length);
  }
}
