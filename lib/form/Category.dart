import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:core';
import 'package:note_management_system/db/CategoryHelper.dart';
import 'package:note_management_system/model/Items.dart';
import 'package:note_management_system/ultilities/Constant.dart';

class CategoriesForm extends StatelessWidget {
  const CategoriesForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: _CategoriesScreen(),
    );
  }
}

class _CategoriesScreen extends StatefulWidget {
  const _CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<_CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<_CategoriesScreen> {
  List<Map<String, dynamic>> _allData = [];

  bool _isLoading = true;
//Get All Data
  Future<void> _refreshData() async {
    final data = await CategoryHelper.getAllItem();

    setState(() {
      _allData = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshData();   // Loading the diary when the app starts
  }
  final TextEditingController _titleController = TextEditingController();

  void _showForm(int? id) async {
    if(id != null) {
      final existingData = _allData.firstWhere((element) => element[Constant.KEY_CATEGORY_ID] == id);
      _titleController.text = existingData[Constant.KEY_CATEGORY_NAME];
    }

    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (_) => Container(
        padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: MediaQuery.of(context).viewInsets.bottom + 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(hintText: 'Name'),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.green[800]!),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () async {
                //Save new journal
                if (id == null) {
                  await _addItem();
                }
                if (id != null) {
                  await _updateItem(id);
                }

                //Clear the text fields
                _titleController.text = "";

                //Close the bottom sheet
                if (!mounted) return;

                Navigator.of(context).pop();
              },
              child: Text(id == null ? 'Create New' : 'Update'),
            )
          ],
        ),
      ),
    );
  }
  Future<void> _addItem() async {
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm:ss').format(DateTime.now());
    await CategoryHelper.createItem(Items(
      title: _titleController.text,
      createdAt: formattedDate,
    ));
    _refreshData();
  }

  Future<void> _updateItem(int id) async {
    await CategoryHelper.updateItem(Items(
      id: id,
      title: _titleController.text,));
    _refreshData();
  }

  Future<void> _deleteItem(int id) async {
    await CategoryHelper.deleteItem(id);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Successfully delete a category!'),));
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category Form'),
        backgroundColor: Colors.green[800],
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
        itemCount: _allData.length,
        itemBuilder: (context, index) => Card(
          color: Colors.blueGrey[200],
          margin: const EdgeInsets.all(10),
          child: ListTile(
            title: Text('Name: ${_allData[index][Constant.KEY_CATEGORY_NAME]}'),
            subtitle: Text('Created At: ${_allData[index][Constant.KEY_CATEGORY_CREATED_DATE]}'),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => _showForm(_allData[index][Constant.KEY_CATEGORY_ID]),
                    icon: const Icon(Icons.edit),),
                  IconButton(
                    onPressed: () => _deleteItem(_allData[index][Constant.KEY_CATEGORY_ID]),
                    icon: const Icon(Icons.delete),),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green[800],
        child: const Icon(Icons.add),
        onPressed: () => _showForm(null),
      ),
    );
  }
}

