import 'package:flutter/material.dart';
import 'package:note_management_system/item.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  // int _selectIndex=0;
  // final drawerItems=[
  //   new DrawerItems()
  // ]
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
              accountEmail: Text('example@gmail.com'),
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
