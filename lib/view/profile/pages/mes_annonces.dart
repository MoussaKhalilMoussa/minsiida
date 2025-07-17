import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

class MesAnnonces extends StatefulWidget {
  const MesAnnonces({super.key});

  @override
  State<MesAnnonces> createState() => _MesAnnoncesState();
}

class _MesAnnoncesState extends State<MesAnnonces> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            pinned: true,
            leading: IconButton(
              icon: const Icon(Ionicons.chevron_back_outline),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: Text(
              'My Ads',
              style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold),
            ),
            floating: true,
            snap: true,
          ),
          SliverToBoxAdapter(
            child: Divider(
              thickness: 1,
              color: Colors.grey.withValues(alpha: 0.2),
            ),
          ),
        ],
      ),
    );
  }
}
