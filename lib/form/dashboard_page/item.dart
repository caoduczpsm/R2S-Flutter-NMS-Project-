import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

class ItemDashboard extends StatelessWidget {
  ItemDashboard({super. key});

  final List<Map<String, dynamic>> data = [
    {'domain': 'Processing', 'measure': 60},
    {'domain': 'Done', 'measure': 20},
    {'domain': 'Pending', 'measure': 20},
  ];


  Color _getColor(String data) {
    switch (data) {
      case 'Processing':
        return Colors.grey;
      case 'Done':
        return Colors.blueAccent;
      case 'Pending':
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: AspectRatio(
            aspectRatio: 1,
            child: DChartPie(
              data: data,
              fillColor: (pieData, index) => _getColor(pieData['domain']),
              pieLabel: (pieData, index) =>
              '${pieData['domain']}  ${pieData['measure']}%',
              animate: true,
              strokeWidth: 1,
              labelColor: Colors.white,
              labelFontSize: 15,
              labelPosition: PieLabelPosition.inside,
              animationDuration: const Duration(milliseconds: 500),
            ),
          )),
    );
  }
}
