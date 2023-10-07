/// Kommunikation mit dem Backend
import "package:file_picker/file_picker.dart";
import "package:http/http.dart" as http;
import "package:http_parser/http_parser.dart";

/*
example:
curl -X "POST" \
  "http://localhost:8080/clustering/perform-kmeans-clustering/?distanceMetric=EUCLIDEAN&clusterDetermination=ELBOW" \
  -H "accept: application/json" \
  -H "Content-Type: multipart/form-data" \
  -F "file=@test.csv;type=application/vnd.ms-excel"
*/
Future<http.Response> performClustering(
  PlatformFile file, {
  int? kCluster,
  String distanceMetric = "EUCLIDEAN",
  String clusterDetermination = "ELBOW",
}) async {
  const apiUrl =
      "http://localhost:8080/clustering/perform-kmeans-clustering/?distanceMetric=EUCLIDEAN&clusterDetermination=ELBOW";

  final requestUri = Uri.parse(apiUrl);
  final request = http.MultipartRequest("POST", requestUri);
  request.headers.addAll({
    "accept": "application/json",
    "Content-Type": "multipart/form-data",
  });
  if (kCluster != null) {
    request.fields["kCluster"] = kCluster.toString();
  }
  final multipartFile = http.MultipartFile.fromBytes(
    "file",
    file.bytes as List<int>,
    filename: file.name,
    contentType: MediaType("application", "vnd.ms-excel"),
  );
  request.files.add(multipartFile);

  try {
    final response = await request.send();
    if (response.statusCode == 200) {
      return http.Response.fromStream(response);
    } else {
      print(response);
      print(response.statusCode);
      throw Exception("Fehler: ${response.reasonPhrase}");
    }
  } catch (e) {
    print("Exception: $e");
    throw e;
  }
}

Future<void> performTest() async {
  const apiUrl =
      "http://localhost:8080/clustering/perform-kmeans-clustering/?distanceMetric=EUCLIDEAN&clusterDetermination=ELBOW";

  final requestUri = Uri.parse(apiUrl);
  try {
    final response = await http.get(requestUri);

    if (response.statusCode == 200) {
      // Erfolgreiche Antwort
      final responseBody = response.body;
      print("Antwort: $responseBody");
    } else {
      // Fehlerhafte Antwort
      print("Fehler: ${response.statusCode}");
    }
  } catch (e) {
    // Fehler bei der Anfrage oder Verbindung
    print("Fehler: $e");
  }
}
