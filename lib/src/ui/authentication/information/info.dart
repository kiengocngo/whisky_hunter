import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:whisky_hunter/src/constant/constant.dart';

class Info extends StatefulWidget {
  const Info({
    Key? key,
  }) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  final GlobalManager globalManager = Get.find();
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
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(globalManager.uId)
                    .set({
                  'date_of_birth': _dobController.text,
                  'gender': _genderController.text,
                  'address': _addressController.text,
                });
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }
}
