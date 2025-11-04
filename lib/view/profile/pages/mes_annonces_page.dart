import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/common_widgets/looding_text.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/post_controller/post_controller.dart';
import 'package:simple_nav_bar/models/post.dart';
import 'package:simple_nav_bar/utiles/utitlity_functions.dart';
import 'package:simple_nav_bar/view/profile/widgets_utils/product_card.dart';

class MesAnnoncesPage extends StatefulWidget {
  const MesAnnoncesPage({super.key});

  @override
  State<MesAnnoncesPage> createState() => _MesAnnoncesPageState();
}

class _MesAnnoncesPageState extends State<MesAnnoncesPage> {
  final PostController postController = Get.find<PostController>();
  @override
  void initState() {
    postController.getAllMyPosts();
    super.initState();
  }

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
              'Mes annonces',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: blackColor,
              ),
            ),
            floating: true,
            snap: true,
          ),
          const SliverToBoxAdapter(child: Divider(height: 1)),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                width: MediaQuery.sizeOf(Get.context!).width,
                margin: EdgeInsets.only(right: 12, left: 12, top: 20),
                child: Row(
                  children: [
                    SizedBox(
                      height: 50.h,
                      width: MediaQuery.sizeOf(Get.context!).width * 0.79,
                      child: TextFormField(
                        //focusNode: FocusNode(),
                        onChanged: (value) => postController.searchMyAds(value),
                        style: GoogleFonts.poppins(color: blackColor),
                        decoration: InputDecoration(
                          //focusColor:  Colors.grey[400],
                          //isDense: true,
                          fillColor: whiteColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: greyColo1.withValues(alpha: 0.1),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: greyColor),
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          hintText: "Recherche...",
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    Spacer(),
                    IconButton.filled(
                      iconSize: 33,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(primaryColor),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(8),
                            side: BorderSide(color: greyColor),
                          ),
                        ),
                      ),
                      //color: primaryColor,
                      onPressed: () {},
                      icon: Icon(Ionicons.add_outline, color: whiteColor),
                    ),
                  ],
                ),
              ),
              Obx(() {
                return postController.myAddsLoading.value
                    ? LoadingText(
                      padding: EdgeInsets.only(
                        top: MediaQuery.sizeOf(context).height / 3,
                      ),
                      text: "Chargement en cours...",
                    )
                    : postController.myAdds.isEmpty
                    ? Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.sizeOf(context).height / 3,
                      ),
                      child: Center(
                        child: SizedBox(
                          width: 200,
                          child: Text(
                            "Vous n'avez pas encore poster une annonce",
                            textAlign: TextAlign.center,

                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                        ),
                      ),
                    )
                    : Container(
                      margin: EdgeInsets.only(left: 12, right: 12),
                      width: MediaQuery.sizeOf(Get.context!).width,
                      child: ListView.separated(
                        separatorBuilder:
                            (context, index) => SizedBox(height: 10.h),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: postController.filteredAdds.length,
                        itemBuilder: (context, index) {
                          Post post = postController.filteredAdds[index];
                          print("%%%%%%%%%%%%%%%%%%%%%=====");
                          print(formatShortDateNumber(post.date!.toIso8601String()));
                          return ProductCard(
                            id:post.id!,
                            imageUrl: post.mediaUrls!.first.content!,
                            title: post.title!,
                            price: post.price!.toString(),
                            status: post.status!.name,
                            date: formatShortDateNumber(post.date!.toString()),
                            view: post.views,
                          );
                        },
                      ),
                    );
              }),
            ]),
          ),
        ],
      ),
    );
  }
}
