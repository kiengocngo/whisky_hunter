


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whisky_hunter/src/ui/auction/aution_information.dart';
import 'package:whisky_hunter/src/ui/auction_data_screen.dart';
import 'package:whisky_hunter/src/ui/favortie/favorite_screen.dart';
import 'package:whisky_hunter/src/ui/settings/language_setting.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget> [
    AuctionDataScreen(),
    AuctionInformation(),
    FavoriteScreen(),
    Settings(),

  ];
  
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: SvgPicture.asset('lib/assets/icons/home.svg', width: 25, height: 25,),
          label: '',
          activeIcon: SvgPicture.asset('lib/assets/icons/home.svg', width: 30, height: 30,),
          ),
          BottomNavigationBarItem(icon: SvgPicture.asset('lib/assets/icons/auction.svg', height: 25, width: 25,),
          label: '',
          activeIcon: SvgPicture.asset('lib/assets/icons/auction.svg', width: 30,height: 30,),
          ),
          BottomNavigationBarItem(icon: SvgPicture.asset('lib/assets/icons/favorite.svg', height: 25, width: 25,),
          label: '',   
          activeIcon: ClipRRect(
            borderRadius: BorderRadius.circular(12),

            child: SvgPicture.asset('lib/assets/icons/favorite.svg', width: 30, height: 30, fit: BoxFit.scaleDown,), ),
          ),
          BottomNavigationBarItem(icon: SvgPicture.asset('lib/assets/icons/setting.svg', height: 25, width: 25,),
          label: '',
          activeIcon: SvgPicture.asset('lib/assets/icons/setting.svg',  height: 30, width: 30,),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}