import 'package:flutter/material.dart';
import 'package:note_management_system/db/PriorityHelper.dart';
import 'package:note_management_system/model/Priorities.dart';

import '../model/User.dart';
import '../ultilities/Constant.dart';

// ignore: must_be_immutable
class PriorityScreen extends StatelessWidget {
  User user;

  PriorityScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _PriorityScreen(user: user));
  }
}

// ignore: must_be_immutable
class _PriorityScreen extends StatefulWidget {
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
    final List<Map<String, dynamic>> data =
        await PriorityHelper.getAllItem(user.id!);
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
    if (id != null) {
      final existingJournal = _priority
          .firstWhere((element) => element[Constant.KEY_PRIORITY_ID] == id);
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
              "Are you sure you want to delete this ${_priority[index][Constant.KEY_PRIORITY_NAME]} priority?"),
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
        await PriorityHelper.deleteItem(id);
        _refreshPriority();
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Delete priority ${_priority[index][Constant.KEY_PRIORITY_NAME]} successfully!"),
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
        int? id = await PriorityHelper.createItem(Priorities(
          name: _textNameController.text,
          userId: user.id,
        ));
        if (id == null) {
          message = 'Please enter another name, this name already exists!';
        } else {
          message = 'Create priority successfully';
          _refreshPriority();
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
        int? updatePriority = await PriorityHelper.updateItem(Priorities(
          id: id,
          name: _textNameController.text,
          userId: user.id,
        ));

        if (updatePriority == null) {
          message = 'Please enter another name, this name already exists!';
        } else {
          message = 'Successful priority update!';
          _refreshPriority();
        }
      }
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<void> _deleteItem(int id, int index) async {

    int? result = await PriorityHelper.deleteItem(id);
    if (result == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Can not delete this '
                '${_priority[index][Constant.KEY_PRIORITY_NAME]} '
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
              itemCount: _priority.length,
              itemBuilder: (context, index) => Card(
                color: Colors.blueGrey[200],
                margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
                child: ListTile(
                  title: Text(
                      'Name: ${_priority[index][Constant.KEY_PRIORITY_NAME]}'),
                  subtitle: Text(
                      'Created At: ${_priority[index][Constant.KEY_PRIORITY_CREATED_DATE]}'),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => _showForm(
                              _priority[index][Constant.KEY_PRIORITY_ID]),
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                            onPressed: () => _deleteItem(
                                _priority[index][Constant.KEY_PRIORITY_ID],
                                index),
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
