import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/common_widgets/breadcrump.dart';
import 'package:simple_nav_bar/common_widgets/custom_title.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/details_page_controller/details_page_controller.dart';
import 'package:simple_nav_bar/controllers/location_controller/location_controller.dart';

class DetailsPage extends StatefulWidget {
  final int currentPage;
  final int index;
  final PageController controller;
  const DetailsPage({
    super.key,
    required this.currentPage,
    required this.index,
    required this.controller,
  });

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late int currentPage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final locationController = Get.find<LocationController>();
  final detailsController = Get.find<DetailsPageController>();

  //var _titleController = detailsController.titleController
  // final TextEditingController _priceController = TextEditingController();
  // final TextEditingController _descController = TextEditingController();
  // final ScrollController _scrollController = ScrollController();

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _descFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    currentPage = widget.currentPage;

    detailsController.titleController.addListener(() {
      if (detailsController.titleTouched.value &&
          detailsController.titleController.text.trim().isNotEmpty) {
        detailsController.showTitleError.value = false;
      }
    });

    detailsController.priceController.addListener(() {
      if (detailsController.priceTouched.value &&
          detailsController.priceController.text.trim().isNotEmpty) {
        detailsController.showPriceError.value = false;
      }
    });

    detailsController.descController.addListener(() {
      if (detailsController.descTouched.value &&
          detailsController.descController.text.trim().isNotEmpty) {
        detailsController.showDescriptionError.value = false;
      }
    });

    _titleFocus.addListener(() {
      if (!_titleFocus.hasFocus) {
        setState(() {
          detailsController.titleTouched.value = true;
        });
      }
    });

    _priceFocus.addListener(() {
      if (!_priceFocus.hasFocus) {
        setState(() {
          detailsController.priceTouched.value = true;
        });
      }
    });

