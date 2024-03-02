import 'package:cartlistmurchant/FUNCTION/apiCallback.dart';
import 'package:cartlistmurchant/PROVIDER/categoryProvider.dart';
import 'package:cartlistmurchant/PROVIDER/orderProvider.dart';
import 'package:cartlistmurchant/SCREEN/ORDER/orderScreen.dart';
import 'package:cartlistmurchant/SCREEN/PROFILE/profile.dart';
import 'package:cartlistmurchant/SCREEN/STATICS/statics.dart';
import 'package:cartlistmurchant/SERVICE/SERVICE_GET/getOrder.dart';
import 'package:cartlistmurchant/SHAREPREF/cartlistSharepref.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class HomeNavigaton extends StatefulWidget {
  const HomeNavigaton({super.key});

  @override
  State<HomeNavigaton> createState() => _HomeNavigatonState();
}

class _HomeNavigatonState extends State<HomeNavigaton> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    OrderScreen(),
    StaticsScreen(),
    Profile()
  ];

  void _onItemTapped(int index) {
    var provider = Provider.of<CategoryProvider>(context, listen: false);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SizedBox(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: GNav(
          haptic: true,
          tabBorderRadius: 15,
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 900),
          selectedIndex: _selectedIndex,
          onTabChange: _onItemTapped,
          color: Colors.grey[800],
          activeColor: Colors.lightGreen,
          iconSize: 24,
          tabBackgroundColor: Colors.lightGreen.withOpacity(0.1),
          tabMargin: const EdgeInsets.all(10), // selected tab background color
          padding: const EdgeInsets.symmetric(
              horizontal: 10, vertical: 5), // navigation bar padding
          tabs: const [
            GButton(
              icon: LineIcons.list,
              text: 'Order',
            ),
            GButton(
              icon: LineIcons.alternateFile,
              text: 'Statics',
            ),
            GButton(
              icon: LineIcons.shopware,
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
