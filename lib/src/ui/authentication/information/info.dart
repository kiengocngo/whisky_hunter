import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:whisky_hunter/src/comp/button.dart/tm_button.dart';

class Info extends StatefulWidget {
  final String uid;
  const Info({Key? key, required this.uid}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              controller: _dobController,
              decoration: InputDecoration(
                hintText: 'Date of birth',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            TextFormField(
              controller: _genderController,
              decoration: InputDecoration(
                  hintText: 'Gender',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
            ),
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                  hintText: 'Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  )),
            ),
            TMButton(
                content: "Update",
                onTap: () async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(widget.uid)
                      .update(
                    {
                      'birth_day': _dobController.text,
                      'address': _addressController.text,
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}
