import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import 'package:programmierprojekt/Util/constants.dart';
import 'package:programmierprojekt/api/backend_service.dart';

Future<Response> performCart(
    PlatformFile file, String? baseUrl, String? csvDelimiter) async {
  if (baseUrl == "" || baseUrl == null) {
    throw Exception("Keine Anbindung");
  }
  final decodedData = utf8.decode(file.bytes as List<int>);
  List<String> lines =
      decodedData.replaceAll("\r\n", "\n").replaceAll("\r", "\n").split("\n");
  final headLine = lines.elementAt(0).split(csvDelimiter as Pattern)[0];
  Map<String, String> queryParameter = {
    "SampleCount4Split": "2",
    "max_depth": "100",
    "SplitStrategy": "Best Split",
    "ClassColumnName": headLine.toString(),
    "BestSplitStrategy": "Information Gain",
    "Pruning%3F": "false"
  };

  Response cartReponse;
  try {
    final requestUri =
        Uri.https(baseUrl, Constants.SERVER_CALL_CART, queryParameter);
    final request = makePostMultipartFileFromBytes(requestUri, file);

    cartReponse = await sendRequest(request);
  } catch (e) {
    try {
      final requestUri =
          Uri.http(baseUrl, Constants.SERVER_CALL_CART, queryParameter);
      final request = makePostMultipartFileFromBytes(requestUri, file);

      cartReponse = await sendRequest(request);
    } catch (e) {
      throw ("");
    }
  }
  return cartReponse;
}
