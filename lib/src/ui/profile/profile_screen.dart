import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:whisky_hunter/src/constant/constant.dart';
import 'package:whisky_hunter/src/constant/tm_icon.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:whisky_hunter/theme/tm_theme_data.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalManager globalManager = Get.find();
  final storge = firebase_storage.FirebaseStorage.instance;
  File? photo;
  final ImagePicker _picker = ImagePicker();
  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected');
      }
    });
  }

  Future uploadFile() async {
    if (photo == null) return;
    final fileName = basename(photo!.path);
    final destinaltion = 'files/$fileName';
    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destinaltion)
          .child('file/');
      await ref.putFile(photo!);
      String getdownloadUrl = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(globalManager.uId)
          .update({
        'img_profile': getdownloadUrl,
      });
    } catch (e) {
      print('error occured');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            CupertinoIcons.back,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('uid', whereIn: [globalManager.uId]).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return ListView(
              children: snapshot.data!.docs.map((e) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              e['img_profile'] != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Image.network(
                                          e['img_profile'],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Image.asset(
                                          TMIcons.person,
                                          height: 30,
                                          width: 30,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                              Positioned(
                                bottom: -2,
                                right: -0,
                                child: InkWell(
                                  onTap: () {
                                    _showPicker(context);
                                  },
                                  child: Icon(
                                    CupertinoIcons.camera_circle,
                                    color: e['img_profile'] != null
                                        ? Colors.amber
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            e['user_name'],
                            style: TMThemeData.fromContext(context)
                                .textDataAuctionBlack,
                            textScaleFactor: 1.0,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6.0,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                     
                      
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }

  _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    imgFromGallery();
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
