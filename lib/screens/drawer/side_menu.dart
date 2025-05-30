import 'package:flutter/material.dart';
import 'package:simple_nav_bar/screens/bottomNavTab/fab_tap.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(1.0),
              bottomRight: Radius.circular(1.0),
            ),
              color: Colors.deepPurple,
              image: DecorationImage(image: AssetImage('assets/images/bgg1.jpg'), fit: BoxFit.cover),
            ),
            child: Text(
              'Min Siida',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) =>  FabTap(selectedIndex: 0,),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
             Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => FabTap(selectedIndex: 1,),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.more_horiz_outlined),
            title: const Text('More'),
            onTap: () {
             Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => FabTap(selectedIndex: 2,),
              ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_pin_outlined),
            title: const Text('Team'),
            onTap: () {
             Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => FabTap(selectedIndex: 3,),
              ));
            },
          ),
        ],
      ),
    );
  }
}