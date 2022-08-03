import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:whisky_hunter/src/comp/dialog/tm_dialog.dart';
import 'package:whisky_hunter/src/sqflite/sql_helper.dart';
import 'package:whisky_hunter/theme/tm_colors.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';

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

  void _deleteItem(int id) {
    SQLHelper.deleteItemById(id);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Successfully deleted a whisky!'),
    ));
    _refreshJournals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TMColors.backgroundColor,
        centerTitle: true,
        title: Text(
          tr("favorite_whisky"),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontStyle: FontStyle.normal,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 12,
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          shadowColor: Colors.grey[300],
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: TMColors.gradient,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _journals[index]['title'],
                                    style: TMThemeData.fromContext(context)
                                        .textDataAuction,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    _journals[index]['description'],
                                    style: TMThemeData.fromContext(context)
                                        .textDataAuction,
                                  ),
                                ],
                              ),
                            ),
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
