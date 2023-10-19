<<<<<<< HEAD
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart';
import 'package:programmierprojekt/Util/constants.dart';
import 'package:programmierprojekt/api/backend_service.dart';

Future<Response> performCart(
    PlatformFile file, String? baseUrl, String? columnName) async {
  if (baseUrl == "" || baseUrl == null) {
    throw Exception("Keine Anbindung");
  }

  Map<String, String> queryParameter = {
    "SampleCount4Split": "2",
    "max_depth": "100",
    "SplitStrategy": "Best Split",
    "ClassColumnName": columnName!,
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
=======
>>>>>>> 7b5bc8b459b24bdccdc6715b2e4ce243d757e5f2
