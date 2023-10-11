/// Kommunikation mit dem Backend
import "package:file_picker/file_picker.dart";
import "package:http/http.dart" as http;
import "package:http_parser/http_parser.dart";
import 'package:programmierprojekt/Util/constants.dart';

Future<http.Response> performClustering(PlatformFile file,
    {int? kCluster, int? distanceMetric, int? clusterDetermination}) async {
  final requestUri = makeUriForBackendProgbackLocal(
      kCluster, distanceMetric, clusterDetermination);

  final request = makePostMultipartFileFromBytes(requestUri, file);

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

/// siehe github: https://github.com/axellotl22/progback
Uri makeUriForBackendProgbackLocal(
    int? kCluster, int? distanceMetric, int? clusterDetermination) {
  const baseUrl = "localhost:8080";
  const path = "/clustering/perform-kmeans-clustering";

  final distMatric = Constants.METRIC_CHOICES[distanceMetric!];
  final clustDetermination =
      Constants.CLUSTER_DETERMINATION_CHOICES[clusterDetermination!];

  final queryParam = {
    'distanceMetric': distMatric.toUpperCase(),
    'clusterDetermination': clustDetermination.toUpperCase()
  };

  if (kCluster != 0) {
    queryParam.addAll({"kCluster": kCluster.toString()});
  }

  Uri requestUri = Uri.http(baseUrl, path, queryParam);
  return requestUri;
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

///Konnektivitöt des apiUrl prüfen
/// Beispiel: apiUrl="http://localhost:8080/clustering/perform-kmeans-clustering/?distanceMetric=EUCLIDEAN&clusterDetermination=ELBOW"
Future<bool> performTest(String apiUrl) async {
  final requestUri = Uri.parse(apiUrl);
  try {
    final response = await http.get(requestUri);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  } catch (e) {
    rethrow;
  }
}
