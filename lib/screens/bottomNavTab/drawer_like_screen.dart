import 'package:flutter/material.dart';
import 'package:simple_nav_bar/constants/colors.dart';

void main() {
  runApp(MaterialApp(home: CustomNavWithDrawer()));
}

class CustomNavWithDrawer extends StatefulWidget {
  const CustomNavWithDrawer({super.key});

  @override
  State<CustomNavWithDrawer> createState() => _CustomNavWithDrawerState();
}

class _CustomNavWithDrawerState extends State<CustomNavWithDrawer>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _isDrawerOpen = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _onItemTapped(int index) {
    if (index == 3) {
      setState(() => _isDrawerOpen = true);
      _controller.forward();
    } else {
      setState(() {
        _selectedIndex = index;
        _isDrawerOpen = false;
        _controller.reverse();
      });
    }
  }

  void _closeDrawer() {
    setState(() => _isDrawerOpen = false);
    _controller.reverse();
  }

  final List<Widget> _pages = [
    Center(child: Text('Categories')),
    Center(child: Text('Favorites')),
    Center(child: Text('FAB Action Camera')),
    Center(child: Text('Drawer Trigger')),
    Center(child: Text('Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_selectedIndex],
          // Custom bottom nav and FAB
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 80,
              // for reference, this is the height of the bottom nav bar
              color: Colors.yellow,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildNavItem(Icons.menu, "Menu", 3),
                        _buildNavItem(Icons.favorite_border_outlined, "Favorites", 1),
                        // SizedBox(width: 60), // space for FAB
                        _buildNavItem(Icons.grid_view, "Categories", 0),
                        _buildNavItem(Icons.person_2_outlined, "Profile", 4),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Overlay background when drawer is open
          if (_isDrawerOpen)
            GestureDetector(
              onTap: _closeDrawer,
              child: Container(color: Colors.black.withValues(alpha: 0.5)),
            ),
          Positioned(
            bottom: 25,
            left: MediaQuery.of(context).size.width / 2 - 40,
            child: GestureDetector(
              onTap: () => _onItemTapped(2),
              child: Column(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: blueColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    "",
                    style: TextStyle(
                      color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Slide-in drawer
          SlideTransition(
            position: _offsetAnimation,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                children: [
                  AppBar(
                    title: Text("Drawer Panel"),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    actions: [
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.black),
                        onPressed: _closeDrawer,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "This is the drawer-like screen.",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index && !_isDrawerOpen;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: isSelected ? Colors.blue : Colors.grey, size: 30,),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.blue : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
