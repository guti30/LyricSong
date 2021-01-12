import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:lyrics_song/lyric_song_view.dart';
import 'package:lyrics_song/lyrics_search_provider.dart';
import 'package:lyrics_song/response_message.dart';
import 'package:lyrics_song/song.dart';
import 'package:lyrics_song/constants.dart' as Constants;

class LyricsSearch extends StatefulWidget {
  LyricsSearch();
  @override
  _LyricsSearchState createState() => _LyricsSearchState();
}

class _LyricsSearchState extends State<LyricsSearch>
    with SingleTickerProviderStateMixin {
  final LocalStorage storage = new LocalStorage(Constants.LOCAL_STORAGE_KEY);
  TextEditingController title = TextEditingController();
  TextEditingController artist = TextEditingController();
  String lyric = "";
  List songsHistory = [];
  List songsHistoryStorage = [];
  bool loading = false;
  bool visible = false;
  bool successful = false;
  Song song = Song();
  @override
  void initState() {
    super.initState();
    song.title = "";
    song.artist = "";
    song.lyric = "";
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                  labelText: 'Song Title',
                ),
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: TextField(
              controller: artist,
              decoration: InputDecoration(
                labelText: 'Artist',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Ink(
              decoration: const ShapeDecoration(
                color: Colors.blueGrey,
                shape: CircleBorder(),
              ),
              child: IconButton(
                icon: Icon(Icons.search, size: 35),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    loading = true;
                    visible = false;
                  });
                  searchLyric();
                },
              ),
            ),
          ),
          successful
              ? Column(
                  children: <Widget>[
                    Text("Previous search:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Artist: ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            song.artist,
                            style: TextStyle(fontSize: 15),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Song Title: ",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            song.title,
                            style: TextStyle(fontSize: 15),
                          ),
                        ]),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: IconButton(
                        icon: Icon(Icons.search, size: 35),
                        color: Colors.blueGrey,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LyricsView(song.lyric)),
                          );
                        },
                      ),
                    )
                  ],
                )
              : Container(),
          loading
              ? Center(child: new CircularProgressIndicator())
              : Container(),
          visible
              ? Center(
                  child: Text("No lyrics found",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                )
              : Container()
        ],
      ),
    );
  }

  void searchLyric() async {
    LyricsSearchProvider lyricsSearchProvider = LyricsSearchProvider();
    try {
      ResponseMessage responseMessage = await lyricsSearchProvider
          .getLyricsByTitleAndArtist(artist.text, title.text);
      setState(() {
        loading = false;
      });
      if (responseMessage.lyrics != "") {
        setState(() {
          successful = true;
          song.artist = artist.text;
          song.title = title.text;
          song.lyric = responseMessage.lyrics;
          songsHistory.add(song);
        });
        songsHistoryStorage =
            storage.getItem(Constants.LOCAL_STORAGE_KEY) ?? [];
        songsHistory.addAll(songsHistoryStorage);
        storage.setItem(Constants.LOCAL_STORAGE_KEY, songsHistory);

        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LyricsView(responseMessage.lyrics)),
        );
      } else {
        setState(() {
          visible = true;
        });
      }
    } catch (error) {
      setState(() {
        loading = false;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onConnexionError(context, "Error while try to search lyric song");
      });
    }
  }

  onConnexionError(BuildContext context, String content) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(15)),
            actions: <Widget>[
              FlatButton(
                child: Text("Closed"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
