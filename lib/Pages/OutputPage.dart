import 'dart:html' as html;
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:ml_algo/ml_algo.dart';
import 'package:programmierprojekt/Custom/CustomWidgets.dart';
import 'package:programmierprojekt/Custom/DataPointModel.dart';
import 'package:programmierprojekt/Custom/DecisionTreeModel.dart';
import 'package:programmierprojekt/Util/Constants.dart';
import 'package:programmierprojekt/Util/SystemManager.dart';
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

  DecisionTreeClassifier? d;
  dynamic eee;

  @override
  void initState() {
    super.initState();
    dataPoints = widget.dataPoints;
    manager = widget.manager;
    dtModel = widget.dtModel;
    if (manager!.operatingMode && manager!.algorithmType == 0) {
      calculateKMeans();
    } else {
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
        builder: (context, child) =>
            ListView(children: buildGraphicsRepresentation(context)));
  }

  List<Widget> buildGraphicsRepresentation(BuildContext context) {
    if (manager!.algorithmType == 0) {
      var theme = Theme.of(context);

      return [
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 10),
            CustomWidgets.CustomElevatedButton(
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
            const SizedBox(width: 10),
            CustomWidgets.CustomElevatedButton(
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
            const SizedBox(width: 10),
            CustomWidgets.CustomElevatedButton(
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
                })
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
          tooltipBehavior: TooltipBehavior(enable: true),
          zoomPanBehavior: ZoomPanBehavior(
            enablePanning: true,
            enableMouseWheelZooming: true,
            enablePinching: true,
          ),
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
                    CustomWidgets.CustomElevatedButton(
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
                    const SizedBox(width: 10),
                    CustomWidgets.CustomElevatedButton(
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
                    const SizedBox(width: 10),
                    CustomWidgets.CustomElevatedButton(
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
                    const SizedBox(width: 10),
                    CustomWidgets.CustomElevatedButton(
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
                        })
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
                  tooltipBehavior: TooltipBehavior(enable: true),
                  zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
                )
              ])
            : const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [CircularProgressIndicator()],
              )
      ];
    } else {
      return [
        //TODO: BildGrafik anzeigen
        const FlutterLogo()
      ];
    }
  }

  /// KMeans ausrechnen
  void calculateKMeans() async {
    setState(() {
      isFinishedCalculating = false; //Muss als erstes gemacht werden
    });
  }

  /// DecisionTree ausrechnen
  void calculateDecisionTree() async {
    setState(() {
      isFinishedCalculating = false; //Muss als erstes gemacht werden
    });
  }
}
