import 'package:flutter/material.dart';
import 'package:note_management_system/db/StatusHelper.dart';
import 'package:note_management_system/model/Status.dart';

import '../model/User.dart';
import '../ultilities/Constant.dart';

// ignore: must_be_immutable
class StatusScreen extends StatelessWidget {
  User user;

  StatusScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _StatusScreen(user: user));
  }
}

// ignore: must_be_immutable
class _StatusScreen extends StatefulWidget {
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
    final List<Map<String, dynamic>> data =
        await StatusHelper.getAllItem(user.id!);
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
    if (id != null) {
      final existingJournal = _status
          .firstWhere((element) => element[Constant.KEY_STATUS_ID] == id);
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
                      if (id == null) {
                        if (!mounted) return;
                        _addItem();
                      }

                      if (id != null) {
                        await _updateItem(id);
                      }

                      _textNameController.text = '';

                      if (!mounted) return;

                      Navigator.of(context).pop();
                    },
                    child: Text(id == null ? "Create New" : "Update"),
                  )
                ],
              ),
            ));
  }

  void _showFormDelete(int id, int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirm Delete"),
          content: Text(
              "Are you sure you want to delete this ${_status[index][Constant.KEY_STATUS_NAME]} status?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("No"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(true);
              },
              child: const Text("Yes"),
            ),
          ],
        );
      },
    ).then((value) async {
      if (value == true) {
        await StatusHelper.deleteItem(id);
        _refreshStatus();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Delete status ${_status[index][Constant.KEY_STATUS_NAME]} successfully!"),
        ));
      }
    });
  }

  Future<void> _addItem() async {
    String message = '';

    if (_textNameController.text.isNotEmpty) {
      if (_textNameController.text.length < 5) {
        message = 'Please enter at least 5 characters!';
      } else {
        int? id = await StatusHelper.createItem(Status(
          name: _textNameController.text,
          userId: user.id,
        ));
        if (id == null) {
          message = 'Please enter another name, this name already exists!';
        } else {
          message = 'Create status successfully';
          _refreshStatus();
        }
      }
    } else {
      message = 'Please enter name!';
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));

  }

  Future<void> _updateItem(int id) async {

    String message = '';
    if (_textNameController.text.isNotEmpty) {
      if (_textNameController.text.length < 5) {
        message = 'Please enter at least 5 characters!';
      } else {
        int? updateStatus = await StatusHelper.updateItem(Status(
          id: id,
          name: _textNameController.text,
          userId: user.id,
        ));

        if (updateStatus == null) {
          message = 'Please enter another name, this name already exists!';
        } else {
          message = 'Successful status update!';
          _refreshStatus();
        }
      }
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<void> _deleteItem(int id, int index) async {
    int? result = await StatusHelper.deleteItem(id);
    if (result == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Can not delete this '
                '${_status[index][Constant.KEY_STATUS_NAME]} '
                'because there is a note'
        ),
      ));
    } else {
      _showFormDelete(id, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _status.length,
              itemBuilder: (context, index) => Card(
                color: Colors.blueGrey[200],
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: ListTile(
                  title:
                      Text('Name: ${_status[index][Constant.KEY_STATUS_NAME]}'),
                  subtitle: Text(
                      'Created At: ${_status[index][Constant.KEY_STATUS_CREATED_DATE]}'),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () =>
                              _showForm(_status[index][Constant.KEY_STATUS_ID]),
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                            onPressed: () => _deleteItem(
                                _status[index][Constant.KEY_STATUS_ID], index),
                            icon: const Icon(Icons.delete),
                            color: Colors.red[900]),
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