    _descFocus.addListener(() {
      if (!_descFocus.hasFocus) {
        setState(() {
          detailsController.descTouched.value = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _titleFocus.dispose();
    _priceFocus.dispose();
    _descFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.sizeOf(Get.context!).width;
    final screenH = MediaQuery.sizeOf(Get.context!).height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              //mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header section with title and progress bar parent
                // This section is fixed at the top of the screen
                Breadcrump(
                  title: "Details",
                  currentPage: widget.currentPage,
                  controller: widget.controller,
                ),
                const SizedBox(height: 30),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: screenW * 0.9,
                  //height: totalHeight,
                  //constraints: BoxConstraints(minHeight: totalHeight - 4),
                  padding: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 6,
                        color: Colors.grey.withValues(alpha: 0.2),
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  // And inside, we stack picker UI + images:
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.sizeOf(Get.context!).width * 0.8,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withValues(alpha: 0.2),
                                      blurRadius: 4,
                                      //spreadRadius: 1,
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Icon(
                                  Icons.smartphone,
                                  color: purple_600,
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Electroniques > Smartphones",
                                        style: GoogleFonts.playfairDisplay(
                                          fontSize: 12,
                                          color: purple_600,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Modifier",
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 12,
                                      color: purple_600,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(() {
                              return buildLabeledField(
                                label: "Titre",
                                hintText: "Que vendez-vous ?",
                                controller: detailsController.titleController,
                                focusNode: _titleFocus,
                                touched: detailsController.titleTouched.value,
                                errorText:
                                    detailsController.titleTouched.value &&
                                            detailsController
                                                    .showTitleError
                                                    .value ==
                                                true
                                        ? 'Le titre est requis.'
                                        : null,
                              );
                            }),
                            const SizedBox(height: 16),
                            Obx(() {
                              return buildPriceLabeledField(
                                label: "Prix",
                                hintText: "0",
                                controller: detailsController.priceController,
                                focusNode: _priceFocus,
                                touched: detailsController.priceTouched.value,
                                errorText:
                                    detailsController.priceTouched.value &&
                                            detailsController
                                                    .showPriceError
                                                    .value ==
                                                true
                                        ? 'Veuillez entrer un prix valide.'
                                        : null,
                              );
                            }),
                            const SizedBox(height: 16),
                            Obx(() {
                              return buildLabeledField(
                                label: "Description",
                                hintText: "Entrez la description du produit",
                                controller: detailsController.descController,
                                focusNode: _descFocus,
                                touched: detailsController.descTouched.value,
                                maxLines: 4,
                                errorText:
                                    detailsController.descTouched.value &&
                                            detailsController
                                                    .showDescriptionError
                                                    .value ==
                                                true
                                        ? 'La description est requise.'
                                        : null,
                              );
                            }),
                            const SizedBox(height: 2),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14.0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                spacing: 4,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    color: Colors.grey[600],
                                    size: 12,
                                  ),
                                  Text(
                                    "Inclurez l'état,les characteristiques et les raisons de la vente",
                                    style: GoogleFonts.playfairDisplay(
                                      fontSize: 10,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            buildLocalizationLabeledField(
                              label: "Localisation",
                              onChanged: locationController.filterCities,
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildLabeledField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool touched,
    required String? errorText,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitle(title: label),
          const SizedBox(height: 4),

          TextFormField(
            controller: controller,
            focusNode: focusNode,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
            ),
          ),

          if (errorText != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 18),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    errorText,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget buildPriceLabeledField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool touched,
    required String? errorText,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTitle(title: label),
          const SizedBox(height: 4),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: detailsController.priceController,
            focusNode: _priceFocus,
            decoration: InputDecoration(
              hintText: "0",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Chip(
                  side: BorderSide.none,
                  label: Text('Euro'),
                  backgroundColor: Colors.deepPurple.withValues(alpha: 0.1),
                  labelStyle: TextStyle(color: Colors.deepPurple[600]),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                ),
              ),
              // Remove the default padding around suffixIcon
              suffixIconConstraints: BoxConstraints(minHeight: 36, minWidth: 0),
            ),
          ),
          if (errorText != null) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 18),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    errorText,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget buildLocalizationLabeledField({
    required String label,
    required Function(String)? onChanged,
  }) {
    final spacing = MediaQuery.sizeOf(Get.context!).width * 0.26;
    return GestureDetector(
      onTap: () {
        locationController.resetSelection();
        Get.dialog(
          cityDialog(onChanged: onChanged),
          barrierDismissible: true,
          transitionDuration: Duration(milliseconds: 0),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4),
        child: Obx(() {
          final city = locationController.selectedCity.value;
          final subPref = locationController.selectedSubPrefecture.value;

          String locationText;

          if (city != null && subPref.isNotEmpty) {
            locationText = "${city.name} - $subPref";
          } else if (city != null) {
            locationText = city.name;
          } else {
            locationText = "Ajouter votre localisation";
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTitle(title: label),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: spacing,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.deepPurple[600],
                        size: 16,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        truncateWithEllipsis(locationText),
                        style: GoogleFonts.playfairDisplay(
                          textStyle: TextStyle(overflow: TextOverflow.ellipsis),

                          fontSize: 14,
                          color: city == null ? Colors.grey[600] : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  //const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey[600],
                    size: 14,
                  ),
                ],
              ),
              if (detailsController.showDetailsError.value) ...[
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'location address not selected',
                        style: const TextStyle(color: Colors.red, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          );
        }),
      ),
    );
  }

  Widget cityDialog({required Function(String)? onChanged}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 60.0),
      child: AlertDialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 6.0,
          vertical: 0.0,
        ),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        titlePadding: const EdgeInsets.symmetric(
          horizontal: 0.0,
          vertical: 0.0,
        ),
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 8.0, top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Selectionner un lieu",
                    style: TextStyle(
                      color: blackColor2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.close, color: blackColor2, size: 18),
                    onPressed: () => Navigator.of(Get.context!).pop(),
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey[300], thickness: 1),
          ],
        ),
        contentPadding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 12.0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.deepPurple.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.deepPurple[600],
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    "Utiliser ma Position Actuelle",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 14,
                      color: Colors.deepPurple[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: "Rechercher un lieu",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.only(left: 0),
              child: Text(
                "SELECTIONNER UNE VILLE",
                style: GoogleFonts.playfairDisplay(
                  color: blackColor2,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              final cities = locationController.filteredCities;
              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: greyColo1,
                    strokeAlign: 1.0,
                    width: 0.5,
                  ),
                ),
                height: MediaQuery.sizeOf(Get.context!).width * 0.7,
                width: MediaQuery.sizeOf(Get.context!).width * 0.9,
                child:
                    cities.isEmpty
                        ? Center(child: Text("Aucune ville trouvée"))
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: cities.length,
                            itemBuilder: (_, index) {
                              final city = cities[index];
                              return Card(
                                color: whiteColor,
                                shape: LinearBorder(),
                                margin: const EdgeInsets.only(bottom: 0.3),
                                child: ListTile(
                                  title: Text(city.name),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 14,
                                  ),
                                  onTap: () {
                                    locationController.filterSubPrefectures(
                                      city,
                                    );
                                    locationController.selectedCity.value =
                                        city;
                                    Get.back();
                                    locationController.filteredCities.value =
                                        locationController
                                            .cities; // Close current dialog
                                    Get.dialog(
                                      subPrefectureDialog(
                                        city: city,
                                        onChanged: (query) {
                                          locationController
                                              .filterSubPrefectures(
                                                city,
                                                query: query,
                                              );
                                        },
                                      ),
                                      barrierDismissible: true,
                                      transitionDuration: Duration(
                                        milliseconds: 0,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
              );
            }),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              locationController.resetSelection();
              Get.back();
            },
            style: ButtonStyle(
              fixedSize: WidgetStatePropertyAll(
                Size(MediaQuery.sizeOf(Get.context!).width, 44),
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              backgroundColor: WidgetStatePropertyAll(whiteColor),
            ),
            child: Text(
              "Annuler",
              style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
        actionsPadding: EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 12.0),
      ),
    );
  }

  Widget subPrefectureDialog({
    required var city,
    required Function(String)? onChanged,
  }) {
    final locationController = Get.find<LocationController>();
    final cityName = city.name;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 70.0),
      child: AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 6.0),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        titlePadding: const EdgeInsets.symmetric(
          horizontal: 0.0,
          vertical: 0.0,
        ),
        title: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0, right: 8.0, top: 8.0),
              child: Row(
                children: [
                  Text(
                    "Selectionner un lieu",
                    style: TextStyle(
                      color: blackColor2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.close, color: blackColor2, size: 18),
                    onPressed: () {
                      locationController.resetSelection();
                      Get.back();
                    },
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey[300], thickness: 1),
          ],
        ),
        contentPadding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back(); // Close subPrefecture dialog

                      locationController.filteredCities.value =
                          locationController.cities;
                      Get.dialog(
                        cityDialog(onChanged: onChanged),
                        barrierDismissible: true,
                        transitionDuration: Duration(milliseconds: 0),
                      );
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: blackColor2,
                      size: 20,
                    ),
                  ),
                  //const SizedBox(width: 2),
                  Text(
                    cityName,
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 14,
                      color: blackColor2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: "Rechercher une prefecture ou quartier",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[400]!),
                ),
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
              ),
            ),
            const SizedBox(height: 16),
            Obx(() {
              final subPrefectures = locationController.filteredSubPrefectures;

              return Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: greyColo1,
                    strokeAlign: 1.0,
                    width: 0.5,
                  ),
                ),
                height: MediaQuery.of(Get.context!).size.width * 0.7,
                width: MediaQuery.of(Get.context!).size.width * 0.9,
                child:
                    subPrefectures.isEmpty
                        ? Center(child: Text("Aucune préfecture trouvée"))
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: subPrefectures.length,
                            itemBuilder: (_, index) {
                              final subPref = subPrefectures[index];
                              final isSelected =
                                  locationController
                                      .selectedSubPrefecture
                                      .value ==
                                  subPref;
                              //locationController.selectedSubPrefecture.value = '';
                              return Card(
                                shape: LinearBorder(),
                                color:
                                    isSelected
                                        ? purple_600.withValues(alpha: 0.2)
                                        : whiteColor,
                                margin: const EdgeInsets.only(bottom: 0.3),
                                child: ListTile(
                                  title: Text(subPref),
                                  trailing:
                                      isSelected
                                          ? const Icon(Icons.check, size: 14)
                                          : null,
                                  onTap: () {
                                    locationController
                                        .selectedSubPrefecture
                                        .value = subPref;
                                    onChanged?.call(subPref);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
              );
            }),
          ],
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        actions: [
          ElevatedButton(
            onPressed: () {
              locationController.resetSelection();
              Get.back();
            },
            style: ButtonStyle(
              fixedSize: WidgetStatePropertyAll(Size(145, 44)),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              backgroundColor: WidgetStatePropertyAll(whiteColor),
            ),
            child: Text(
              "Annuler",
              style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              detailsController.showDetailsError.value = false;
            },
            style: ButtonStyle(
              fixedSize: WidgetStatePropertyAll(Size(145, 44)),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              backgroundColor: WidgetStatePropertyAll(purple_600),
              foregroundColor: WidgetStatePropertyAll(whiteColor),
            ),
            child: Text(
              "Confirm",
              style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  String truncateWithEllipsis(String s, {int cutoff = 20}) {
    if (s.length <= cutoff) return s;
    return '${s.substring(0, 20)} ...';
  }
}
