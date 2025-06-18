import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/home_controller/home_controller.dart';
import 'package:simple_nav_bar/controllers/location_controller/location_controller.dart';
import 'package:simple_nav_bar/view/home/pages/select_city_for_filtering_page.dart';

Widget filterElements() {
  final categoryItems = [
    {"model": "iphone iOS", "number": "127.787"},
    {"model": "Android", "number": "112.753"},
    {"model": "Accessoires Teleohone", "number": "46.711"},
    {"model": "Autres Telephones", "number": "14.075"},
    {"model": "Pieces Detachees", "number": "12.201"},
    {"model": "Telephones Fixes", "number": "5.547"},
  ];

  final homeController = Get.put(HomeController());
  final locationController = Get.put(LocationController());
  return Obx(() {
    final isSelected = homeController.selectedSubCategory.value == "Telephones";
    final isCitySelected = locationController.selectedCity.value != null;
    final isSubprefectureSelected =
        locationController.selectedSubPrefecture.value.isNotEmpty;
    final city = locationController.selectedCity.value;
    var subPrefecture = locationController.selectedSubPrefecture.value;
    final filteredSubPrefectures = locationController.filteredSubPrefectures;

    return Column(
      children: [
        Column(
          children: [
            ExpansionTile(
              expandedAlignment: Alignment.centerLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text(
                "Categories",
                style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 0.0,
                    bottom: 8.0,
                    left: 24.0,
                  ),
                  child: Container(
                    width: MediaQuery.sizeOf(Get.context!).width * 0.88,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? Colors.grey.shade200
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: purple_600,
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Icon(
                            LucideIcons.phone,
                            color: whiteColor,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            homeController.selectedSubCategory.value =
                                "Telephones";
                          },
                          child: Text(
                            "Telephones",
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: blackColor2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    right: 26.0,
                    top: 0.0,
                    bottom: 8.0,
                    left: 60.0,
                  ),
                  child: Column(
                    spacing: 6,
                    children:
                        categoryItems.map((item) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  homeController.selectedSubCategory.value =
                                      item["model"]!;
                                },
                                child: Text(
                                  item["model"]!,
                                  style: GoogleFonts.playfairDisplay(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,

                                    color:
                                        homeController
                                                    .selectedSubCategory
                                                    .value ==
                                                item["model"]
                                            ? primaryColor
                                            : blackColor2,
                                  ),
                                ),
                              ),
                              Text(
                                "(${item['number']!})",
                                style: GoogleFonts.playfairDisplay(
                                  color: greyColo1,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),

            //lieu
            ExpansionTile(
              expandedAlignment: Alignment.centerLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text(
                "Lieu",
                style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 26.0,
                    top: 0.0,
                    bottom: 8.0,
                    left: 30.0,
                  ),
                  child: Column(
                    spacing: 6,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => SelectCityForFilteringPage(),
                            transition: Transition.noTransition,
                            duration: Duration.zero,
                          );
                          print("clicke cccccccccccc");
                        },
                        child: Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: greyColo1.withValues(alpha: 0.1),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    LucideIcons.mapPin,
                                    size: 20,
                                    color: greyColo1,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    isCitySelected ? city!.name : "city",
                                    style: GoogleFonts.playfairDisplay(
                                      color: blackColor2,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                              Icon(
                                LucideIcons.chevronRight,
                                size: 20,
                                color: greyColo1,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 0.5),
                      isCitySelected
                          ? DropdownButtonHideUnderline(
                            child: DropdownButton2<String>(
                              isExpanded: true,
                              customButton: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: greyColo1.withAlpha(25),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          LucideIcons.mapPin,
                                          size: 20,
                                          color: greyColo1,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          locationController
                                                  .selectedSubPrefecture
                                                  .value
                                                  .isEmpty
                                              ? "Sélectionner un quartier"
                                              : locationController
                                                  .selectedSubPrefecture
                                                  .value,
                                          style: GoogleFonts.playfairDisplay(
                                            color: blackColor2,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      LucideIcons.chevronRight,
                                      size: 20,
                                      color: greyColo1,
                                    ),
                                  ],
                                ),
                              ),
                              items:
                                  locationController.filteredSubPrefectures.map(
                                    (sub) {
                                      return DropdownMenuItem<String>(
                                        value: sub,
                                        child: Text(
                                          sub,
                                          style: GoogleFonts.playfairDisplay(
                                            fontSize: 16,
                                          ),
                                        ),
                                      );
                                    },
                                  ).toList(),
                              value:
                                  locationController.filteredSubPrefectures
                                          .contains(
                                            locationController
                                                .selectedSubPrefecture
                                                .value,
                                          )
                                      ? locationController
                                          .selectedSubPrefecture
                                          .value
                                      : null,
                              onChanged: (value) {
                                if (value != null) {
                                  locationController
                                      .selectedSubPrefecture
                                      .value = value;
                                }
                              },
                              dropdownStyleData: DropdownStyleData(
                                elevation: 2,
                                decoration: BoxDecoration(
                                  color: greyColo1.withValues(alpha: 5),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              menuItemStyleData: MenuItemStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                height: 40,
                              ),
                              iconStyleData: IconStyleData(
                                icon: SizedBox.shrink(), // Hide default arrow
                              ),
                            ),
                          )
                          : SizedBox.shrink(),

                      SizedBox(height: 0.5),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  LucideIcons.mapPin,
                                  size: 20,
                                  color: primaryColor,
                                ),
                                SizedBox(width: 8),
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
                    ],
                  ),
                ),
              ],
            ),
            // prix
            ExpansionTile(
              expandedAlignment: Alignment.centerLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text(
                "Prix",
                style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 26.0,
                    top: 0.0,
                    bottom: 8.0,
                    left: 30.0,
                  ),
                  child: Column(
                    spacing: 6,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color:
                                    homeController.isFocusedLeftField.value
                                        ? primaryColor
                                        : Colors.transparent,
                              ),
                              color: Colors.grey.withValues(alpha: 0.1),
                            ),
                            child: Focus(
                              onFocusChange: (hasFocus) {
                                homeController.setLeftFieldFocus(hasFocus);
                              },
                              child: TextField(
                                cursorHeight: 20,
                                controller: homeController.leftController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 12,
                                      right: 0,
                                    ), // spacing
                                    child: Text(
                                      "€",
                                      style: GoogleFonts.playfairDisplay(
                                        fontSize: 20,
                                        color: greyColo1,
                                      ),
                                    ),
                                  ),
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  ),
                                  hintText: "0",
                                  hintStyle: GoogleFonts.playfairDisplay(
                                    fontSize: 28,
                                    color: blackColor2,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 4),

                          Container(
                            width: 30,
                            height: 2,
                            decoration: BoxDecoration(color: greyColo1),
                          ),

                          SizedBox(width: 4),

                          Container(
                            width: 150,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color:
                                    homeController.isFocusedRightField.value
                                        ? primaryColor
                                        : Colors.transparent,
                              ),
                              color: Colors.grey.withValues(alpha: 0.1),
                            ),
                            child: Focus(
                              onFocusChange: (hasFocus) {
                                homeController.setRightFieldFocus(hasFocus);
                              },
                              child: TextField(
                                cursorHeight: 20,
                                textAlign: TextAlign.justify,
                                keyboardType: TextInputType.numberWithOptions(
                                  decimal: true,
                                ),
                                controller: homeController.rightController,
                                decoration: InputDecoration(
                                  isDense: true,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 12,
                                      right: 0,
                                    ), // spacing
                                    child: Text(
                                      "€",
                                      style: GoogleFonts.playfairDisplay(
                                        fontSize: 20,
                                        color: greyColo1,
                                      ),
                                    ),
                                  ),
                                  prefixIconConstraints: BoxConstraints(
                                    minWidth: 0,
                                    minHeight: 0,
                                  ),
                                  hintText: "500",
                                  hintStyle: GoogleFonts.playfairDisplay(
                                    fontSize: 28,
                                    fontStyle: FontStyle.normal,
                                    color: blackColor2,
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 6,
                                  ),
                                  border: InputBorder.none,
                                ),
                                style: GoogleFonts.playfairDisplay(
                                  fontSize: 28,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.5),
                      Wrap(
                        spacing: 8,
                        children:
                            ['<100', '<500', '<1000', '<5000'].map((label) {
                              final numericValue = label.replaceFirst('<', '');
                              final isSelected =
                                  homeController.selectedPreset.value ==
                                  numericValue;

                              return GestureDetector(
                                onTap:
                                    () => homeController.selectPresetValue(
                                      numericValue,
                                    ),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        isSelected
                                            ? primaryColor.withValues(
                                              alpha: 0.2,
                                            )
                                            : Colors.grey.withValues(
                                              alpha: 0.1,
                                            ),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color:
                                          isSelected
                                              ? primaryColor
                                              : Colors.transparent,
                                    ),
                                  ),
                                  child: Text(
                                    textAlign: TextAlign.justify,
                                    label,
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 18,
                                      color:
                                          isSelected
                                              ? primaryColor
                                              : Colors.black87,
                                      fontWeight:
                                          isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // Date de publication
            ExpansionTile(
              expandedAlignment: Alignment.centerLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text(
                "Date de publication",
                style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 26.0,
                    top: 0.0,
                    bottom: 8.0,
                    left: 30.0,
                  ),
                  child: Column(
                    children:
                        homeController.daysItems.map((item) {
                          return InkWell(
                            onTap:
                                () =>
                                    homeController.selectedDayFilter.value =
                                        item,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  child: Text(
                                    item,
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          homeController
                                                      .selectedDayFilter
                                                      .value ==
                                                  item
                                              ? primaryColor
                                              : blackColor2,
                                    ),
                                  ),
                                ),
                                Radio<String>(
                                  value: item,
                                  groupValue:
                                      homeController.selectedDayFilter.value,
                                  onChanged: (value) {
                                    if (value != null) {
                                      homeController.selectedDayFilter.value =
                                          value;
                                    }
                                  },
                                  activeColor: primaryColor,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
            //Filtrer par mot-clé
            ExpansionTile(
              expandedAlignment: Alignment.centerLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text(
                "Filtrer par mot-clé",
                style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 8.0,
                  ),
                  child: SizedBox(
                    width: MediaQuery.sizeOf(Get.context!).width * 0.9,
                    child: TextField(
                      focusNode: homeController.keywordFocus,
                      controller: homeController.keywordController,
                      decoration: InputDecoration(
                        hintText: 'Rechercher...',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon:
                            homeController.keywordText.value.isNotEmpty
                                ? IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    color: greyColo1,
                                    size: 18,
                                  ),
                                  onPressed: homeController.clearKeyword,
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
                          borderSide: BorderSide(
                            color: primaryColor.withValues(alpha: 0.5),
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //Vendeur vérifié
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Column with two Text widgets
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Vendeur vérifié',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Voir uniquement les annonces des vendeurs vérifiés',
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 12,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),

                  // Toggle Button
                  // Toggle Button with GetX
                  Obx(
                    () => Switch(
                      trackOutlineWidth: WidgetStateProperty.all(0),
                      activeTrackColor: primaryColor,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: greyColo1.withValues(alpha: 0.3),
                      //activeColor: primaryColor,
                      value: homeController.isSelected.value,
                      //isSelected: [homeController.isSelected.value],
                      onChanged: (_) => homeController.toggle(),
                    ),
                  ),
                ],
              ),
            ),
            //Note vendeur
            ExpansionTile(
              expandedAlignment: Alignment.centerLeft,
              expandedCrossAxisAlignment: CrossAxisAlignment.start,
              title: Text(
                "Note vendeur",
                style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 26.0,
                    top: 0.0,
                    bottom: 8.0,
                    left: 30.0,
                  ),
                  child: Column(
                    children:
                        homeController.vendeurList.map((item) {
                          return InkWell(
                            onTap:
                                () =>
                                    homeController.selectedVendor.value = item,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10.0,
                                  ),
                                  child: Text(
                                    item,
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          homeController.selectedVendor.value ==
                                                  item
                                              ? primaryColor
                                              : blackColor2,
                                    ),
                                  ),
                                ),
                                Radio<String>(
                                  value: item,
                                  groupValue:
                                      homeController.selectedVendor.value,
                                  onChanged: (value) {
                                    if (value != null) {
                                      homeController.selectedVendor.value =
                                          value;
                                    }
                                  },
                                  activeColor: primaryColor,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 24),
      ],
    );
  });
}
