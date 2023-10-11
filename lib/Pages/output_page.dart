// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:html' as html;
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:programmierprojekt/Custom/custom_widgets.dart';
import 'package:programmierprojekt/Custom/data_point_model.dart';
import 'package:programmierprojekt/Custom/decision_tree_model.dart';
import 'package:programmierprojekt/Util/constants.dart';
import 'package:programmierprojekt/Util/system_manager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OutputPage extends StatefulWidget {
  final DataPoints dataPoints;
  final SystemManager manager;
  final DecisionTreeModel dtModel;

  const OutputPage(
      {required this.dataPoints,
      required this.manager,
      required this.dtModel,
      Key? key})
      : super(key: key);

  @override
  State<OutputPage> createState() => _OutputPageState();
}

//TODO: https://github.com/syncfusion/flutter-examples/blob/master/lib/samples/chart/cartesian_charts/chart_types/scatter/default_scatter_chart.dart

class _OutputPageState extends State<OutputPage> {
  double aspectRatioValue = 5;
  int displayType = 0;
  SystemManager? manager;
  DataPoints? dataPoints;
  DecisionTreeModel? dtModel;

  bool isFinishedCalculating = false;

  late String inputChartTitle;
  late String outputChartTitle;
  late String inputXTitle;
  late String inputYTitle;
  late String outputXTitle;
  late String outputYTitle;

  @override
  void initState() {
    super.initState();
    dataPoints = widget.dataPoints;
    manager = widget.manager;
    dtModel = widget.dtModel;
    //print(manager!.algorithmType);
    if (manager!.algorithmType == 0) {
      //KMeans ausführen
      if (manager!.operatingMode) {
        calculateKMeans(); //Lokal
      } else {
        kMeansServer(); //Server
      }
    } else {
      //DecisionTree ausführen
      calculateDecisionTree();
    }
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
        builder: (context, child) => ListView(
            shrinkWrap: true, children: buildGraphicsRepresentation(context)));
  }

  List<Widget> buildGraphicsRepresentation(BuildContext context) {
    if (manager!.algorithmType == 0) {
      var theme = Theme.of(context);

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
                        html.window.localStorage["inputChartTitle"] = newText;
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
              dataSource: dataPoints!.points,
              xValueMapper: (singlePoint, index) => singlePoint.x,
              yValueMapper: (singlePoint, index) => singlePoint.y,
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
        isFinishedCalculating
            ? Column(children: [
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
                            var csvText = "x,y\r\n";

                            for (var point in dataPoints!.points) {
                              csvText += "${point.x},${point.y}\r\n";
                            }

                            html.Blob blob = html.Blob([csvText], "text/csv");
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
                )
              ])
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isFinishedCalculating == false
                      ? const CircularProgressIndicator()
                      : const SizedBox()
                ],
              )
      ];
    } else {
      return [
        //TODO: BildGrafik anzeigen
      ];
    }
  }

  /// KMeans Lokal ausrechnen
  void calculateKMeans() async {
    setState(() {
      isFinishedCalculating = false; //Muss als erstes gemacht werden
    });
  }

  /// Serverseitig KMeans ausführen
  void kMeansServer() async {
    setState(() {
      isFinishedCalculating = false; //Muss als erstes gemacht werden
    });
  }

  /// DecisionTree Lokal ausrechnen
  void calculateDecisionTree() async {
    //print("OAHDFiaHDHAWIDiADWIOA");
    setState(() {
      isFinishedCalculating = false; //Muss als erstes gemacht werden
    });
    DecisionTreeClassifier d =
        DecisionTreeClassifier(dtModel!.dataFrame, "irgenwas");
    html.Blob blob = html.Blob([await d.saveAsSvg("/a")], "image/svg+xml");
    var url = html.Url.createObjectUrlFromBlob(blob);
    js.context.callMethod("eval", [
      """
                  const csvDownload = document.createElement('img');
                  csvDownload.id = "irgendwas";
                  csvDownload.width = "1024";
                  csvDownload.height = "1024";
                  csvDownload.src = "$url";
                  document.body.append(csvDownload);
                """
    ]);
    html.Url.revokeObjectUrl(url);
  }
}
