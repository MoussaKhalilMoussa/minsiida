import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';

class FeaturedAdCard extends StatelessWidget {
  final Map<String, String> ad;
  final double width;
  final double height;

  const FeaturedAdCard({
    Key? key,
    required this.ad,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.32,
      height: height * 0.50,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.grey[200],
                  height: height * 0.25,
                  width: width * 0.32,
                  child: Image.network(
                    ad['image'] ?? '',
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
                  child: const Icon(Icons.favorite_border),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.yellow.shade900,
                radius: 12,
                child: Text(
                  ad['name']?[0].toUpperCase() ?? '',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Text(
                ad['name'] ?? '',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 12,
                  color: blackColor2,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            ad['description'] ?? '',
            style: GoogleFonts.playfairDisplay(
              fontSize: 12,
              color: blackColor2,
              textStyle: const TextStyle(overflow: TextOverflow.ellipsis),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            ad['price'] ?? '',
            style: GoogleFonts.playfairDisplay(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: blackColor2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            ad['location'] ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.playfairDisplay(fontSize: 12, color: greyColor),
          ),
          Text(
            ad['date'] ?? '',
            style: GoogleFonts.playfairDisplay(fontSize: 12, color: greyColor),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.blue.shade100.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Livraison possible',
              textAlign: TextAlign.center,
              style: GoogleFonts.playfairDisplay(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.blue.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeaturedAdsListView extends StatefulWidget {
  final List<Map<String, String>> ads;
  final double width;
  final double height;
  final double margin;

  const FeaturedAdsListView({
    Key? key,
    required this.ads,
    required this.width,
    required this.height,
    this.margin = 8.0,
  }) : super(key: key);

  @override
  State<FeaturedAdsListView> createState() => _FeaturedAdsListViewState();
}

class _FeaturedAdsListViewState extends State<FeaturedAdsListView> {
  final ScrollController _scrollController = ScrollController();
  int _currentIndex = 0;

  double get itemWidth =>
      widget.width * 0.32 + 16; // item width + padding/margin

  void _onScroll() {
    final index = (_scrollController.offset / itemWidth).round();
    if (_currentIndex != index && index < widget.ads.length) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _scrollToIndex(int index) {
    _scrollController.animateTo(
      index * itemWidth,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: widget.margin),
          height: widget.height * 0.50,
          child: ListView.builder(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: widget.ads.length,
            itemBuilder: (context, index) {
              return FeaturedAdCard(
                ad: widget.ads[index],
                width: widget.width,
                height: widget.height,
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.ads.length - 2, (index) {
            final isActive = index == _currentIndex;
            return GestureDetector(
              onTap: () => _scrollToIndex(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: isActive ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
