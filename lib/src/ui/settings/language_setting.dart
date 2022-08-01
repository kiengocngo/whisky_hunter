import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String dropdownValue = 'EN';
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tr("setting_text"),
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                tr('language'),
                style: TMThemeData.fromContext(context).text_14_700,
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tr("select_language"),
                    style: TMThemeData.fromContext(context).text_14_700,
                  ),
                  Row(
                    children: [
                      DropdownButton<String>(
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
                        items: <String>['EN', 'VN']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
              // Todo: authenicate
              // const SizedBox(
              //   height: 6,
              // ),
              // InkWell(
              //   onTap: () {
              //     Get.toNamed(TMRoute.profile.name!);
              //   },
              //   child: Text(
              //     tr("profile"),
              //     style: TMThemeData.fromContext(context).text_14_700,
              //   ),
              // ),
              // const SizedBox(
              //   height: 12,
              // ),
              // BlocListener<AuthBloc, AuthState>(
              //   listener: (context, state) {
              //     if (state is Authenticated) {
              //       Get.offAndToNamed(TMRoute.signin.name!);
              //     }
              //   },
              //   child: InkWell(
              //       onTap: () {
              //         context.read<AuthBloc>().add(SignOutRequested());
              //       },
              //       child: Text(
              //         tr('logout'),
              //       )),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
