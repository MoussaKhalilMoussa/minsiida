import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_nav_bar/common_widgets/breadcrump.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/delivery_controller/delivery_controller.dart';
import 'package:simple_nav_bar/view/post/widget/delivery_method_card.dart';

class DeliveryPage extends StatefulWidget {
  final int currentPage;
  final int index;
  final PageController controller;
  const DeliveryPage({
    super.key,
    required this.currentPage,
    required this.index,
    required this.controller,
  });

  @override
  State<DeliveryPage> createState() => _DeliveryPage();
}

class _DeliveryPage extends State<DeliveryPage> {
  late int currentPage;
  final deliveryController = Get.find<DeliveryController>();
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
    //final screenH = MediaQuery.sizeOf(Get.context!).height;

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
                  title: "Livraison",
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [const SizedBox(height: 8)],
                      ),
                      DeliveryMethodCard(
                        methodTitle: 'Paiement Sécurisé',
                        methodSubtitle:
                            'Expédiez votre article et recevez le paiement en \ntoute sécurité',
                      ),
                      DeliveryMethodCard(
                        showRecommandation: true,
                        methodTitle: 'Livraison en Personne',
                        methodSubtitle:
                            "Rencontrez l'acheteur et livrez en personne",
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 0,
                          color: const Color.fromARGB(255, 249, 252, 255),
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 10,
                              children: [
                                // Left side: Texts
                                Icon(size: 30, Icons.info, color: purple_600),
                                // Right side: Checkbox-like icon area
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 4),
                                      Text(
                                        "Vous pouvez proposer votre article avec les deux méthodes de livraison.\nLe Paiement Sécurisé offre une protection supplémentaire pour les acheteurs et les vendeurs.",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: blackColor2,
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

                      SizedBox(height: 16),
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
}
