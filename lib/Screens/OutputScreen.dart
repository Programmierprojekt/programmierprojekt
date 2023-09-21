import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OutputScreen extends StatefulWidget {
  const OutputScreen({Key? key}) : super(key: key);

  @override
  State<OutputScreen> createState() => _OutputScreenState();
}

//TODO: https://github.com/syncfusion/flutter-examples/blob/master/lib/samples/chart/cartesian_charts/chart_types/scatter/default_scatter_chart.dart

class _OutputScreenState extends State<OutputScreen> {
  double aspectRatioValue = 5;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      SfCartesianChart(
        title: ChartTitle(text: "Ohne Clustering"),
        primaryXAxis: NumericAxis(
          labelIntersectAction: AxisLabelIntersectAction.multipleRows,
          majorGridLines: const MajorGridLines(width: 1),
          axisLine: const AxisLine(width: 1)
        ),
        primaryYAxis: NumericAxis(
            axisLine: const AxisLine(width: 1),
          majorGridLines:const MajorGridLines(width: 1)
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
      const SizedBox(height: 10,),
      SfCartesianChart(
        title: ChartTitle(text: "Mit Clustering"),
        primaryXAxis: NumericAxis(
            labelIntersectAction: AxisLabelIntersectAction.multipleRows,
            majorGridLines: const MajorGridLines(width: 1),
            axisLine: const AxisLine(width: 1)
        ),
        primaryYAxis: NumericAxis(
            axisLine: const AxisLine(width: 1),
            majorGridLines:const MajorGridLines(width: 1)
        ),
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    ]);
  }
}
