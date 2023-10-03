import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/CustomWidgets.dart';
import 'package:programmierprojekt/Custom/DataPointModel.dart';
import 'package:programmierprojekt/Util/SystemManager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:html';

class OutputPage extends StatefulWidget {
  final DataPoints dataPoints;
  final SystemManager manager;

  const OutputPage({required this.dataPoints, required this.manager, Key? key})
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

  late String inputChartTitle;
  late String outputChartTitle;

  @override
  void initState() {
    super.initState();
    dataPoints = widget.dataPoints;
    manager = widget.manager;
    inputChartTitle = window.localStorage["inputChartTitle"] ?? "Datenvorschau";
    outputChartTitle = window.localStorage["outputChartTitle"] ?? "Clustered";
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: buildGraphicsRepresentation(context));
  }

  List<Widget> buildGraphicsRepresentation(BuildContext context) {
    if (manager!.algorithmType == 0) {
      var theme = Theme.of(context);

      return [
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 10),
            CustomWidgets.CustomElevatedButton(text: "Titel ändern", onPressed: () {
              CustomWidgets.showTextfieldDialog(context, theme, inputChartTitle, (newText) { 
                setState(() {
                  inputChartTitle = newText;
                  window.localStorage["inputChartTitle"] = newText;
                });
              });
            })
          ],
        ),
        SfCartesianChart(
          title: ChartTitle(text: inputChartTitle),
          primaryXAxis: NumericAxis(
              majorGridLines: const MajorGridLines(width: 1),
              axisLine: const AxisLine(width: 1)),
          primaryYAxis: NumericAxis(
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
        Row(
          children: [
            const SizedBox(width: 10),
            CustomWidgets.CustomElevatedButton(text: "Titel ändern", onPressed: () {
              CustomWidgets.showTextfieldDialog(context, theme, outputChartTitle, (newText) { 
                setState(() {
                  outputChartTitle = newText;
                  window.localStorage["outputChartTitle"] = newText;
                });
              });
            })
          ],
        ),
        SfCartesianChart(
          title: ChartTitle(text: outputChartTitle),
          primaryXAxis: NumericAxis(
              labelIntersectAction: AxisLabelIntersectAction.multipleRows,
              majorGridLines: const MajorGridLines(width: 1),
              axisLine: const AxisLine(width: 1)),
          primaryYAxis: NumericAxis(
              axisLine: const AxisLine(width: 1),
              majorGridLines: const MajorGridLines(width: 1)),
          tooltipBehavior: TooltipBehavior(enable: true),
          zoomPanBehavior: ZoomPanBehavior(enablePanning: true),
        ),
      ];
    } else {
      return [
        //TODO: BildGrafik anzeigen
        //Image.file(sourceFile,)
        const FlutterLogo()
      ];
    }
  }
}
