import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:note_management_system/db/CategoryHelper.dart';
import 'package:note_management_system/model/Categories.dart';
import '../model/User.dart';
import '../ultilities/Constant.dart';
import 'package:note_management_system/dashboard_page/dashboard.dart';

// ignore: must_be_immutable
class CategoryScreen extends StatelessWidget {
  static const String routeName='/form/Category';
  User user = User();

  CategoryScreen({super. key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _CategoryScreen(user: user));
  }
}

// ignore: must_be_immutable
class _CategoryScreen extends StatefulWidget{

  User user;

  _CategoryScreen({Key? key, required this.user}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<_CategoryScreen> createState() => _CategoryScreenState(user: user);
}

class _CategoryScreenState extends State<_CategoryScreen> {

  User user;

  _CategoryScreenState({required this.user});

  List<Map<String, dynamic>> _categories = [];
  bool _isLoading = true;

  Future<void> _refreshCategories() async {
    final List<Map<String, dynamic>> data = await CategoryHelper.getAllItem(user.id!);
    setState(() {
      _categories = data;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshCategories();
  }

  final TextEditingController _textNameController = TextEditingController();

  void _showForm(int? id) async {

    if(id != null) {
      final existingJournal =
      _categories.firstWhere((element) => element[Constant.KEY_CATEGORY_ID] == id);
      _textNameController.text = existingJournal[Constant.KEY_CATEGORY_NAME];
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
    int? id = await CategoryHelper.createItem(Categories(
        name: _textNameController.text,
        userId: user.id,
        createdAt: dateFormat
    ));
    if(id != null){
      _refreshCategories();
    } else {
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Available Category')));
    }
  }

  Future<void> _updateItem(int id) async {
    String dateFormat = DateFormat("yyyy-mm-dd - kk:mm:ss").format(DateTime.now());
    await CategoryHelper.updateItem(Categories(
        id: id,
        name: _textNameController.text,
        userId: user.id,
        createdAt: dateFormat
    ));
    _refreshCategories();
  }

  Future<void> _deleteItem(int id) async {
      await CategoryHelper.deleteItem(id);

    if(!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a priority!'),
    ));
    _refreshCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Category'),
        leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteApp(user: user)))
        ),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      ) : ListView.builder(
        itemCount: _categories.length,
        itemBuilder: (context, index) => Card(
          color: Colors.blueGrey[200],
          margin: const EdgeInsets.only(
              left: 10, right: 10, top: 10
          ),
          child: ListTile(
            title: Text('Name: ${_categories[index][Constant.KEY_CATEGORY_NAME]}'),
            subtitle: Text('Created At: ${_categories[index][Constant.KEY_CATEGORY_CREATED_DATE]}'),
            trailing: SizedBox(
              width: 100,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => _showForm(_categories[index][Constant.KEY_CATEGORY_ID]),
                    icon: const Icon(Icons.edit),),
                  IconButton(
                    onPressed: () => _deleteItem(_categories[index][Constant.KEY_CATEGORY_ID]),
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