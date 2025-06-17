import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/home_controller/home_controller.dart';
import 'package:simple_nav_bar/controllers/location_controller/location_controller.dart';

class SelectCityForFilteringPage extends StatelessWidget {
  const SelectCityForFilteringPage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.find<HomeController>();
    final locationController = Get.find<LocationController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              elevation: 0,
              toolbarHeight: 107, // increase height
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              //leadingWidth: 25,
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Filtres",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 18,
                      color: blackColor2,
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(LucideIcons.chevronLeft, color: blackColor2),
                      ),
                      SizedBox(width: 50),

                      Text(
                        "Sélectionner une ville",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: blackColor2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(2),
                child: Divider(height: 1, thickness: 1),
              ),
            ),

            SliverToBoxAdapter(
              child: Obx(() {
                final cities = locationController.filteredCities;

                return Column(
                  children: [
                    Container(
                      height: 50,
                      width: MediaQuery.sizeOf(Get.context!).width * 0.93,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: primaryColor.withValues(alpha: .1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                LucideIcons.mapPin,
                                size: 20,
                                color: primaryColor,
                              ),
                              SizedBox(width: 12),
                              Text(
                                "Utiliser ma position",
                                style: GoogleFonts.playfairDisplay(
                                  color: primaryColor,
                                  fontSize: 17,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.sizeOf(Get.context!).width * 0.93,
                      child: TextField(
                        onChanged: locationController.filterCities,
                        focusNode: homeController.cityKeywordFocus,
                        controller: homeController.cityKeywordController,
                        decoration: InputDecoration(
                          hintText: 'Rechercher...',
                          prefixIcon: Icon(Icons.search),
                          suffixIcon:
                              homeController.cityKeywordText.value.isNotEmpty
                                  ? IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      color: greyColo1,
                                      size: 18,
                                    ),
                                    onPressed: homeController.clearCityKeyword,
                                  )
                                  : null,
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide:
                                BorderSide
                                    .none, // use none here if you want soft look
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        //color: Colors.grey.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8.0),
                        //border: Border.all(strokeAlign: 1.0, width: 0.5),
                      ),
                      //height: MediaQuery.sizeOf(Get.context!).width * 0.7,
                      width: MediaQuery.sizeOf(Get.context!).width * 0.93,
                      child:
                          cities.isEmpty
                              ? Center(child: Text("Aucune ville trouvée"))
                              : ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: ListView.builder(
                                  padding: EdgeInsets.all(2),
                                  shrinkWrap: true,
                                  itemCount: cities.length,
                                  itemBuilder: (_, index) {
                                    final city = cities[index];
                                    return Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: greyColo1.withValues(alpha: 0.2),
                                        borderRadius: BorderRadius.circular(
                                          8.0,
                                        ),
                                      ),
                                      padding: EdgeInsets.all(8),
                                      margin: const EdgeInsets.all(4),
                                      child: InkWell(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(city.name),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              spacing: 30,
                                              children: [
                                                AnimatedContainer(
                                                  alignment:
                                                      Alignment.topCenter,
                                                  width: 50,
                                                  height: 25,
                                                  padding: EdgeInsets.all(1),
                                                  duration: Duration(
                                                    milliseconds: 200,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: whiteColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          50,
                                                        ),
                                                  ),
                                                  child: Text("12.995"),
                                                ),
                                                const Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 14,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        onTap: () {
                                          // 1. Set selected city
                                          locationController
                                              .selectedCity
                                              .value = city;

                                          // 2. Reset selected sub-prefecture (important to do BEFORE repopulating)
                                          locationController
                                              .selectedSubPrefecture
                                              .value = '';

                                          // 3. Repopulate sub-prefectures for this city
                                          locationController
                                              .filterSubPrefectures(city);

                                          // 4. Restore all cities
                                          locationController
                                                  .filteredCities
                                                  .value =
                                              locationController.cities;

                                          // 5. Close the city selection page
                                          Get.back(); // updates the list
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                    ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
