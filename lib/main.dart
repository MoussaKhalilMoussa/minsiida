import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/view/post/screen/add_post_screen.dart';
import 'view/home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Nav Bar',
      theme: ThemeData(
        textTheme: GoogleFonts.playfairDisplayTextTheme(),
        primarySwatch: Colors.purple,
      ),
      routes: {
        '/addPost': (context) => AddPostScreen(),
        '': (context) => HomeScreen(),
      },
      home: HomeScreen(),
    );
  }
}






























/* import 'package:flutter/material.dart';
import 'package:simple_nav_bar/constants.dart';
import 'package:simple_nav_bar/my_string.dart';

void main() => runApp(MinSiidaHome());

class MinSiidaHome extends StatelessWidget {
  const MinSiidaHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomeScreen(), debugShowCheckedModeBanner: false);
  }
}

class HomeScreen extends StatelessWidget {


  var navBarItems = [
    BottomNavigationBarItem(icon: Icon(Icons.menu, size: 26,), label: "Menu"),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_border, size: 26,),
      label: "Favoris",
    ),
    BottomNavigationBarItem(
      icon: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(Icons.camera_alt, color: Colors.white),
      ),
      label: '',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.grid_view),
      label: categories,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: account,
    ),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/icons/app_logo.png',
                  height: 26,
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
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFFF4EDF8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    'Vendez, Achetez, Simplifiez votre vie!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.camera_alt),
                    label: Text('Déposer une annonce'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: StadiumBorder(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
                  categories1.map((cat) {
                    return Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: cat['color'],
                          child: Icon(cat['icon'], color: Colors.white),
                        ),
                        SizedBox(height: 4),
                        Text(cat['label'], style: TextStyle(fontSize: 12)),
                      ],
                    );
                  }).toList(),
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Meilleures annonces en vedette',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Voir plus d\'annonces',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            SizedBox(height: 12),
            SizedBox(
              height: 180,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: featuredAds.length,
                itemBuilder: (context, index) {
                  final ad = featuredAds[index];
                  return Container(
                    width: 140,
                    margin: EdgeInsets.only(right: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                ad['image']!,
                                height: 120,
                                width: 140,
                                fit: BoxFit.cover,
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
                        Text(ad['name']!, style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black87,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: navBarItems
      ),
    );
  }
}
 */