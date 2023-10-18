import "package:file_picker/file_picker.dart";
import "package:http/http.dart";
import 'package:programmierprojekt/Util/constants.dart';
import "backend_service.dart";

Future<Response> performKmeans(String task, PlatformFile file,
    {int? kCluster, int? distanceMetric, String? baseUrl}) async {
  if (baseUrl == "" || baseUrl == null) {
    throw Exception("Keine Anbindung");
  }

  if (task == Constants.SERVER_CALLS_KMEANS[0]) {
    ///"column1": "0",
    ///"column2": "1",
  } else if (task == Constants.SERVER_CALLS_KMEANS[1]) {
    ///"column1": "0",
    ///"column2": "1",
    ///"column3": "1",
  } else if (task == Constants.SERVER_CALLS_KMEANS[2]) {
    ///"use_3d_model": false
  } else {
    throw Exception("Fehler: keine gültige Methode");
  }

  String path;
  final distMatric = Constants.METRIC_CHOICES_SERVER[distanceMetric!];
  Map<String, String> queryParameter = {
    "distance_metric": distMatric.toUpperCase(),
    "kmeans_type": "OptimizedKMeans", //OptimizedMiniBatchKMeans
    "normalize": "false",
    "user_id": "0",
    "request_id": "0",
  };

  if (kCluster != 0) {
    path = "${Constants.SERVER_CALL_PREFIX[0]}$task/";
    queryParameter.addAll({"k_clusters": kCluster.toString()});
  } else {
    path = "${Constants.SERVER_CALL_PREFIX[1]}$task/";
  }
  Response kmeansReponse;
  try {
    final requestUri = Uri.https(baseUrl, path, queryParameter);
    final request = makePostMultipartFileFromBytes(requestUri, file);

    kmeansReponse = await sendRequest(request);
  } catch (e) {
    try {
      final requestUri = Uri.http(baseUrl, path, queryParameter);
      final request = makePostMultipartFileFromBytes(requestUri, file);

      kmeansReponse = await sendRequest(request);
    } catch (e) {
      throw ("");
    }
  }
  return kmeansReponse;
}
