import 'package:flutter/material.dart';
import 'package:note_management_system/form/dashboard_page/item.dart';
import '../../model/User.dart';
import '../Category.dart';
import '../NoteScreen.dart';
import '../Priority.dart';
import '../Status_Form.dart';

// ignore: must_be_immutable
class NoteManagementApp extends StatelessWidget {

  User user;

  NoteManagementApp({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyNoteManagementApp(user: user),
    );
  }
}

// ignore: must_be_immutable
class MyNoteManagementApp extends StatefulWidget {
  User user;

  MyNoteManagementApp({Key? key, required this.user}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<MyNoteManagementApp> createState() => _MyNoteManagementAppState(user: user);
}

class _MyNoteManagementAppState extends State<MyNoteManagementApp> {

  User user;

  int _selectedIndex = 0;

  _MyNoteManagementAppState({required this.user});

  Widget? _currentScreen;

  final mainImage = Image.asset(
    'images/drawer_background.jpg',
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentScreen = ItemDashboard();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note Management System'),
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
                    width: 100.0,
                    height: 100.0,
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
                ],
              ),
            ),
            ListTile(
              selectedTileColor: _selectedIndex == 0 ? Colors.blue : Colors.transparent,
              title: const Text('Home'),
              leading: const Icon(Icons.home),
              onTap: () {
                setState(() {
                  _currentScreen = ItemDashboard();
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              selectedTileColor: _selectedIndex == 1 ? Colors.blue : Colors.transparent,
              title: const Text('Note'),
              leading: const Icon(Icons.note),
              onTap: () {
                setState(() {
                  _currentScreen = NoteScreen(user: user);
                  _selectedIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              selectedTileColor: _selectedIndex == 2 ? Colors.blue : Colors.transparent,
              title: const Text('Category'),
              leading: const Icon(Icons.category),
              onTap: () {
                setState(() {
                  _currentScreen = CategoryScreen(user: user);
                  _selectedIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              selectedTileColor: _selectedIndex == 3 ? Colors.blue : Colors.transparent,
              title: const Text('Priority'),
              leading: const Icon(Icons.low_priority),
              onTap: () {
                setState(() {
                  _currentScreen = PriorityScreen(user: user);
                  _selectedIndex = 3;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              selectedTileColor: _selectedIndex == 4 ? Colors.blue : Colors.transparent,
              title: const Text('Status'),
              leading: const Icon(Icons.signal_wifi_statusbar_4_bar),
              onTap: () {
                setState(() {
                  _selectedIndex = 4;
                  _currentScreen = StatusScreen(user: user);
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _currentScreen,
    );
  }
}