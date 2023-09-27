import 'package:flutter/material.dart';
import 'package:programmierprojekt/Algorithms/AlgorithmHelper.dart';
import 'package:programmierprojekt/Custom/DataPointModel.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OutputScreen extends StatefulWidget {
  final DataPoints dataPoints;
  final Algorithm algorithm;

  const OutputScreen(
      {required this.dataPoints, required this.algorithm, Key? key})
      : super(key: key);

  @override
  State<OutputScreen> createState() => _OutputScreenState();
}

//TODO: https://github.com/syncfusion/flutter-examples/blob/master/lib/samples/chart/cartesian_charts/chart_types/scatter/default_scatter_chart.dart

class _OutputScreenState extends State<OutputScreen> {
  double aspectRatioValue = 5;
  int displayType = 0;
  Algorithm? algo;
  DataPoints? dataPoints;

  @override
  void initState() {
    super.initState();
    dataPoints = widget.dataPoints;
    algo = widget.algorithm;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: buildGraphicsRepresentation());
  }

  List<Widget> buildGraphicsRepresentation() {
    if (algo!.algorithm == 0) {
      return [
            SfCartesianChart(
              title: ChartTitle(text: "Daten Vorschau"),
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
            SfCartesianChart(
              title: ChartTitle(text: "Clustered"),
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
