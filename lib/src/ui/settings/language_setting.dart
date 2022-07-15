import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Setting', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),),
              const SizedBox(height: 12,),
              const Text('LANGUAGE',style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),),
              const SizedBox(height: 12,),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Select language',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                  Row(children: [
                    Text('EN',style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.grey[500]),),
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: (){
                        
                      },
                      child: SvgPicture.asset('lib/assets/icons/change.svg', height: 20, width: 20,)),
                  ],),
                ],
               ),
              
            ],
          ),
        ),
      ),
    );
  }
}