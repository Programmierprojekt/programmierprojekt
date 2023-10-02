import 'package:flutter/material.dart';
import 'package:programmierprojekt/Custom/DataPointModel.dart';
import 'package:programmierprojekt/Util/SystemManager.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

  @override
  void initState() {
    super.initState();
    dataPoints = widget.dataPoints;
    manager = widget.manager;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: buildGraphicsRepresentation());
  }

  List<Widget> buildGraphicsRepresentation() {
    if (manager!.algorithmType == 0) {
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