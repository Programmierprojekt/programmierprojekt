/// Kommunikation mit dem Backend
import "package:file_picker/file_picker.dart";
import "package:http/http.dart" as http;
import "package:http_parser/http_parser.dart";
import 'package:programmierprojekt/Util/constants.dart';

Future<http.Response> sendRequest(http.MultipartRequest request) async {
  try {
    final response = await request.send();
    if (response.statusCode == 200) {
      return http.Response.fromStream(response);
    } else {
      throw Exception("Fehler: ${response.reasonPhrase}");
    }
  } catch (e) {
    rethrow;
  }
}

Future<String> checkConnectivity() async {
  final responseServer = await performTest(
      Constants.BASE_URL_SERVER + Constants.SERVER_CALL_HEALTHCHECK);
  if (responseServer == true) {
    return Constants.BASE_URL_SERVER;
  }
  final responseLocal = await performTest(
      Constants.BASE_URL_LOCAL + Constants.SERVER_CALL_HEALTHCHECK);
  if (responseLocal == true) {
    return Constants.BASE_URL_LOCAL;
  }
  return "";
}

Future<bool> performTest(String apiUrl) async {
  final requestUri = Uri.parse(apiUrl);
  final response = await http.get(requestUri);

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

http.MultipartRequest makePostMultipartFileFromBytes(
    Uri requestUri, PlatformFile file) {
  final request = http.MultipartRequest("POST", requestUri);
  request.headers.addAll({
    "accept": "application/json",
    "Content-Type": "multipart/form-data",
  });

  final multipartFile = http.MultipartFile.fromBytes(
    "file",
    file.bytes as List<int>,
    filename: file.name,
    contentType: MediaType("application", "vnd.ms-excel"),
  );
  request.files.add(multipartFile);
  return request;
}
