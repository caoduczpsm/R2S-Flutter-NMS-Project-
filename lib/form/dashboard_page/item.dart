import 'dart:math';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:pie_chart/pie_chart.dart';
import '../../db/NoteDatabase.dart';
import '../../model/User.dart';
import '../../ultilities/Constant.dart';
// ignore: depend_on_referenced_packages

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  User user;

  HomeScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _HomeScreen(user: user));
  }
}

// ignore: must_be_immutable
class _HomeScreen extends StatefulWidget {
  User user;

  _HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<_HomeScreen> createState() => _HomeScreenState(user: user);
}

class _HomeScreenState extends State<_HomeScreen> {
  User user;

  _HomeScreenState({required this.user});

  List<Map<String, dynamic>> _countStatus = [];
  bool _isLoading = true;
  dynamic categoryDropdownValue;
  dynamic priorityDropdownValue;
  dynamic statusDropdownValue;

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  Future<void> _refreshData() async {
    final data = await NoteSQLHelper.getNumOfStatusInNote(user.id!);

    setState(() {
      _countStatus = data;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Color> randomColors = [];

    Map<String, double> dataMap = {};
    for (var item in _countStatus) {
      dataMap[item[Constant.KEY_NOTE_STATUS_NAME]] =
          item[Constant.KEY_STATUS_COUNT].toDouble();
      randomColors.add(Color.fromARGB(Random().nextInt(256),
          Random().nextInt(256), Random().nextInt(256), Random().nextInt(256)));
    }

    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : dataMap.isEmpty
              ? const Center(
                  child: Text(
                    "Empty note",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.blue),
                  ),
                )
              : PieChart(
                  dataMap: dataMap,
                  animationDuration: const Duration(milliseconds: 800),
                  chartLegendSpacing: 26,
                  chartRadius: MediaQuery.of(context).size.width / 2,
                  colorList: randomColors,
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 32,
                  //centerText: "Note Management System",
                  legendOptions: const LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: true,
                    showChartValuesOutside: false,
                    decimalPlaces: 1,
                  ),
                ),
    );
  }
}
