class Song {
  String title;
  String artist;
  String lyric;


  Song(
      {this.title,
        this.artist,
        this.lyric,
      });

  Map<String, dynamic> toJson() => {
    'title': title,
    'artist': artist,
    'lyric': lyric,

  };



}

