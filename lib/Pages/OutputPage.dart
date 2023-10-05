import 'dart:html';

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
    inputChartTitle = window.localStorage["inputChartTitle"] ?? "Datenvorschau";
    outputChartTitle = window.localStorage["outputChartTitle"] ?? "Clustered";
    inputXTitle = window.localStorage["inputXTitle"] ?? "x-Achse";
    inputYTitle = window.localStorage["inputYTitle"] ?? "y-Achse";
    outputXTitle = window.localStorage["outputXTitle"] ?? "x-Achse";
    outputYTitle = window.localStorage["outputYTitle"] ?? "y-Achse";
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
                      window.localStorage["inputChartTitle"] = newText;
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
                      window.localStorage["inputXTitle"] = newText;
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
                      window.localStorage["inputYTitle"] = newText;
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
        Row(
          children: [
            const SizedBox(width: 10),
            CustomWidgets.CustomElevatedButton(
                text: Constants.CHANGE_TITLE,
                onPressed: () {
                  CustomWidgets.showTextfieldDialog(
                      context, theme, outputChartTitle, Constants.CHANGE_TITLE,
                      (newText) {
                    setState(() {
                      outputChartTitle = newText;
                      window.localStorage["outputChartTitle"] = newText;
                    });
                  });
                }),
            const SizedBox(width: 10),
            CustomWidgets.CustomElevatedButton(
                text: Constants.CHANGE_X_TITLE,
                onPressed: () {
                  CustomWidgets.showTextfieldDialog(
                      context, theme, outputXTitle, Constants.CHANGE_X_TITLE,
                      (newText) {
                    setState(() {
                      outputXTitle = newText;
                      window.localStorage["outputXTitle"] = newText;
                    });
                  });
                }),
            const SizedBox(width: 10),
            CustomWidgets.CustomElevatedButton(
                text: Constants.CHANGE_Y_TITLE,
                onPressed: () {
                  CustomWidgets.showTextfieldDialog(
                      context, theme, outputYTitle, Constants.CHANGE_Y_TITLE,
                      (newText) {
                    setState(() {
                      outputYTitle = newText;
                      window.localStorage["outputYTitle"] = newText;
                    });
                  });
                })
          ],
        ),
        SfCartesianChart(
          title: ChartTitle(text: outputChartTitle),
          primaryXAxis: NumericAxis(
              title: AxisTitle(text: outputXTitle),
              labelIntersectAction: AxisLabelIntersectAction.multipleRows,
              majorGridLines: const MajorGridLines(width: 1),
              axisLine: const AxisLine(width: 1)),
          primaryYAxis: NumericAxis(
              title: AxisTitle(text: outputYTitle),
              axisLine: const AxisLine(width: 1),
              majorGridLines: const MajorGridLines(width: 1)),
          tooltipBehavior: TooltipBehavior(enable: true),
          zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
        ),
      ];
    } else {
      return [
        //TODO: BildGrafik anzeigen
        const FlutterLogo()
      ];
    }
  }

  void calculateKMeans() {
    print(dataPoints!.points.length);
    /*List<List<double>> points = AlgorithmHelper().convertDataPointListToKMeansList(dataPoints!.points);
    for(var d in points)
      print(d);
    KMeans kmeans = KMeans(points,labelDim: points.length);
    var clusters = kmeans.bestFit(minK: 3, maxK: 3,maxIterations: 10);
      */
  }

  void calculateDecisionTree() async {}
}
