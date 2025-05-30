import 'package:flutter/material.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants.dart';
import 'package:simple_nav_bar/screens/more/more_screen.dart';
import 'package:simple_nav_bar/screens/profile/profile_screen.dart';
import 'package:simple_nav_bar/screens/team/team_screen.dart';

class FabTap extends StatefulWidget {
  int selectedIndex = 0;

  FabTap({super.key, this.selectedIndex = 0});

  @override
  State<FabTap> createState() => _FabTapState();
}

class _FabTapState extends State<FabTap> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  final List<Widget> pages = [
    // HomeScreen(),
    ProfileScreen(),
    TeamScreen(),
    MoreScreen(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    Widget curentScreen =
        _currentIndex == 1
            ? ProfileScreen()
            : _currentIndex == 2
            ? TeamScreen()
            : MoreScreen();
    return Scaffold(
      body: PageStorage(bucket: bucket, child: curentScreen),
      floatingActionButton: InkWell(
        onTap: () {
          print("Fab pressed");
        },
        child: Container(
          margin: const EdgeInsets.only(top: 15),
          height: bottomNavBarIconSize,
          width: bottomNavBarIconSize,
          decoration: BoxDecoration(
            color: blueColor,
            borderRadius: BorderRadius.circular(50),
            boxShadow: [
              BoxShadow(
                color: greyColor.withValues(alpha: 0.4),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 3), // Soft shadow below the button
              ),
            ],
          ),
          alignment: Alignment.center,
          //padding: const EdgeInsets.only(top: 10),
          child: const Icon(
            Icons.camera_alt_outlined,
            size: 33,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        //shadowColor: Colors.black,
        height: 60,
        padding: const EdgeInsets.only(top: 4, left: 4, right: 4),
        // when set it gives circular shape under the floating action button
        // shape: const CircularNotchedRectangle(),
        //notchMargin: 10,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            border: Border(
              top: BorderSide(color: Color.fromARGB(255, 158, 156, 156)),
            ),
          ),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: bottomNavBarIconSize,
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.menu_outlined,
                          //color: _currentIndex == 0 ? Colors.pinkAccent : greyColor,
                          color: greyColor,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          'Menu',
                          style: TextStyle(
                            //color: _currentIndex == 0 ? Colors.pinkAccent : Colors.grey,
                            color: greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),

                  MaterialButton(
                    minWidth: bottomNavBarIconSize,
                    onPressed: () {
                      setState(() {
                        curentScreen = MoreScreen();
                        _currentIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border_outlined, color: greyColor),
                        const SizedBox(height: 3),
                        Text('Favorites', style: TextStyle(color: greyColor)),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: bottomNavBarIconSize,
                    onPressed: () {
                      setState(() {
                        curentScreen = TeamScreen();
                        _currentIndex = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.grid_view_outlined, color: greyColor),
                        const SizedBox(height: 3),

                        Text('Categories', style: TextStyle(color: greyColor)),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: bottomNavBarIconSize,
                    onPressed: () {
                      setState(() {
                        curentScreen = ProfileScreen();
                        _currentIndex = 1;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_2_outlined, color: greyColor),
                        const SizedBox(height: 3),
                        Text('Profile', style: TextStyle(color: greyColor)),
                      ],
                    ),
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
