import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whisky_hunter/theme/tm_colors.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String dropdownValue = 'VN';
  late SharedPreferences prefs;
  final _key = 'language';
  final List<String> language = [
    'EN',
    'VN',
  ];
  @override
  void initState() {
    super.initState();
    _getLanguage();
  }

  _getLanguage() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      final languageValue = prefs.getString(_key);
      if (languageValue != null) {
        dropdownValue = languageValue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TMColors.backgroundColor,
        centerTitle: true,
        title: Text(tr("setting_text"),
            style: TMThemeData.fromContext(context).textSetting),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              Text(
                tr('language'),
                style: TMThemeData.fromContext(context).textDataAuctionBold,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr("select_language"),
                    style: TMThemeData.fromContext(context).textDataAuctionBold,
                  ),
                  Row(
                    children: [
                      DropdownButton<String>(
                        iconEnabledColor: TMColors.backgroundColor,
                        dropdownColor: TMColors.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                        value: dropdownValue,
                        elevation: 16,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            if (dropdownValue == 'EN') {
                              context.setLocale(const Locale('en'));
                              Get.updateLocale(const Locale('en'));
                            } else if (dropdownValue == 'VN') {
                              context.setLocale(const Locale('vi'));
                              Get.updateLocale(const Locale('vi'));
                            }
                          });
                          prefs.setString(_key, dropdownValue);
                        },
                        items: <String>['VN', 'EN']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TMThemeData.fromContext(context).textLanguage,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
