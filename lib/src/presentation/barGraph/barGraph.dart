import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:zoho/src/presentation/barGraph/barData.dart';

class BarGraph extends StatelessWidget {
  final List weeklySummary;

  const BarGraph({super.key, required this.weeklySummary});

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmount: weeklySummary[0],
      monAmount: weeklySummary[1],
      tueAmount: weeklySummary[2],
      wedAmount: weeklySummary[3],
      thuAmount: weeklySummary[4],
      friAmount: weeklySummary[5],
      satAmount: weeklySummary[6],
    );
    myBarData.initializeBarData();
    return BarChart(
      BarChartData(
        maxY: 24,
        minY: 0,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles:
                SideTitles(showTitles: true, getTitlesWidget: getBottomTitles),
          ),
        ),
        barGroups: myBarData.barData.map((data) => BarChartGroupData(
              x: data.x,
              barRods: [
                BarChartRodData(
                  toY: data.y,
                  color: Color.fromARGB(218, 71, 167, 163),
                  width: 25,
                  borderRadius: BorderRadius.circular(4),
                  backDrawRodData: BackgroundBarChartRodData(
                      show: true, toY: 24, color: Color.fromARGB(255, 221, 217, 217)),
                ),
              ],
            ),
        )
        .toList(),
      ),
    );
  }
}

Widget getBottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color.fromARGB(218, 71, 167, 163),
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );

  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text('MON', style: style);
      break;
    case 1:
      text = const Text('TUE', style: style);
      break;
    case 2:
      text = const Text('WED', style: style);
      break;
    case 3:
      text = const Text('THU', style: style);
      break;
    case 4:
      text = const Text('FRI', style: style);
      break;
    case 5:
      text = const Text('SAT', style: style);
      break;
    case 6:
      text = const Text('SUN', style: style);
      break;
    default:
      text = const Text('', style: style);
      break;
  }
  return text;
}