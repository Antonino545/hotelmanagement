import 'package:flutter/material.dart';
import 'package:hotelmanagement/screen/impostazione.dart';
import 'package:hotelmanagement/screen/responsive/responsive.dart';
import '../ListScreen/finance.dart';
import '../ListScreen/list_booking.dart';

/*splitview is an adaptive class which displays a menu and content side by 
side on large screens and  show menu as bottom navigation bar when is a small screens*/
class SplitView extends StatefulWidget {
  const SplitView({Key? key}) : super(key: key);

  @override
  State<SplitView> createState() => _SplitViewState();
}

class _SplitViewState extends State<SplitView> {
  //selected menu item
  int _selectedIndex = 0;
  //menu items
  String customer = "Ospiti";
  String finance = "Finanza";
  String settings = "Impostazioni";
  static const List<Widget> _widget = <Widget>[
    ListBooking(),
    Finance(),
    Impostazioni(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //when screen is wide enough, show content and menu side by side
    if (isTab(context) || isDesktop(context)) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Row(
          children: [
            //menu
            NavigationDrawer(
              onDestinationSelected: _onItemTapped,
              selectedIndex: _selectedIndex,
              children: [
                const DrawerHeader(
                  child: Text(
                    "Hotel \nManagement",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                NavigationDrawerDestination(
                  icon: const Icon(Icons.person),
                  label: Text(customer),
                ),
                NavigationDrawerDestination(
                  icon: const Icon(Icons.euro),
                  label: Text(finance),
                ),
                NavigationDrawerDestination(
                  icon: const Icon(Icons.settings),
                  label: Text(settings),
                ),
              ],
            ),
            Expanded(flex: 2, child: _widget.elementAt(_selectedIndex)),
          ],
        ),
      );
    } else {
      //when screen is too small, show menu as bottom navigation bar
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: _widget.elementAt(_selectedIndex),
        bottomNavigationBar: NavigationBar(
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.person),
              label: customer,
            ),
            NavigationDestination(
              icon: const Icon(Icons.euro),
              label: finance,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings),
              label: settings,
            ),
          ],
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onItemTapped,
        ),
      );
    }
  }
}
