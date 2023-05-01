import 'package:flutter/material.dart';

class ItemDashboard extends StatelessWidget {
  const ItemDashboard({super. key});
  static const String routeName='/dashboard_page/item';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Dashboard Form'),
        ),
      body: Center(child: Text("TEST"),),
    );
  }
}
