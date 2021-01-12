import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_retry/http_retry.dart';
import 'package:http/io_client.dart';

class HttpMethodsHandler {
  final JsonDecoder jsonDecoder = new JsonDecoder();
  final Map<String, String> header;

  HttpMethodsHandler(this.header);

  bool _hasError(int statusCode){
    return statusCode < 200 || statusCode > 400 || json == null;
  }

  Future<Map<dynamic, dynamic>> getWithRetry(int numRetries, String stackUrl, String url) async {
    Map bodyResponse;
    http.Response response;
    HttpClient retryClient = HttpClient();
    retryClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    IOClient ioClient = new IOClient(retryClient);
    final client = RetryClient(ioClient,
        retries: numRetries,
        onRetry: (http.BaseRequest request, http.BaseResponse response,
            int retryCount) =>
            print("Retrying $url : $retryCount"),
        when: (http.BaseResponse response) => _hasError(response.statusCode));
    try {
      response = await client.get(stackUrl + url,
          headers: header);
    } finally {
      client.close();
    }
    if (_hasError(response.statusCode)){
      throw new Exception("Error while fetching data");
    } else {
      Map value = jsonDecoder.convert(utf8.decode(response.bodyBytes));
      bodyResponse = value;
    }
    return bodyResponse;
  }
}