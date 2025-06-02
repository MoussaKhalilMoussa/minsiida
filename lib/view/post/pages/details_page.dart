import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/common_widgets/breadcrump.dart';
import 'package:simple_nav_bar/common_widgets/custom_title.dart';
import 'package:simple_nav_bar/constants/colors.dart';

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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  final FocusNode _titleFocus = FocusNode();
  final FocusNode _priceFocus = FocusNode();
  final FocusNode _descFocus = FocusNode();

  bool _titleTouched = false;
  bool _priceTouched = false;
  bool _descTouched = false;

  @override
  void initState() {
    super.initState();
    currentPage = widget.currentPage;
    _titleFocus.addListener(() {
      if (!_titleFocus.hasFocus) {
        setState(() {
          _titleTouched = true;
        });
      }
    });

    _priceFocus.addListener(() {
      if (!_priceFocus.hasFocus) {
        setState(() {
          _priceTouched = true;
        });
      }
    });

    _descFocus.addListener(() {
      if (!_descFocus.hasFocus) {
        setState(() {
          _descTouched = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _titleFocus.dispose();
    _priceFocus.dispose();
    _descFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenW = MediaQuery.of(context).size.width;
    final screenH = MediaQuery.of(context).size.height;

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
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.8,
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
                            buildLabeledField(
                              label: "Titre",
                              hintText: "Que vendez-vous ?",
                              controller: _titleController,
                              focusNode: _titleFocus,
                              touched: _titleTouched,
                              errorText:
                                  _titleTouched &&
                                          _titleController.text.trim().isEmpty
                                      ? 'Le titre est requis.'
                                      : null,
                            ),
                            const SizedBox(height: 16),
                            buildPriceLabeledField(
                              label: "Prix",
                              hintText: "0",
                              controller: _priceController,
                              focusNode: _priceFocus,
                              touched: _priceTouched,
                              errorText:
                                  _priceTouched &&
                                          _priceController.text.trim().isEmpty
                                      ? 'Veuillez entrer un prix valide.'
                                      : null,
                            ),
                            const SizedBox(height: 16),
                            buildLabeledField(
                              label: "Description",
                              hintText: "Entrez la description du produit",
                              controller: _descController,
                              focusNode: _descFocus,
                              touched: _descTouched,
                              maxLines: 4,
                              errorText:
                                  _descTouched &&
                                          _descController.text.trim().isEmpty
                                      ? 'La description est requise.'
                                      : null,
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _titleTouched = true;
                                    _priceTouched = true;
                                    _descTouched = true;
                                  });
                                  if (_titleController.text.trim().isNotEmpty &&
                                      _priceController.text.trim().isNotEmpty &&
                                      _descController.text.trim().isNotEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text('Formulaire valide'),
                                      ),
                                    );
                                  }
                                },
                                child: Text("Soumettre"),
                              ),
                            ),
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
            controller: _priceController,
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
}
