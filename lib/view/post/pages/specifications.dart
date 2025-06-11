import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/common_widgets/breadcrump.dart';
import 'package:simple_nav_bar/common_widgets/custom_title.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/details_page_controller/details_page_controller.dart';
import 'package:simple_nav_bar/controllers/location_controller/location_controller.dart';
import 'package:simple_nav_bar/controllers/specifications/specification_controller.dart';

class Specifications extends StatefulWidget {
  final int currentPage;
  final int index;
  final PageController controller;
  const Specifications({
    super.key,
    required this.currentPage,
    required this.index,
    required this.controller,
  });

  @override
  State<Specifications> createState() => _Specifications();
}

class _Specifications extends State<Specifications> {
  late int currentPage;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final detailsController = Get.find<DetailsPageController>();
  final locationController = Get.find<LocationController>();
  final specificationController = Get.find<SpecificationController>();

  @override
  void initState() {
    super.initState();
    currentPage = widget.currentPage;
  }

  @override
  void dispose() {
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
                  title: "Specifications",
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
                      Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildLocalizationLabeledField(
                              label: "Modele *",
                              onChanged: specificationController.filterModels,
                              hintText: "un model",
                              hintText1: "model",
                              items: specificationController.modeles,
                              selectedItemRx:
                                  specificationController.selectedModel,
                              showError: specificationController.showModelError,
                              showTouched: specificationController.modelTouched,
                            ),

                            buildLocalizationLabeledField(
                              label: "Stockage *",
                              onChanged: specificationController.filterStorage,
                              hintText: "un stockage",
                              hintText1: "stockage",
                              items: specificationController.storages,
                              selectedItemRx:
                                  specificationController.selectedStorage,
                              showError:
                                  specificationController.showStorageError,
                              showTouched:
                                  specificationController.storageTouched,
                            ),

                            buildLocalizationLabeledField(
                              label: "Couleur *",
                              onChanged: specificationController.filterColor,
                              hintText: "une couleur",
                              hintText1: "couleur",
                              items: specificationController.colors,
                              selectedItemRx:
                                  specificationController.selectedColor,
                              showError: specificationController.showColorError,
                              showTouched: specificationController.colorTouched,
                            ),

                            buildLocalizationLabeledField(
                              label: "Etat de la baterie *",
                              onChanged: specificationController.filterState,
                              hintText: "l'etat de la baterie",
                              hintText1: "etat de la baterie",
                              items: specificationController.bateryStates,
                              selectedItemRx:
                                  specificationController.selectedBateryState,
                              showError:
                                  specificationController.showBateryStateError,
                              showTouched:
                                  specificationController.bateryStateTouched,
                            ),

                            buildLocalizationLabeledField(
                              label: "Guarantie *",
                              onChanged:
                                  specificationController.filterGuarantee,
                              hintText1: "gurentie",
                              hintText: "une guarentie",
                              items: specificationController.guarentees,
                              selectedItemRx:
                                  specificationController.selectedGuarantee,
                              showError:
                                  specificationController.showGuaranteeError,
                              showSearcharea: true,
                              showTouched:
                                  specificationController.guaranteeTouched,
                            ),
                            buildLocalizationLabeledField(
                              label: "Etat *",
                              onChanged:
                                  specificationController.filterCondition,
                              hintText1: "l'etat",
                              hintText: "etat",
                              items: specificationController.conditions,
                              selectedItemRx:
                                  specificationController.selectedCondition,
                              showError:
                                  specificationController.showConditionError,
                              showSearcharea: true,
                              showTouched:
                                  specificationController.conditionTouched,
                            ),
                            const SizedBox(height: 8),
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

  String truncateWithEllipsis(String s, {int cutoff = 30}) {
    if (s.length <= cutoff) return s;
    return '${s.substring(0, 20)} ...';
  }

  Widget buildLocalizationLabeledField({
    required String label,
    required String hintText,
    required String hintText1,
    required List<String> items,
    required Rx<String?> selectedItemRx,
    required Function(String)? onChanged,
    required RxBool showError,
    required RxBool showTouched,
    bool showSearcharea = false,
  }) {
    final width = MediaQuery.sizeOf(Get.context!).width * 0.82;
    final height = MediaQuery.sizeOf(Get.context!).height / 22;
    return GestureDetector(
      onTap: () {
        Get.dialog(
          cityDialog(
            onChanged: onChanged,
            hintText1: hintText1,
            hintText: hintText,
            items: items,
            selectedItemRx: selectedItemRx,
            showError: showError,
            showTouched: showTouched,
            showSearcharea: showSearcharea,
          ),
          barrierDismissible: true,
          transitionDuration: Duration(milliseconds: 0),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4),
        child: Obx(() {
          final item = selectedItemRx.value;
          String locationText = item ?? "Selectionner $hintText";

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTitle(title: label),
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.all(8),
                width: width,
                height: height,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: greyColo1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  //spacing: spacing,
                  children: [
                    Text(
                      truncateWithEllipsis(locationText),
                      style: GoogleFonts.playfairDisplay(
                        textStyle: TextStyle(overflow: TextOverflow.ellipsis),

                        fontSize: 14,
                        color: item == null ? Colors.grey[600] : Colors.black,
                      ),
                    ),

                    Icon(Icons.arrow_forward_ios, color: greyColo1, size: 14),

                    //const SizedBox(width: 8),
                  ],
                ),
              ),
              if (showError.value && showTouched.value) ...[
                const SizedBox(height: 4),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        "$hintText1 n'est page encore selectionner",
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

  Widget cityDialog({
    required Function(String)? onChanged,
    required String hintText,
    required String hintText1,
    required List<String> items,
    required Rx<String?> selectedItemRx,
    required RxBool showError,
    required RxBool showTouched,
    bool showSearcharea = false,
  }) {
    //specificationController.resetSelectedModel();
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
                    "Selectionner $hintText1",
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
            if (!showSearcharea) ...[
              const SizedBox(height: 4),
              TextField(
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintText: "Rechercher $hintText",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Obx(() {
              //final modeles = specificationController.filteredModels;
              final listItems = items;
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
                    listItems.isEmpty
                        ? Center(child: Text("Aucun $hintText1 trouvée"))
                        : ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: listItems.length,
                            itemBuilder: (_, index) {
                              final item = listItems[index];
                              final isSelected = selectedItemRx.value == item;
                              return Card(
                                color:
                                    isSelected
                                        ? purple_600.withValues(alpha: 0.2)
                                        : whiteColor,
                                shape: LinearBorder(),
                                margin: const EdgeInsets.only(bottom: 0.3),
                                child: ListTile(
                                  title: Text(item),
                                  trailing:
                                      isSelected
                                          ? const Icon(Icons.check, size: 14)
                                          : null,

                                  onTap: () {
                                    selectedItemRx.value = item;
                                    showError.value = false;
                                    showTouched.value = false;
                                    onChanged?.call(item);
                                    Get.back();
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
}
