import 'package:flutter/material.dart';
import 'package:whisky_hunter/src/comp/dialog/tm_dialog.dart';
import 'package:whisky_hunter/src/sqflite/sql_helper.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Map<String, dynamic>> _journals = [];

  void _refreshJournals() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshJournals();
  }

  void _deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a whisky!'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Favorities Whisky',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: ListView.builder(
                  itemCount: _journals.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        TMDialog.show(context,
                            title: 'You are want to delete whisky?',
                            okText: 'Yes',
                            cancelText: 'Cancel', okHandler: () {
                          _deleteItem(_journals[index]['id']);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                        child: Card(
                          shadowColor: Colors.grey[300],
                          child: ListTile(
                            title: Text(_journals[index]['title']),
                            subtitle: Text(_journals[index]['description']),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
