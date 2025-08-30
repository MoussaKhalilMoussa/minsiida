import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/assistance_components_widgets/contacter_le_support.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/assistance_components_widgets/questions_frequantes.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/assistance_components_widgets/soumettre_un_ticket_de_support.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/parameters_components_widgets/auth_a_deux_facteur_not_container.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/parameters_components_widgets/comptes_connecte_not_container.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/parameters_components_widgets/email_notification_container.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/parameters_components_widgets/para_des_confi_not_container.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/parameters_components_widgets/supprimer_le_compte_not_container.dart';

class AideEtSupport extends StatelessWidget {
  const AideEtSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: CustomScrollView(
        //physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        slivers: [
          SliverAppBar(
            backgroundColor: whiteColor,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Ionicons.chevron_back_outline),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: Text(
              'Assistance',
              style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold),
            ),
            floating: true,
            snap: true,
          ),
          const SliverToBoxAdapter(child: Divider(height: 1)),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                width: MediaQuery.sizeOf(Get.context!).width,
                margin: EdgeInsets.only(right: 12, left: 12, top: 12),
                child: Column(
                  children: [
                    ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        const QuestionsFrequantes(),
                        SizedBox(height: 12.h),
                        const ContacterLeSupport(),
                        SizedBox(height: 12.h),
                        const SoumettreUnTicketDeSupport(),
                        SizedBox(height: 12.h),
                        const ComptesConnecteNotContainer(),
                        SizedBox(height: 12.h),
                        const SupprimerLeCompteNotContainer(),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
