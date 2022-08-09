import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whisky_hunter/src/ui/auction/aution_information.dart';
import 'package:whisky_hunter/src/ui/home/auction_data_screen.dart';
import 'package:whisky_hunter/src/ui/favortie/favorite_screen.dart';
import 'package:whisky_hunter/src/ui/settings/language_setting.dart';
import 'package:whisky_hunter/theme/tm_colors.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    AuctionDataScreen(),
    AuctionInformation(),
    FavoriteScreen(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  Container buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: TMColors.backgroundColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
              icon: _selectedIndex == 0
                  ? const Icon(
                      CupertinoIcons.home,
                      color: Colors.green,
                      size: 25,
                    )
                  : const Icon(
                      CupertinoIcons.home,
                      color: Colors.white,
                      size: 25,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              icon: _selectedIndex == 1
                  ? const Icon(
                      CupertinoIcons.archivebox,
                      color: Colors.green,
                      size: 25,
                    )
                  : const Icon(
                      CupertinoIcons.archivebox,
                      color: Colors.white,
                      size: 25,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
              icon: _selectedIndex == 2
                  ? const Icon(
                      CupertinoIcons.heart,
                      color: Colors.red,
                      size: 25,
                    )
                  : const Icon(
                      CupertinoIcons.heart,
                      color: Colors.white,
                      size: 25,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
              icon: _selectedIndex == 3
                  ? const Icon(
                      CupertinoIcons.settings,
                      color: Colors.green,
                      size: 25,
                    )
                  : const Icon(
                      CupertinoIcons.settings,
                      color: Colors.white,
                      size: 25,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
