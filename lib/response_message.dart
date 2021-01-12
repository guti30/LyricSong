class ResponseMessage {
  String lyrics;
  Object error;

  ResponseMessage({this.lyrics, this.error});
  ResponseMessage.fromJson(Map json) {
    this.lyrics = json["lyrics"];
    this.error = json["error"];
  }
}
