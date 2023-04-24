import 'package:flutter/material.dart';
import 'package:note_management_system/dashboard_page/item.dart';
import 'package:note_management_system/form/SignUp_SignIn/SignIn.dart';
import 'package:note_management_system/ultilities/Constant.dart';
class DashboardPage extends StatelessWidget {
  final dynamic user;
  const DashboardPage({required this.user}) : super();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Form'),
        backgroundColor: Colors.green,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              accountName: const Text('Note Management System'),
              accountEmail: Text('mail'),
              currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('images/download.jpg')),
            ),
            ListTile(
              leading: Icon(Icons.camera),
              title: const Text('Home'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDashboard()));
              },
              ),
            ListTile(
              leading: Icon(Icons.image),
              title: const Text('Category'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDashboard()));
              },
            ),
            ListTile(
              leading: Icon(Icons.video_call),
              title: const Text('Priority'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDashboard()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: const Text('Status'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDashboard()));
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: const Text('Note'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDashboard()));
              },
            ),
            const Divider(color: Colors.black),
            const Text('Account'),
            ListTile(
              leading: Icon(Icons.share),
              title: const Text('Edit Profile'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDashboard()));
              },
            ),
            ListTile(
              leading: Icon(Icons.share_location),
              title: const Text('Change password'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ItemDashboard()));
              },
            )
          ],
        ),
      ),
    );
  }
}
