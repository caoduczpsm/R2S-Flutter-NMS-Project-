import 'package:flutter/material.dart';
import 'package:note_management_system/db/StatusHelper.dart';
import 'package:note_management_system/model/Status.dart';
import '../model/User.dart';
import '../ultilities/Constant.dart';

// ignore: must_be_immutable
class StatusScreen extends StatelessWidget {
  static const String routeName= '/form/Status_Form';
  User user;

  StatusScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _StatusScreen(user: user));
  }
}

// ignore: must_be_immutable
class _StatusScreen extends StatefulWidget{

  User user;

  _StatusScreen({Key? key, required this.user}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<_StatusScreen> createState() => _StatusScreenState(user: user);
}

class _StatusScreenState extends State<_StatusScreen> {

  User user;

  _StatusScreenState({required this.user});

  List<Map<String, dynamic>> _status = [];
  bool _isLoading = true;

  Future<void> _refreshStatus() async {
    final List<Map<String, dynamic>> data = await StatusHelper.getAllItem(user.id!);
    setState(() {
      _status = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshStatus();
  }

  final TextEditingController _textNameController = TextEditingController();

  void _showForm(int? id) async {

    if(id != null) {
      final existingJournal =
      _status.firstWhere((element) => element[Constant.KEY_STATUS_ID] == id);
      _textNameController.text = existingJournal[Constant.KEY_STATUS_NAME];
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
    int? id = await StatusHelper.createItem(Status(
        name: _textNameController.text,
        userId: user.id
    ));
    if(id != null){
      _refreshStatus();
    } else {
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Available Status')));
    }
  }

  Future<void> _updateItem(int id) async {
    await StatusHelper.updateItem(Status(
        id: id,
        name: _textNameController.text,
        userId: user.id,
    ));
    _refreshStatus();
  }

  Future<void> _deleteItem(int id) async {
    await StatusHelper.deleteItem(id);

    if(!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a status!'),
    ));
    _refreshStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
        itemCount: _status.length,
        itemBuilder: (context, index) => Card(
          color: Colors.blueGrey[200],
          margin: const EdgeInsets.only(
              left: 10, right: 10, top: 10
          ),
          child: ListTile(
            title: Text('Name: ${_status[index][Constant.KEY_STATUS_NAME]}'),
            subtitle: Text('Created At: ${_status[index][Constant.KEY_STATUS_CREATED_DATE]}'),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => _showForm(_status[index][Constant.KEY_STATUS_ID]),
                    icon: const Icon(Icons.edit),),
                  IconButton(
                    onPressed: () => _deleteItem(_status[index][Constant.KEY_STATUS_ID]),
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