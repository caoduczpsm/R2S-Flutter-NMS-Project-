import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_management_system/dashboard_page/dashboard.dart';
import 'package:note_management_system/db/PriorityHelper.dart';
import 'package:note_management_system/model/Categories.dart';
import 'package:note_management_system/model/Priorities.dart';
import 'package:note_management_system/ultilities/page_routes.dart';

import '../model/User.dart';
import '../ultilities/Constant.dart';

// ignore: must_be_immutable
class PriorityScreen extends StatelessWidget {
static const String routeName= '/form/Priority';
  User user;

  PriorityScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Priority'),
        leading: BackButton(
            color: Colors.white,
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteApp(user: user)))
        ),
      ),
        body: _PriorityScreen(user: user));
  }
}

// ignore: must_be_immutable
class _PriorityScreen extends StatefulWidget{

  User user;

  _PriorityScreen({Key? key, required this.user}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<_PriorityScreen> createState() => _PriorityScreenState(user: user);
}

class _PriorityScreenState extends State<_PriorityScreen> {

  User user;

  _PriorityScreenState({required this.user});

  List<Map<String, dynamic>> _priority = [];
  bool _isLoading = true;

  Future<void> _refreshPriority() async {
    final List<Map<String, dynamic>> data = await PriorityHelper.getAllItem(user.id!);
    setState(() {
      _priority = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshPriority();
  }

  final TextEditingController _textNameController = TextEditingController();

  void _showForm(int? id) async {

    if(id != null) {
      final existingJournal =
      _priority.firstWhere((element) => element[Constant.KEY_PRIORITY_ID] == id);
      _textNameController.text = existingJournal[Constant.KEY_PRIORITY_NAME];
    }

    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
          padding: EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 400,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextFormField(
                controller: _textNameController,
                decoration: const InputDecoration(hintText: 'Name'),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if( id == null) {
                    if(_textNameController.text != ""){
                      await _addItem();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Enter some text')));
                    }
                  }

                  if(id != null){
                    await _updateItem(id);
                  }

                  _textNameController.text = '';

                  if(!mounted) return;

                  Navigator.of(context).pop();
                },
                child: Text(id == null ? "Create New" : "Update"),
              )
            ],
          ),
        )
    );
  }

  Future<void> _addItem() async{
    String dateFormat = DateFormat("yyyy-mm-dd - kk:mm:ss").format(DateTime.now());
    int? id = await PriorityHelper.createItem(Priorities(
        name: _textNameController.text,
        userId: user.id,
        createdAt: dateFormat
    ));
    if(id != null){
      _refreshPriority();
    } else {
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Available Priority')));
    }
  }

  Future<void> _updateItem(int id) async {
    String dateFormat = DateFormat("yyyy-mm-dd - kk:mm:ss").format(DateTime.now());
    await PriorityHelper.updateItem(Priorities(
        id: id,
        name: _textNameController.text,
        userId: user.id,
        createdAt: dateFormat
    ));
    _refreshPriority();
  }

  Future<void> _deleteItem(int id) async {
    await PriorityHelper.deleteItem(id);

    if(!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a priority!'),
    ));
    _refreshPriority();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
        itemCount: _priority.length,
        itemBuilder: (context, index) => Card(
          color: Colors.blueGrey[200],
          margin: const EdgeInsets.only(
              left: 10, right: 10, top: 10
          ),
          child: ListTile(
            title: Text('Name: ${_priority[index][Constant.KEY_PRIORITY_NAME]}'),
            subtitle: Text('Created At: ${_priority[index][Constant.KEY_PRIORITY_CREATED_DATE]}'),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => _showForm(_priority[index][Constant.KEY_PRIORITY_ID]),
                    icon: const Icon(Icons.edit),),
                  IconButton(
                    onPressed: () => _deleteItem(_priority[index][Constant.KEY_PRIORITY_ID]),
                    icon: const Icon(Icons.delete),),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }

}