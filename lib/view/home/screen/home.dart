import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/constant_values.dart';
import 'package:simple_nav_bar/constants/images.dart';
import 'package:simple_nav_bar/constants/lists.dart';
import 'package:simple_nav_bar/controllers/home_controller/home_controller.dart';
import 'package:simple_nav_bar/view/categories/screen/categories_page.dart';
import 'package:simple_nav_bar/view/home/screen/category_main_content.dart';
import 'package:simple_nav_bar/view/home/screen/home_main_content.dart';
import 'package:simple_nav_bar/view/home/widgets/hoverable_category_item_widget.dart';
import 'package:simple_nav_bar/view/home/widgets/widget_components.dart';
import 'package:simple_nav_bar/view/menu/widgets/menu_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  bool _isDrawerOpen = false;
  bool _isCategoriesOpen = false;

  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  var currentPage = 0;
  int currentStartIndex = 0;

  int currentStartIndex1 = 0;
  int currentPage1 = 0;

  int currentStartIndex2 = 0;
  int currentPage2 = 0;

  var scrollController = ScrollController(initialScrollOffset: 0);
  var scrollController1 = ScrollController(initialScrollOffset: 0);
  var scrollController2 = ScrollController(initialScrollOffset: 0);
  //var homeController = Get.put(HomeController());
  final homeController = Get.find<HomeController>();

  late double itemWidthWithSpacing;

  @override
  void initState() {
    //_selectedIndex = homeController.selectedIndex.value;
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    scrollController2.addListener(() {
      final scrollOffset = scrollController2.offset;
      final currentIndex = (scrollOffset / itemWidthWithSpacing).round();

      if (currentPage2 != currentIndex && currentIndex < featuredAds.length) {
        setState(() {
          currentPage2 = currentIndex;
        });
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    scrollController1.dispose();
    scrollController2.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == 0) {
      _selectedIndex = index;
      setState(() => _isDrawerOpen = true);
      _controller.forward();
    } else if (index == 1) {
      _selectedIndex = index;
      setState(() {
        _isCategoriesOpen = true;
      });
      _controller.forward();
    } else {
      setState(() {
        _selectedIndex = index;
        _isDrawerOpen = false;
        _isCategoriesOpen = false;
        _controller.reverse();
      });
    }
  }

  void _closeDrawer() {
    setState(() => _isDrawerOpen = false);
    _controller.reverse();
  }

  void _closeCategories() {
    setState(() => _isCategoriesOpen = false);
    _controller.reverse();
  }

  void _closeFilter() {
    setState(() => homeController.isFilterDrawerOpen.value = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    final double itemWidth = width * 0.30;
    final double spacing = 14.0;
    itemWidthWithSpacing = itemWidth + spacing;

    final List<Widget> widgets = [
      menuDrawer(
        context: context,
        closeDrawer: _closeDrawer,
        offsetAnimation: _offsetAnimation,
      ),
      CategoriesPage(
        //context: context,
        closeCategories: _closeCategories,
        offsetAnimation: _offsetAnimation,
      ),
    ];

    final List<Widget> widgets1 = [
      HomeMainContent(
        scrollController: scrollController,
        scrollController1: scrollController1,
        scrollController2: scrollController2,
        width: width,
        height: height,
        currentPage2: currentPage2,
        itemWidthWithSpacing: itemWidthWithSpacing,
        currentStartIndex: currentStartIndex,
        currentStartIndex1: currentStartIndex1,
        currentPage: currentPage,
        currentPage1: currentPage1,
      ),

      CategoryMainContent(
        scrollController: scrollController,
        scrollController1: scrollController1,
        scrollController2: scrollController2,
        width: width,
        height: height,
        currentPage2: currentPage2,
        itemWidthWithSpacing: itemWidthWithSpacing,
        currentStartIndex: currentStartIndex,
        currentStartIndex1: currentStartIndex1,
        currentPage: currentPage,
        currentPage1: currentPage1,
      ),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          return Stack(
            children: [
              //_pages[_selectedIndex],
              //NB: because of layout issue the top header section come second element of this stack widget
              widgets1[homeController.homeIndex.value],

              // Fixed top header (logo + search)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 50,
                            child: InkWell(
                              onTap: () => homeController.homeIndex.value = 0,
                              child: Image.asset(
                                minsiidaLogo,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ), // Replace with actual logo
                          Row(
                            children: [
                              Icon(Icons.location_on_outlined),
                              SizedBox(width: 4),
                              Text('N\'Djamena, Tchad'),
                              Icon(Icons.keyboard_arrow_down),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Rechercher sur MinSiida',
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Custom bottom nav and FAB
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        style: BorderStyle.none,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  // for reference, this is the height of the bottom nav bar
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        height: 80,
                        margin: EdgeInsets.symmetric(horizontal: mainMargin),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                          color: Colors.white,
                          border: Border(
                            top: BorderSide(
                              style: BorderStyle.solid,
                              color: Colors.grey.withValues(alpha: 0.7),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: MediaQuery.sizeOf(context).width / 7,
                          children: [
                            _buildNavItem(LucideIcons.menu, "Menu", 0),
                            _buildNavItem(LucideIcons.heart, "Favorites", 2),
                            // SizedBox(width: 60), // space for FAB
                            _buildNavItem(LucideIcons.grid, "Categories", 1),
                            _buildNavItem(LucideIcons.user, "Profile", 3),
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
                left: MediaQuery.sizeOf(context).width / 2 - 40,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/addPost');
                  },
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
                          LucideIcons.camera,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "",
                        style: TextStyle(
                          color:
                              _selectedIndex == 2 ? Colors.blue : Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Slide-in drawer
              for (int i = 0; i < widgets.length; i++)
                if (i == _selectedIndex) widgets[_selectedIndex],
              // Always last = on top
            ],
          );
        }),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    //final isSelected = _selectedIndex == index && !_isDrawerOpen;
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: greyColor, size: 30),
          SizedBox(height: 3),
          Text(
            label,
            style: GoogleFonts.playfairDisplay(
              fontSize: 12,
              color: greyColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
