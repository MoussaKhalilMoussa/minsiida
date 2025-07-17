import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class TableauDeBoard extends StatelessWidget {
  const TableauDeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 245, 250),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            centerTitle: true,
            title: Text(
              'Tableau de Bord',
              style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              icon: const Icon(Ionicons.chevron_back_outline),
              onPressed: () {
                Get.back(

                );
              },
            ),
            floating: true,
            snap: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ListTile(
                leading: const Icon(Icons.dashboard),
                title: const Text('Dashboard Item 1'),
                subtitle: const Text('Subtitle for item 1'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  // Handle tap
                },
              ),
              ListTile(
                leading: const Icon(Icons.analytics),
                title: const Text('Dashboard Item 2'),
                subtitle: const Text('Subtitle for item 2'),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  // Handle tap
                },
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
