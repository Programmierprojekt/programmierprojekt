import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class OutputScreen extends StatefulWidget {
  const OutputScreen({Key? key}) : super(key: key);

  @override
  State<OutputScreen> createState() => _OutputScreenState();
}

class _OutputScreenState extends State<OutputScreen> {
  int touchedIndex = -1;
  Color greyColor = Colors.grey;
  List<int> selectedSpots = [1, 2, 3, 4, 5, 6, 7];

  double aspectRatioValue = 5;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            children: [
              const Text("Datenpunkte ohne Clustering:"),
              Container(
                padding: const EdgeInsets.all(20),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.indigoAccent)),
                child: AspectRatio(
                  aspectRatio: aspectRatioValue,
                  child: ScatterChart(
                    ScatterChartData(
                      scatterSpots: [
                        ScatterSpot(4, 4,
                            color: selectedSpots.contains(0)
                                ? Colors.purpleAccent
                                : Colors.red,
                            radius: 10),
                        ScatterSpot(
                          2,
                          5,
                          color: selectedSpots.contains(1)
                              ? Colors.purpleAccent
                              : Colors.red,
                          radius: 10,
                        ),
                        ScatterSpot(
                          4,
                          5,
                          color: selectedSpots.contains(2)
                              ? Colors.purpleAccent
                              : Colors.red,
                          radius: 10,
                        ),
                        ScatterSpot(
                          8,
                          6,
                          color: selectedSpots.contains(3)
                              ? Colors.purpleAccent
                              : Colors.red,
                          radius: 10,
                        ),
                        ScatterSpot(
                          5,
                          7,
                          color: selectedSpots.contains(4)
                              ? Colors.purpleAccent
                              : Colors.red,
                          radius: 10,
                        ),
                        ScatterSpot(
                          7,
                          2,
                          color: selectedSpots.contains(5)
                              ? Colors.purpleAccent
                              : Colors.red,
                          radius: 10,
                        ),
                        ScatterSpot(
                          3,
                          2,
                          color: selectedSpots.contains(6)
                              ? Colors.purpleAccent
                              : Colors.red,
                          radius: 10,
                        ),
                        ScatterSpot(
                          2,
                          8,
                          color: selectedSpots.contains(7)
                              ? Colors.purpleAccent
                              : Colors.red,
                          radius: 10,
                        ),
                      ],
                      minX: 0,
                      maxX: 10,
                      minY: 0,
                      maxY: 10,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawHorizontalLine: true,
                        checkToShowHorizontalLine: (value) => true,
                        getDrawingHorizontalLine: (value) => const FlLine(
                          color: Colors.teal,
                        ),
                        drawVerticalLine: true,
                        checkToShowVerticalLine: (value) => true,
                        getDrawingVerticalLine: (value) => const FlLine(
                          color: Colors.teal,
                        ),
                      ),
                      titlesData: const FlTitlesData(
                        show: false,
                      ),
                      showingTooltipIndicators: selectedSpots,
                      scatterTouchData: ScatterTouchData(
                        enabled: true,
                        handleBuiltInTouches: false,
                        mouseCursorResolver: (FlTouchEvent touchEvent,
                            ScatterTouchResponse? response) {
                          return response == null || response.touchedSpot == null
                              ? MouseCursor.defer
                              : SystemMouseCursors.click;
                        },
                        touchTooltipData: ScatterTouchTooltipData(
                          tooltipBgColor: Colors.black,
                          getTooltipItems: (ScatterSpot touchedBarSpot) {
                            return ScatterTooltipItem(
                              'X: ',
                              textStyle: TextStyle(
                                height: 1.2,
                                color: Colors.grey[100],
                                fontStyle: FontStyle.italic,
                              ),
                              bottomMargin: 10,
                              children: [
                                TextSpan(
                                  text: '${touchedBarSpot.x.toInt()} \n',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Y: ',
                                  style: TextStyle(
                                    height: 1.2,
                                    color: Colors.grey[100],
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                TextSpan(
                                  text: touchedBarSpot.y.toInt().toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        touchCallback: (FlTouchEvent event,
                            ScatterTouchResponse? touchResponse) {
                          if (touchResponse == null ||
                              touchResponse.touchedSpot == null) {
                            return;
                          }
                          if (event is FlTapUpEvent) {
                            final sectionIndex =
                                touchResponse.touchedSpot!.spotIndex;
                            setState(() {
                              if (selectedSpots.contains(sectionIndex)) {
                                selectedSpots.remove(sectionIndex);
                              } else {
                                selectedSpots.add(sectionIndex);
                              }
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const Text("Ausgabe mit Clustering:"),
              Container(
                padding: const EdgeInsets.all(20),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.indigoAccent)),
                child: AspectRatio(
                  aspectRatio: aspectRatioValue,
                  child: ScatterChart(
                    ScatterChartData(
                      scatterSpots: [
                        ScatterSpot(4, 4,
                            color: selectedSpots.contains(0)
                                ? Colors.purpleAccent
                                : Colors.red,
                            radius: 10),
                        ScatterSpot(
                          2,
                          5,
                          color: selectedSpots.contains(1)
                              ? Colors.purpleAccent
                              : Colors.red,
                          radius: 10,
                        ),
                        ScatterSpot(
                          4,
                          5,
                          color: selectedSpots.contains(2)
                              ? Colors.purpleAccent
                              : Colors.red,
                          radius: 10,
                        ),
                        ScatterSpot(
                          8,
                          6,
                          color: selectedSpots.contains(3)
                              ? Colors.purpleAccent
                              : Colors.red,
                          radius: 10,
                        ),
                        ScatterSpot(
                          5,
                          7,
                          color: selectedSpots.contains(4)
                              ? Colors.purpleAccent
                              : Colors.red,
                          radius: 10,
                        ),
                        ScatterSpot(
                          7,
                          2,
                          color: selectedSpots.contains(5)
                              ? Colors.purpleAccent
                              : Colors.red,
                          radius: 10,
                        ),
                        ScatterSpot(
                          3,
                          2,
                          color: selectedSpots.contains(6)
                              ? Colors.purpleAccent
                              : Colors.red,
                          radius: 10,
                        ),
                        ScatterSpot(
                          2,
                          8,
                          color: selectedSpots.contains(7)
                              ? Colors.purpleAccent
                              : Colors.red,
                          radius: 10,
                        ),
                      ],
                      minX: 0,
                      maxX: 10,
                      minY: 0,
                      maxY: 10,
                      borderData: FlBorderData(
                        show: false,
                      ),
                      gridData: FlGridData(
                        show: true,
                        drawHorizontalLine: true,
                        checkToShowHorizontalLine: (value) => true,
                        getDrawingHorizontalLine: (value) => const FlLine(
                          color: Colors.teal,
                        ),
                        drawVerticalLine: true,
                        checkToShowVerticalLine: (value) => true,
                        getDrawingVerticalLine: (value) => const FlLine(
                          color: Colors.teal,
                        ),
                      ),
                      titlesData: const FlTitlesData(
                        show: false,
                      ),
                      showingTooltipIndicators: selectedSpots,
                      scatterTouchData: ScatterTouchData(
                        enabled: true,
                        handleBuiltInTouches: false,
                        mouseCursorResolver: (FlTouchEvent touchEvent,
                            ScatterTouchResponse? response) {
                          return response == null || response.touchedSpot == null
                              ? MouseCursor.defer
                              : SystemMouseCursors.click;
                        },
                        touchTooltipData: ScatterTouchTooltipData(
                          tooltipBgColor: Colors.black,
                          getTooltipItems: (ScatterSpot touchedBarSpot) {
                            return ScatterTooltipItem(
                              'X: ',
                              textStyle: TextStyle(
                                height: 1.2,
                                color: Colors.grey[100],
                                fontStyle: FontStyle.italic,
                              ),
                              bottomMargin: 10,
                              children: [
                                TextSpan(
                                  text: '${touchedBarSpot.x.toInt()} \n',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Y: ',
                                  style: TextStyle(
                                    height: 1.2,
                                    color: Colors.grey[100],
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                TextSpan(
                                  text: touchedBarSpot.y.toInt().toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        touchCallback: (FlTouchEvent event,
                            ScatterTouchResponse? touchResponse) {
                          if (touchResponse == null ||
                              touchResponse.touchedSpot == null) {
                            return;
                          }
                          if (event is FlTapUpEvent) {
                            final sectionIndex =
                                touchResponse.touchedSpot!.spotIndex;
                            setState(() {
                              if (selectedSpots.contains(sectionIndex)) {
                                selectedSpots.remove(sectionIndex);
                              } else {
                                selectedSpots.add(sectionIndex);
                              }
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
