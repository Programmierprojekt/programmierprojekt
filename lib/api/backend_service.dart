/// Kommunikation mit dem Backend
import "package:file_picker/file_picker.dart";
import "package:http/http.dart";
import "package:http_parser/http_parser.dart";
import 'package:programmierprojekt/Util/constants.dart';

Future<Response> sendRequest(MultipartRequest request) async {
  try {
    final response = await request.send();
    if (response.statusCode == 200) {
      return Response.fromStream(response);
    } else {
      throw Exception("Fehler: ${response.reasonPhrase}");
    }
  } catch (e) {
    rethrow;
  }
}

Future<String> checkConnectivity() async {
  final responseLocal =
      await performTest(Constants.BASE_URL_LOCAL, Constants.SERVER_CALL_DOCS);
  if (responseLocal == true) {
    return Constants.BASE_URL_LOCAL;
  }
  final responseServer =
      await performTest(Constants.BASE_URL_SERVER, Constants.SERVER_CALL_DOCS);
  if (responseServer == true) {
    return Constants.BASE_URL_SERVER;
  }
  return "";
}

Future<bool> performTest(String apiUrl, String apiPath) async {
  try {
    final requestUri = Uri.https(apiUrl, apiPath);
    final response = await get(requestUri);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    try {
      final requestUri = Uri.http(apiUrl, apiPath);
      final response = await get(requestUri);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}

MultipartRequest makePostMultipartFileFromBytes(
    Uri requestUri, PlatformFile file) {
  final request = MultipartRequest("POST", requestUri);
  request.headers.addAll({
    "accept": "application/json",
    "Content-Type": "multipart/form-data",
  });

  final multipartFile = MultipartFile.fromBytes(
    "file",
    file.bytes as List<int>,
    filename: file.name,
    contentType: MediaType("application", "vnd.ms-excel"),
  );
  request.files.add(multipartFile);
  return request;
}
