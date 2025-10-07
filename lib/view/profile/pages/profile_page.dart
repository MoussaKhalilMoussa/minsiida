import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/common_widgets/custom_textfield.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/controllers/profile_controllers/profile/profile_controller.dart';
import 'package:simple_nav_bar/view/post/widget/continue_button.dart';
import 'package:simple_nav_bar/view/profile/model/user_profile.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    UserProfile? profile = profileController.userProfile.value;

    profileController.nameController.text = profile!.name!;
    profileController.emailController.text = profile.email!;
    profileController.userNameController.text = profile.username!;
    if (profile.phone == null) {
      profileController.phoneController.text = "";
    } else {
      profileController.phoneController.text = profile.phone!;
    }
    // profile.phone!;

    return Obx(() {
      return Stack(
        children: [
          Scaffold(
            //backgroundColor: Colors.grey[200],
            //appBar: AppBar(title: const Text('Profile'), centerTitle: true),
            body: CustomScrollView(
              //physics: const ClampingScrollPhysics(), // disables bounce
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  leading: IconButton(
                    icon: const Icon(Ionicons.chevron_back_outline),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  centerTitle: true,
                  title: Text(
                    'Profile',
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
                      padding: const EdgeInsets.all(12),
                      child: Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () async {
                                  await profileController.pickImage();
                                },
                                child: CircleAvatar(
                                  radius: 50, // 100/2
                                  backgroundColor: Colors.blue.withValues(
                                    alpha: 0.1,
                                  ),
                                  backgroundImage:
                                      profileController.pickedImage.value !=
                                              null
                                          ? FileImage(
                                            profileController
                                                .pickedImage
                                                .value!,
                                          )
                                          : (profile.profilePicture != null &&
                                              profile
                                                  .profilePicture!
                                                  .isNotEmpty)
                                          ? NetworkImage(
                                            profile.profilePicture!,
                                          )
                                          : null,
                                  child:
                                      (profileController.pickedImage.value ==
                                                  null &&
                                              (profile.profilePicture == null ||
                                                  profile
                                                      .profilePicture!
                                                      .isEmpty))
                                          ? Text(
                                            profile.name?.isNotEmpty == true
                                                ? profile.name![0].toUpperCase()
                                                : "?",
                                            style: GoogleFonts.poppins(
                                              color: blueColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.sp,
                                            ),
                                          )
                                          : null,
                                ),
                              ),
                              const SizedBox(width: 14),
                              Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.64,
                                margin: const EdgeInsets.only(top: 16),
                                //padding: const EdgeInsets.all(10),
                                child: TextFormField(
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: blackColor2,
                                  ),
                                  textAlign: TextAlign.start,
                                  controller: profileController.nameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withValues(
                                          alpha: 0.2,
                                        ),
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    //focusColor: primaryColor,
                                    enabled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: primaryColor,
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),

                                    //prefixIcon: const Icon(Icons.search),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            left: 64,
                            bottom: 2,
                            child: IconButton.filled(
                              padding: const EdgeInsets.all(2),
                              //iconSize: 20,
                              style: IconButton.styleFrom(
                                shape: const CircleBorder(),
                                backgroundColor: Colors.white,
                                //iconSize: 16
                                maximumSize: const Size(40, 40),
                              ),
                              icon: const Icon(
                                Ionicons.camera_outline,
                                color: blueColor,
                              ),
                              onPressed: () async {
                                await profileController.takePhoto();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey.withValues(alpha: 0.2),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        height: 100,
                        width: MediaQuery.of(context).size.width * 0.64,
                        margin: const EdgeInsets.only(top: 16),
                        //padding: const EdgeInsets.all(10),
                        child: TextFormField(
                          maxLines: 3,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: blackColor2,
                          ),
                          //expands: true,
                          textAlign: TextAlign.start,
                          controller: TextEditingController(
                            text:
                                "Je vends des produits de haute qualité à des prix abordables. La satisfaction du client est ma priorité absolue.",
                          ),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.withValues(alpha: 0.2),
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: primaryColor),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          enabled: true,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width * 0.64,
                        margin: const EdgeInsets.only(top: 16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.2),
                          ),
                          color: Colors.grey.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: 30,
                                  height: 30,
                                  //padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey.withValues(alpha: 0.2),
                                    ),
                                    color: Colors.grey.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Icon(
                                    Ionicons.help_circle,
                                    color: blackColor2,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: blackColor2,
                                  ),
                                  "Pourquoi est-ce important ?",
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              textAlign: TextAlign.justify,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: greyColor,
                              ),
                              "La confiance est essentielle. Aidez les autres à vous connaître. Pourquoi ne pas parler un peu de vous ? Partagez vos marques préférées, livres, films, séries, musiques, plats favoris. Et voyez ce qui se passe...",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                SliverToBoxAdapter(
                  child: Divider(
                    height: 30,
                    thickness: 1,
                    color: Colors.grey.withValues(alpha: 0.2),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: blackColor2,
                      ),
                      "Coordonnées",
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          customeTextFiled1(
                            labelText: "Username",
                            controller: profileController.userNameController,
                          ),
                          const SizedBox(height: 12),
                          customeTextFiled1(
                            labelText: "Numéro de téléphone",
                            hintText:
                                "veuillez entrer votre numéro de téléphone ",
                            controller: profileController.phoneController,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Ce numéro est utilisé pour les contacts, les rappels et autres notifications.",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: greyColor,
                            ),
                          ),

                          const SizedBox(height: 16),
                          customeTextFiled1(
                            labelText: "Adresse e-mail",
                            controller: profileController.emailController,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Nous ne partagerons jamais votre adresse e-mail avec personne.",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: greyColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /* 
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: blackColor2,
                        ),
                        "Mot de passe",
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Mot de passe actuel",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: greyColor,
                              ),
                            ),
            
                            SizedBox(height: 8),
                            TextFormField(
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: blackColor2,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.withValues(alpha: 0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabled: true,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Nouveau mot de passe",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: greyColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: blackColor2,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.withValues(alpha: 0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabled: true,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "Confirmer le mot de passe",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: greyColor,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: blackColor2,
                              ),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.withValues(alpha: 0.2),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: primaryColor),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabled: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                 */
              ],
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                onPressed: () async {
                  await profileController.updateProfile();
                },
                color: blueColor,
                width: MediaQuery.sizeOf(Get.context!).width,
                height: 60,
                borderRadius: 30,
                child: Text(
                  "Enregistrer les modifications",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          // overlay loader
          if (profileController.isLoading.value)
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withValues(alpha: 0.4), // backdrop
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                  strokeWidth: 3,
                ),
              ),
            ),
        ],
      );
    });
  }
}
