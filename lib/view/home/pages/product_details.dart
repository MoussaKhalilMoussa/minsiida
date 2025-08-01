import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/constants/constant_values.dart';
import 'package:simple_nav_bar/constants/lists.dart';
import 'package:simple_nav_bar/controllers/product_controller/product_details_controller.dart';
import 'package:simple_nav_bar/view/home/widgets/feature_ads.dart';
import 'package:simple_nav_bar/view/home/widgets/profile_summary.dart';
import 'package:simple_nav_bar/view/home/widgets/shipping_method.dart';

class ProductDetails extends StatelessWidget {
  ProductDetails({super.key});

  final PageController _pageController = PageController();
  final scrollController = ScrollController(initialScrollOffset: 0);
  final productDetailsController = Get.put(ProductDetailsController());
  var buttonSize = Size(MediaQuery.sizeOf(Get.context!).width / 2.2, 50);

  @override
  Widget build(BuildContext context) {
    final product = productDetailsController.selectedProduct;
    final images = product['image'] as List;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(LucideIcons.chevronLeft, color: blackColor2),
              ),
              //title: Text("Product Details"),
              pinned: true,
              elevation: 0,
              actions: [
                IconButton(onPressed: () {}, icon: Icon(LucideIcons.share2)),
                IconButton(onPressed: () {}, icon: Icon(LucideIcons.heart)),
                IconButton(
                  onPressed: () {},
                  icon: Icon(LucideIcons.moreVertical),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: Divider(height: 1, thickness: 1),
              ),
            ),

            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        height: 400,
                        child: PageView.builder(
                          controller: _pageController,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(8),
                              ),
                              child: Image.network(
                                images[index],
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 12,
                        left: 12,
                        child: Obx(() {
                          final currentIndex =
                              productDetailsController
                                  .selectedImageIndex
                                  .value +
                              1;
                          final total = images.length;
                          return Container(
                            padding: EdgeInsets.only(
                              right: 10,
                              left: 10,
                              top: 2,
                              bottom: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              "$currentIndex / $total",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 90,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemCount: images.length,
                        itemBuilder: (context, index) {
                          return Obx(() {
                            final isSelected =
                                productDetailsController
                                    .selectedImageIndex
                                    .value ==
                                index;

                            return GestureDetector(
                              onTap: () {
                                productDetailsController
                                    .selectedImageIndex
                                    .value = index;
                                _pageController.jumpToPage(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        isSelected
                                            ? Colors.blue
                                            : Colors.transparent,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    images[index],
                                    width: MediaQuery.sizeOf(context).width / 6,
                                    height: 90,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          });
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      product['price'],
                      style: GoogleFonts.playfairDisplay(
                        color: blackColor2,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Product Name",
                      style: GoogleFonts.playfairDisplay(
                        color: blackColor2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  //SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 24.h,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Text(
                            "Accueil > Téléphones & Objets connectés > Champagne-Ardenne > Marne > Châlons-en-Champagne 51000 > iPhone 12 Pro",
                            style: GoogleFonts.playfairDisplay(
                              fontWeight: FontWeight.w400,
                              color: greyColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 25,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                LucideIcons.mapPin,
                                size: 18,
                                color: greyColor,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "Goudji,N'djamena",
                                style: GoogleFonts.playfairDisplay(
                                  fontWeight: FontWeight.w400,
                                  color: greyColor,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            product['date'],
                            style: GoogleFonts.playfairDisplay(
                              fontWeight: FontWeight.w400,
                              color: greyColor,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                      right: 8,
                      top: 0,
                      bottom: 8,
                    ),
                    child: Divider(
                      height: 4,
                      thickness: 8,
                      color: greyColo1.withValues(alpha: 0.5),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Caractéristiques de l'annonce",
                          style: GoogleFonts.playfairDisplay(
                            color: blackColor2,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Numéro de l'annonce",
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.w400,
                                color: greyColor,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "1701731687",
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.bold,
                                color: blackColor2,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Marque",
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.w400,
                                color: greyColor,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Autre",
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.bold,
                                color: blackColor2,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "RAM",
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.w400,
                                color: greyColor,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "32 Go",
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.bold,
                                color: blackColor2,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Taille de l'écran",
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.w400,
                                color: greyColor,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "27 Pouces",
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.bold,
                                color: blackColor2,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Garantie",
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.w400,
                                color: greyColor,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Oui",
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.bold,
                                color: blackColor2,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "État",
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.w400,
                                color: greyColor,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "Comme neuf",
                              style: GoogleFonts.playfairDisplay(
                                fontWeight: FontWeight.bold,
                                color: blackColor2,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Description",
                      style: GoogleFonts.playfairDisplay(
                        color: blackColor2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      product['description'],
                      textAlign: TextAlign.justify,
                      style: GoogleFonts.playfairDisplay(
                        color: greyColor,
                        //fontSize: 30,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Kargo seçenekleri",
                      style: GoogleFonts.playfairDisplay(
                        color: blackColor2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: shippingMethod(
                      icon: "📦",
                      title: "Mondial Relay",
                      subTitle: "En point de retrait sous 3-5 jours",
                      price: "3,49 €",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: shippingMethod(
                      icon: "🚚",
                      title: "Shop2Shop by Chronopost",
                      subTitle: "En point de retrait sous 3-5 jours",
                      price: "3,49 €",
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: shippingMethod(
                      icon: "🏠",
                      title: "Colissimo",
                      subTitle: "À votre domicile sous 2-3 jours",
                      price: "7,35 €",
                    ),
                  ),
                  SizedBox(height: 4),
                  Padding(padding: EdgeInsets.all(8), child: ProfleSummary()),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _sectionHeader(
                      "Autres annonces interessantes",
                      "Voir plus d'annonces",
                    ),
                  ),
                  FeaturedAdsListView(
                    ads: featuredAds,
                    //controller: scrollController,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {},

              style: ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(whiteColor),
                backgroundColor: WidgetStatePropertyAll(Colors.orange.shade700),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                fixedSize: WidgetStatePropertyAll(buttonSize),
              ),

              child: Text(
                "Profile",
                style: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                //elevation: WidgetStatePropertyAll(0),
                foregroundColor: WidgetStatePropertyAll(whiteColor),
                backgroundColor: WidgetStatePropertyAll(primaryColor),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                ),
                fixedSize: WidgetStatePropertyAll(buttonSize),
              ),
              child: Text(
                "Message",
                style: GoogleFonts.playfairDisplay(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader(String title, String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: mainMargin),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              color: blackColor2,
              fontSize: 14.sp,
            ),
          ),
          InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: GoogleFonts.playfairDisplay(
                    fontWeight: FontWeight.bold,
                    color: greyColor,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(width: 8.w),
                Padding(
                  padding: EdgeInsetsGeometry.only(top: 3),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 10.sp,
                    color: greyColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
