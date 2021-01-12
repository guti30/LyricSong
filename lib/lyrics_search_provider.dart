import 'package:lyrics_song/http_methods_handler.dart';
import 'package:lyrics_song/response_message.dart';

class LyricsSearchProvider {
  HttpMethodsHandler _httpMethodsHandler;


  LyricsSearchProvider() : super() {
    Map<String, String> header = {
      "Content-Type": "application/json",
    };
    this._httpMethodsHandler = HttpMethodsHandler(header);
  }


  Future<ResponseMessage> getLyricsByTitleAndArtist(String artist,
      String titleSong) async {
    Map response =
    await _httpMethodsHandler.getWithRetry(2, "https://api.lyrics.ovh/v1", "/" + artist + "/" + titleSong);
    if (response != null) {
      var rest = ResponseMessage.fromJson(response);
      return rest;
    }
    return null;
  }
}