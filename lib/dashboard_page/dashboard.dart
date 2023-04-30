import 'package:flutter/material.dart';
import 'package:note_management_system/form/Category.dart';
import 'package:note_management_system/ultilities/Constant.dart';
import 'package:note_management_system/form/NoteScreen.dart';
import 'package:note_management_system/form/Priority.dart';
import 'package:note_management_system/form/Status_Form.dart';
import 'package:note_management_system/form/EditProfile_ChangePassword/EditProfile.dart';
import 'package:note_management_system/dashboard_page/item.dart';
import 'package:note_management_system/model/User.dart';
import 'package:note_management_system/form/EditProfile_ChangePassword/ChangePassword.dart';
import 'package:note_management_system/form/Category.dart';
import 'package:d_chart/d_chart.dart';
// ignore: must_be_immutable
class NoteApp extends StatefulWidget {
static const String routeName='/dashboard_page/dashboard';
  User user;

  NoteApp({super.key, required this.user});

  @override
  // ignore: no_logic_in_create_state
  State<NoteApp> createState() => _NoteAppState(user: user);
}

class _NoteAppState extends State<NoteApp> {

  User user;

  _NoteAppState({required this.user});

  Widget _currentScreen = const ItemDashboard();

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
      appBar: AppBar(
        title: const Text('Dashboard Form'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/drawer_background.jpg'),
                  fit: BoxFit.cover,
                ),

              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 90.0,
                    height: 90.0,
                    child: Image.asset('images/logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text('Group 1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  Text(user.email!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text('Home'),
              leading: const Icon(Icons.home),
              onTap: () {
                setState(() {
                  _currentScreen = const ItemDashboard();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(' ${Constant.KEY_TABLE_CATEGORY}'),
              leading: const Icon(Icons.note),
              onTap: () {
                setState(() {
                  _currentScreen = const ItemDashboard();
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('${Constant.KEY_TABLE_PRIORITY}'),
              leading: const Icon(Icons.category),
              onTap: () {
                setState(() {
                  _currentScreen = CategoryScreen(user: user);
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(' ${Constant.KEY_TABLE_STATUS}'),
              leading: const Icon(Icons.low_priority),
              onTap: () {
                setState(() {
                  _currentScreen = PriorityScreen(user: user);
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(' ${Constant.KEY_TABLE_NOTE}'),
              leading: const Icon(Icons.signal_wifi_statusbar_4_bar),
              onTap: () {
                setState(() {
                  _currentScreen = StatusScreen(user: user);
                });
                Navigator.pop(context);
              },
            ),
            const Divider(color: Colors.black),
            Container(
              margin: const EdgeInsets.only(top: 5, left: 15),
              child: const Text('Account'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Edit Profile'),
              onTap: () {
                setState(() {
                  _currentScreen = EditProfileForm(user: user,);
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.password),
              title: const Text('Change password'),
              onTap: () {
                setState(() {
                  _currentScreen = ChangePasswordForm(user: user,);
                });
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),

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
              animationDuration: Duration(milliseconds: 500),
            ),
          )),

    );
  }
}
