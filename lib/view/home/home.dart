import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/constant_values.dart';
import 'package:simple_nav_bar/constants/images.dart';
import 'package:simple_nav_bar/constants/lists.dart';
import 'package:simple_nav_bar/view/categories/screen/categories_page.dart';
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

  late double itemWidthWithSpacing;

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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            //_pages[_selectedIndex],
            //NB: because of layout issue the top header section come second element of this stack widget
            Positioned.fill(
              child: ListView(
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 180),
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: mainMargin),
                    height: 170,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color(0xFFF4EDF8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Vendez, Achetez, Simplifiez votre vie!',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(LucideIcons.camera, color: whiteColor),
                          label: Text(
                            'Déposer une annonce',
                            style: GoogleFonts.playfairDisplay(
                              color: whiteColor,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blueColor,
                            shape: StadiumBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: mainMargin),
                    height:
                        80, // Optional: define a height for better layout control
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            categories1.map((cat) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0,
                                ),
                                child: HoverableCategoryItem(
                                  icon: cat['icon'],
                                  label: cat['label'],
                                  color: cat['color'],
                                  onTap: () {},
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ),

                  SizedBox(height: 12),
                  sectionHeader(" Meilleures annonces en \n vedette"),
                  SizedBox(height: 12),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: mainMargin),
                    height: height * 0.50,
                    child: ListView.builder(
                      controller: scrollController2,
                      scrollDirection: Axis.horizontal,
                      itemCount: featuredAds.length,
                      itemBuilder: (context, index) {
                        final ad = featuredAds[index];
                        return Container(
                          padding: EdgeInsets.all(8),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: width * 0.32,
                          height: height * 0.25,
                          //margin: EdgeInsets.symmetric(horizontal: 2),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.grey[200],
                                      ),
                                      height: height * 0.25,
                                      width: width * 0.32,
                                      child: Image.network(
                                        ad['image']!,
                                        height: height * 0.25,
                                        width: width * 0.32,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 14,
                                      child: Icon(Icons.favorite_border),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                spacing: 5,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.yellow.shade900,
                                    radius: 12,
                                    child: Text(
                                      ad['name']![0].toUpperCase(),
                                      style: GoogleFonts.playfairDisplay(
                                        fontSize: 12,
                                        color: whiteColor,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    ad['name']!,
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 12,
                                      color: blackColor2,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Text(
                                ad['description']!,
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 12,
                                  color: blackColor2,
                                  textStyle: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                ad['price']!,
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 12,
                                  color: blackColor2,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                ad['location']!,
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 12,
                                  color: greyColor,
                                ),
                              ),
                              Text(
                                ad['date']!,
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 12,
                                  color: greyColor,
                                ),
                              ),
                              SizedBox(height: 8),
                              Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100.withValues(
                                    alpha: .5,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Livraison possible',
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 11,
                                    color: Colors.blue.shade900,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        featuredAds.length - 2,
                        (i) => InkWell(
                          onTap: () {
                            setState(() {
                              currentPage2 = i;
                              scrollController2.animateTo(
                                i * itemWidthWithSpacing,
                                duration: Duration(milliseconds: 100),
                                curve: Curves.linear,
                              );
                            });
                          },
                          child: Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  currentPage2 == i
                                      ? Colors.yellow.shade900
                                      : Colors.grey.shade300,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  sectionHeader(" Nos annonces\n recommandées"),
                  _horizontalGrid(controller: scrollController1),
                  const SizedBox(height: 20),
                  sectionHeader(" Annonces tendances\n populaires"),
                  _horizontalGrid(controller: scrollController),
                  const SizedBox(height: 20),
                  footerSections(),
                  //const SizedBox(height: 25),
                ],
              ),
            ),

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
                          child: Image.asset(minsiidaLogo, fit: BoxFit.cover),
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
                        color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Slide-in drawer
            for (int i = 0; i < widgets.length; i++)
              if (i != _selectedIndex)
                widgets[_selectedIndex], // Always last = on top
          ],
        ),
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

  Widget _horizontalGrid({required controller}) {
    // Width of one item + horizontal margin
    var width = MediaQuery.sizeOf(context).width;
    var height = MediaQuery.sizeOf(context).height;
    final double itemWidth = width * 0.45;
    final double spacing = 14.0;
    final double itemWidthWithSpacing = itemWidth + spacing;
    final isFirstItem =
        controller == scrollController1
            ? currentStartIndex1 == 0
            : currentStartIndex == 0;

    final isLastItem =
        controller == scrollController1
            ? currentStartIndex1 >= featuredAds.length - 2
            : currentStartIndex >= featuredAds.length - 2;

    return SizedBox(
      height: height * 0.52,
      child: Stack(
        children: [
          SizedBox(
            height: height * 0.5,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 14),
              shrinkWrap: false,
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              scrollDirection: Axis.horizontal,
              itemCount: featuredAds.length,
              itemBuilder: (context, index) {
                final ad = featuredAds[index];

                return Container(
                  padding: EdgeInsets.all(8),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  width: width * 0.45,
                  height: height * 0.25,
                  //margin: EdgeInsets.symmetric(horizontal: 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[200],
                              ),
                              height: height * 0.25,
                              width: width * 0.45,
                              child: Image.network(
                                ad['image']!,
                                height: height * 0.25,
                                width: width * 0.45,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 14,
                              child: Icon(Icons.favorite_border),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        spacing: 5,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.yellow.shade900,
                            radius: 12,
                            child: Text(
                              ad['name']![0].toUpperCase(),
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 12,
                                color: whiteColor,
                              ),
                            ),
                          ),
                          Text(
                            ad['name']!,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 12,
                              color: blackColor2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        ad['description']!,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 12,
                          color: blackColor2,
                          textStyle: TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        ad['price']!,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 12,
                          color: blackColor2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        ad['location']!,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 12,
                          color: greyColor,
                        ),
                      ),
                      Text(
                        ad['date']!,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 12,
                          color: greyColor,
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100.withValues(alpha: .5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Livraison possible',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 11,
                            color: Colors.blue.shade900,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // Forward and Backward buttons
          Positioned(
            top: 145,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: mainMargin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: MediaQuery.sizeOf(context).width / 1.9,
                children: [
                  //backword button
                  InkWell(
                    onTap:
                        isFirstItem
                            ? null // disables interaction
                            : () {
                              final itemsPerPage =
                                  (width / itemWidthWithSpacing).floor();
                              if (controller == scrollController1) {
                                if (currentStartIndex1 > 0) {
                                  setState(() {
                                    currentStartIndex1--;

                                    if (currentStartIndex1 < 0) {
                                      currentStartIndex1 = 0;
                                    }
                                    currentPage1 = currentStartIndex1;
                                  });
                                  controller.animateTo(
                                    (currentStartIndex1 * itemWidthWithSpacing),
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.linear,
                                  );
                                }
                              } else {
                                if (currentStartIndex > 0) {
                                  setState(() {
                                    currentStartIndex--;
                                    if (currentStartIndex < 0) {
                                      currentStartIndex = 0;
                                    }
                                    currentPage = currentStartIndex;
                                  });
                                  controller.animateTo(
                                    (currentStartIndex * itemWidthWithSpacing),
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.linear,
                                  );
                                }
                              }
                            },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color:
                            isFirstItem
                                ? greyColo1.withValues(alpha: 0.8)
                                : whiteColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 12,
                        color: greyColor,
                      ),
                    ),
                  ),
                  // forword button
                  InkWell(
                    onTap:
                        isLastItem
                            ? null
                            : () {
                              if (controller == scrollController1) {
                                if (currentStartIndex1 <
                                    featuredAds.length - 1) {
                                  // Ensure 2 visible
                                  setState(() {
                                    currentStartIndex1++;
                                    currentPage1 = currentStartIndex1;
                                  });
                                  controller.animateTo(
                                    currentStartIndex1 * itemWidthWithSpacing,
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.linear,
                                  );
                                }
                              } else {
                                if (currentStartIndex <
                                    featuredAds.length - 1) {
                                  // Ensure 2 visible
                                  setState(() {
                                    currentStartIndex++;
                                    currentPage = currentStartIndex;
                                  });
                                  controller.animateTo(
                                    currentStartIndex * itemWidthWithSpacing,
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.linear,
                                  );
                                }
                              }
                            },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: isLastItem ? greyColo1 : whiteColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: greyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                featuredAds.length - 1,
                (i) => InkWell(
                  onTap: () {
                    if (controller == scrollController1) {
                      setState(() {
                        currentStartIndex1 = i;
                        currentPage1 = i;
                      });
                      controller.animateTo(
                        (currentStartIndex1 * itemWidthWithSpacing),
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      setState(() {
                        currentStartIndex = i;
                        currentPage = i;
                      });
                      controller.animateTo(
                        (currentStartIndex * itemWidthWithSpacing),
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child:
                      controller == scrollController1
                          ? Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  currentPage1 == i
                                      ? Colors.yellow.shade900
                                      : Colors.grey.shade300,
                            ),
                          )
                          : Container(
                            width: 8,
                            height: 8,
                            margin: EdgeInsets.symmetric(horizontal: 2),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color:
                                  currentPage == i
                                      ? Colors.yellow.shade900
                                      : Colors.grey.shade300,
                            ),
                          ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
