// ignore_for_file: constant_identifier_names

class Constants {
  //Button Texte
  static const String BTN_CHOOSE_ALGORITHM = "Algorithmus";
  static const String BTN_ADD = "Hinzufügen";
  static const String BTN_IMPORT = "Import";
  static const String BTN_CALCULATE = "Berechnen";
  static const String BTN_YES = "Ja";
  static const String BTN_NO = "Nein";
  static const String BTN_DELETE_ITEM = "Datenpunkt löschen";
  static const String BTN_EXPORT = "Exportieren";
  static const String BTN_DISTANCE_METRIC = "Distanzmetrik";
  static const String BTN_CLUSTER_DETERMINATION = "Klusterbestimmung";
  static const String BTN_CHANGE_MODE = "Modus ändern";

  //Dialog Titel
  static const String DLG_TITLE_DEL_ITEMS = "Datenpunkte löschen";
  static const String DLG_TITLE_MODIFY_ITEM = "Datenpunkt anpassen";
  static const String DLG_TITLE_IMPORT_ABORT = "Import-Abbruch";
  static const String DLG_TITLE_CHANGE_OPERATING_MODE =
      "Operationsmodus ändern";
  static const String DLG_TITLE_HINT = "Hinweis";
  static const String DLG_TITLE_DELIM = "Trennzeichenauswahl";
  static const String DLG_TITLE_NO_CONNECTION = "Keine Verbindung";
  static const String DLG_TITLE_SERVER_RESPONSE_NOT_VALID =
      "Fehler beim Server";

  //Dialog Content
  static const String DLG_CNT_SERVER_NOT_AVAILABLE =
      "Der Server ist nicht erreichbar.";
  static const String DLG_CNT_SERVER_RESPONSE_NOT_VALID =
      "Die Antwort des Servers ist fehlerhaft.";

  //Labels
  static const String APP_TITLE = "SmartClassificator";
  static const String ABORT_TEXT = "Abbruch";
  static const String OK_TEXT = "OK";
  static const String X_VALUE_TEXT = "x-Wert";
  static const String Y_VALUE_TEXT = "y-Wert";
  static const String OPERATING_MODE_LOCAL = "Lokal";
  static const String OPERATING_MODE_SERVER = "Server";
  static const String ADD_DATA_POINT_ERROR = "Sie müssen Zahlen eingeben.";
  static const String K_CLUSTER_TEXT = "kCluster";
  static const String INFORMATION = "Information";

  //Mixed
  static const String CHANGE_TITLE = "Titel ändern";
  static const String CHANGE_X_TITLE = "X-Titel ändern";
  static const String CHANGE_Y_TITLE = "Y-Titel ändern";

  static const METRIC_CHOICES = ["Euclidean", "Manhattan", "Jaccards"];
  static const CLUSTER_DETERMINATION_CHOICES = ["Elbow", "Silhouette"];

  static const METRIC_CHOICES_LOCAL = ["Euclidean"];
  static const CLUSTER_DETERMINATION_CHOICES_LOCAL = ["Elbow"];

  //Backend Kmeans
  static const METRIC_CHOICES_SERVER = ["Euclidean", "Manhattan", "Jaccards"];
  static const CLUSTER_DETERMINATION_CHOICES_SERVER = ["Sillhouette"];

  static const SERVER_CALLS_KMEANS = ["2d-kmeans", "3d-kmeans", "nd-kmeans"];
  static const SERVER_CALL_PREFIX = [
    "/basic/perform-",
    "/advanced/perform-advanced-"
  ];

  //Backend CART
  static const SERVER_CALL_CART =
      "/classification_decision_tree/perform-classification-decision-tree/";
  static const SERVER_CALL_DETERMINATION = "/determination/elbow";
  static const SERVER_CALL_HEALTHCHECK = "/health";
  static const SERVER_CALL_DOCS = "/docs";

  //Basic Backend
  static const BASE_URL_SERVER = "beta.axellotl.de";
  static const BASE_URL_LOCAL = "localhost:8080";

  static const int MAX_FILE_SIZE = 1000000; //1 Mb max. Dateigröße
}
