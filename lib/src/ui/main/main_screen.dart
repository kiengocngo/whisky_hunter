


import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whisky_hunter/src/ui/auction_data_screen.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget> [
    AuctionDataScreen(),
    AuctionDataScreen(),
    AuctionDataScreen(),
    AuctionDataScreen(),

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
          BottomNavigationBarItem(icon: SvgPicture.asset('lib/assets/icons/home.svg'),
          label: '',
          activeIcon: SvgPicture.asset('lib/assets/icons/hospital.svg'),
          ),
          BottomNavigationBarItem(icon: SvgPicture.asset('lib/assets/icons/home.svg'),
          label: '',
          activeIcon: SvgPicture.asset('lib/assets/icons/hospital.svg'),
          ),
          BottomNavigationBarItem(icon: SvgPicture.asset('lib/assets/icons/home.svg'),
          label: '',
          activeIcon: SvgPicture.asset('lib/assets/icons/hospital.svg'),
          ),
          BottomNavigationBarItem(icon: SvgPicture.asset('lib/assets/icons/home.svg'),
          label: '',
          activeIcon: SvgPicture.asset('lib/assets/icons/hospital.svg'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}