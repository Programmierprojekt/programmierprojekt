// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:js' as js;
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/custom_widgets.dart';
import 'package:programmierprojekt/Custom/data_point_model.dart';
import 'package:programmierprojekt/Util/constants.dart';
import 'package:programmierprojekt/Util/system_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OutputPage extends StatefulWidget {
  final DataPoints inputDataPoints;
  final DataPoints outputDataPoints;
  final SystemManager manager;

  const OutputPage(
      {required this.inputDataPoints, required this.outputDataPoints, required this.manager, Key? key})
      : super(key: key);

  @override
  State<OutputPage> createState() => _OutputPageState();
}

class _OutputPageState extends State<OutputPage> {
  double aspectRatioValue = 5;
  int displayType = 0;
  SystemManager? manager;
  DataPoints? inputDataPoints;
  DataPoints? outputDataPoints;

  late String inputChartTitle;
  late String outputChartTitle;
  late String inputXTitle;
  late String inputYTitle;
  late String outputXTitle;
  late String outputYTitle;

  @override
  void initState() {
    super.initState();
    inputDataPoints = widget.inputDataPoints;
    outputDataPoints = widget.outputDataPoints;
    manager = widget.manager;
    //print(manager!.algorithmType);
    if (manager!.algorithmType == 0) {
      //KMeans ausführen
      if (manager!.operatingMode) {
        calculateKMeans(); //Lokal
      } else {
        kMeansServer(); //Server
      }
    } else {}
    inputChartTitle =
        html.window.localStorage["inputChartTitle"] ?? "Datenvorschau";
    outputChartTitle =
        html.window.localStorage["outputChartTitle"] ?? "Clustered";
    inputXTitle = html.window.localStorage["inputXTitle"] ?? "x-Achse";
    inputYTitle = html.window.localStorage["inputYTitle"] ?? "y-Achse";
    outputXTitle = html.window.localStorage["outputXTitle"] ?? "x-Achse";
    outputYTitle = html.window.localStorage["outputYTitle"] ?? "y-Achse";
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: manager!,
        builder: (context, child) =>
            ListView(
                shrinkWrap: true,
                children: buildGraphicsRepresentation(context)));
  }

  List<Widget> buildGraphicsRepresentation(BuildContext context) {
    if (manager!.algorithmType == 0) {
      var theme = Theme.of(context);

      var colors = <int, Color>{};

      for (var point in outputDataPoints!.points) {
        if (colors[point.clusterNumber] == null) {
          var random = Random();

          const a = 255;
          var r = random.nextInt(256);
          var g = random.nextInt(256);
          var b = random.nextInt(256);

          colors[point.clusterNumber] = Color.fromARGB(a, r, g, b);
        }
      }

      return
        build2DGraphicRepresentation(theme, colors);
    } else {
      return [
        //TODO: BildGrafik anzeigen
      ];
    }
  }

  List<Widget> build2DGraphicRepresentation(theme, colors) {
    if (manager!.choosenfileKmeansDimensionType ==
        Constants.SERVER_CALLS_KMEANS[0]) {
      return [
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: CustomWidgets.customElevatedButton(
                  text: Constants.CHANGE_TITLE,
                  onPressed: () {
                    CustomWidgets.showTextfieldDialog(
                        context, theme, inputChartTitle, Constants.CHANGE_TITLE,
                            (newText) {
                          setState(() {
                            inputChartTitle = newText;
                            html.window.localStorage["inputChartTitle"] =
                                newText;
                          });
                        });
                  }),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomWidgets.customElevatedButton(
                  text: Constants.CHANGE_X_TITLE,
                  onPressed: () {
                    CustomWidgets.showTextfieldDialog(
                        context, theme, inputXTitle, Constants.CHANGE_X_TITLE,
                            (newText) {
                          setState(() {
                            inputXTitle = newText;
                            html.window.localStorage["inputXTitle"] = newText;
                          });
                        });
                  }),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: CustomWidgets.customElevatedButton(
                  text: Constants.CHANGE_Y_TITLE,
                  onPressed: () {
                    CustomWidgets.showTextfieldDialog(
                        context, theme, inputYTitle, Constants.CHANGE_Y_TITLE,
                            (newText) {
                          setState(() {
                            inputYTitle = newText;
                            html.window.localStorage["inputYTitle"] = newText;
                          });
                        });
                  }),
            )
          ],
        ),
        SfCartesianChart(
          title: ChartTitle(text: inputChartTitle),
          primaryXAxis: NumericAxis(
              title: AxisTitle(text: inputXTitle),
              majorGridLines: const MajorGridLines(width: 1),
              axisLine: const AxisLine(width: 1)),
          primaryYAxis: NumericAxis(
              title: AxisTitle(text: inputYTitle),
              axisLine: const AxisLine(width: 1),
              axisBorderType: AxisBorderType.rectangle,
              majorGridLines: const MajorGridLines(width: 1)),
          tooltipBehavior: TooltipBehavior(enable: false),
          series: [
            ScatterSeries(
              dataSource: inputDataPoints!.points,
              xValueMapper: (singlePoint, index) => singlePoint.coords[0],
              yValueMapper: (singlePoint, index) => singlePoint.coords[1],
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          thickness: 8,
        ),
        const SizedBox(
          height: 10,
        ),
        manager!.calculateFinished
            ? Column(children: [
          const SizedBox(width: 10),
          Wrap(
            runSpacing: 5,
            children: [
              for(var color in colors.entries)
                Wrap(
                  spacing: 5,
                  children: [
                    Container(height: 15, width: 40, color: color.value),
                    Text("Cluster ${color.key}"),
                    const SizedBox(width: 10),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: CustomWidgets.customElevatedButton(
                    text: Constants.CHANGE_TITLE,
                    onPressed: () {
                      CustomWidgets.showTextfieldDialog(
                          context,
                          theme,
                          outputChartTitle,
                          Constants.CHANGE_TITLE, (newText) {
                        setState(() {
                          outputChartTitle = newText;
                          html.window.localStorage["outputChartTitle"] =
                              newText;
                        });
                      });
                    }),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomWidgets.customElevatedButton(
                    text: Constants.CHANGE_X_TITLE,
                    onPressed: () {
                      CustomWidgets.showTextfieldDialog(
                          context,
                          theme,
                          outputXTitle,
                          Constants.CHANGE_X_TITLE, (newText) {
                        setState(() {
                          outputXTitle = newText;
                          html.window.localStorage["outputXTitle"] =
                              newText;
                        });
                      });
                    }),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomWidgets.customElevatedButton(
                    text: Constants.CHANGE_Y_TITLE,
                    onPressed: () {
                      CustomWidgets.showTextfieldDialog(
                          context,
                          theme,
                          outputYTitle,
                          Constants.CHANGE_Y_TITLE, (newText) {
                        setState(() {
                          outputYTitle = newText;
                          html.window.localStorage["outputYTitle"] =
                              newText;
                        });
                      });
                    }),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomWidgets.customElevatedButton(
                    text: Constants.BTN_EXPORT,
                    onPressed: () {
                      var clustersTxt = "";

                      for (int i = 0; i <
                          outputDataPoints!.centroids.length; i++) {
                        clustersTxt += "{ ";

                        String centroidCoords = outputDataPoints!.centroids[i]
                            .coords.join(",");

                        String pointsStr = "";

                        for (int k = 0; k <
                            outputDataPoints!.points.length; k++) {
                          if (i + 1 !=
                              outputDataPoints!.points[k].clusterNumber) {
                            continue;
                          }

                          pointsStr += "[";
                          pointsStr +=
                              outputDataPoints!.points[k].coords.join(",");
                          pointsStr += "]";

                          pointsStr += ",";
                        }
                        pointsStr =
                            pointsStr.substring(0, pointsStr.length - 1);

                        clustersTxt +=
                        "\"centroid\": [$centroidCoords], \"points\": [$pointsStr]";

                        clustersTxt += " }";
                        if (i != outputDataPoints!.centroids.length - 1) {
                          clustersTxt += ",";
                        }
                      }

                      var jsonText = "{ \"clusters\": [ $clustersTxt ] }";

                      html.Blob blob = html.Blob([jsonText], "text/plain");
                      var url = html.Url.createObjectUrlFromBlob(blob);

                      js.context.callMethod("eval", [
                        """
                  const csvDownload = document.createElement('a');
                  csvDownload.id = "csvDownload";
                  csvDownload.href = "$url";
                  csvDownload.style = "display:hidden;";

                  document.body.append(csvDownload);
                  csvDownload.click();

                  csvDownload.remove();
                """
                      ]);

                      html.Url.revokeObjectUrl(url);
                    }),
              )
            ],
          ),
          SfCartesianChart(
            title: ChartTitle(text: outputChartTitle),
            primaryXAxis: NumericAxis(
                title: AxisTitle(text: outputXTitle),
                labelIntersectAction:
                AxisLabelIntersectAction.multipleRows,
                majorGridLines: const MajorGridLines(width: 1),
                axisLine: const AxisLine(width: 1)),
            primaryYAxis: NumericAxis(
                title: AxisTitle(text: outputYTitle),
                axisLine: const AxisLine(width: 1),
                majorGridLines: const MajorGridLines(width: 1)),
            tooltipBehavior: TooltipBehavior(enable: false),
            series: [
              ScatterSeries(
                dataSource: outputDataPoints!.points,
                xValueMapper: (singlePoint, index) => singlePoint.coords[0],
                yValueMapper: (singlePoint, index) => singlePoint.coords[1],
                pointColorMapper: (singlePoint, index) =>
                colors[singlePoint.clusterNumber],
              )
            ],
          )
        ])
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            manager!.calculateFinished == false
                ? const CircularProgressIndicator()
                : const SizedBox()
          ],
        )
      ];
    }
      return [
        const SizedBox(height: 8,),
        Visibility(
          visible: !manager!.operatingMode && outputDataPoints!.centroids.isNotEmpty,
          child: Expanded(
            child: CustomWidgets.customElevatedButton(
                text: Constants.BTN_EXPORT,
                onPressed: () {
                  var clustersTxt = "";

                  for (int i = 0; i <
                      outputDataPoints!.centroids.length; i++) {
                    clustersTxt += "{ ";

                    String centroidCoords = outputDataPoints!.centroids[i]
                        .coords.join(",");

                    String pointsStr = "";

                    for (int k = 0; k <
                        outputDataPoints!.points.length; k++) {
                      if (i + 1 !=
                          outputDataPoints!.points[k].clusterNumber) {
                        continue;
                      }

                      pointsStr += "[";
                      pointsStr +=
                          outputDataPoints!.points[k].coords.join(",");
                      pointsStr += "]";

                      pointsStr += ",";
                    }
                    pointsStr =
                        pointsStr.substring(0, pointsStr.length - 1);

                    clustersTxt +=
                    "\"centroid\": [$centroidCoords], \"points\": [$pointsStr]";

                    clustersTxt += " }";
                    if (i != outputDataPoints!.centroids.length - 1) {
                      clustersTxt += ",";
                    }
                  }

                  var jsonText = "{ \"clusters\": [ $clustersTxt ] }";

                  html.Blob blob = html.Blob([jsonText], "text/plain");
                  var url = html.Url.createObjectUrlFromBlob(blob);

                  js.context.callMethod("eval", [
                    """
                    const csvDownload = document.createElement('a');
                    csvDownload.id = "csvDownload";
                    csvDownload.href = "$url";
                    csvDownload.style = "display:hidden;";

                    document.body.append(csvDownload);
                    csvDownload.click();

                    csvDownload.remove();
                  """
                  ]);

                  html.Url.revokeObjectUrl(url);
                }),
          ),
        ),
        const SizedBox(height: 8,),
      ];
  }

  /// KMeans Lokal ausrechnen
  void calculateKMeans() async {
    manager!.calculateFinished;
    setState(() {});
  }

  /// Serverseitig KMeans ausführen
  void kMeansServer() async {
    manager!.calculateFinished;
    setState(() {});
  }
}
