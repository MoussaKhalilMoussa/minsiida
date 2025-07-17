import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/view/post/widget/continue_button.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(), // disables bounce
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
              style: GoogleFonts.playfairDisplay(fontWeight: FontWeight.bold),
            ),
            floating: true,
            snap: true,
          ),
          SliverToBoxAdapter(
            child: Divider(
              thickness: 1,
              color: Colors.grey.withValues(alpha: 0.2),
            ),
          ),

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
                        Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.withValues(alpha: 0.1),
                            border: Border.all(color: Colors.blue, width: 2),
                          ),
                          /* child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                              'https://cdn.pixabay.com/photo/2023/06/29/01/09/portrait-8095464_1280.jpg',
                            ),
                          ), */
                          child: Text(
                            'N',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 24,
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.64,
                          margin: const EdgeInsets.only(top: 16),
                          //padding: const EdgeInsets.all(10),
                          child: TextField(
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: blackColor2,
                            ),
                            textAlign: TextAlign.start,
                            controller: TextEditingController(text: "Nour"),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.withValues(alpha: 0.2),
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
                          backgroundColor: Colors.blue,
                          //iconSize: 16
                          maximumSize: const Size(40, 40),
                        ),
                        icon: const Icon(Ionicons.camera),
                        onPressed: () {
                          // Handle camera action
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
                  child: TextField(
                    maxLines: 3,
                    style: GoogleFonts.playfairDisplay(
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
                    ),
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
                            style: GoogleFonts.playfairDisplay(
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
                        style: GoogleFonts.playfairDisplay(
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
                style: GoogleFonts.playfairDisplay(
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
                    Text(
                      "Numero de téléphone",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: greyColor,
                      ),
                    ),

                    SizedBox(height: 8),
                    TextFormField(
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: blackColor2,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Téléphone',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withValues(alpha: 0.2),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),
                    Text(
                      "Ce numéro est utilisé pour les contacts, les rappels et autres notifications.",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: greyColor,
                      ),
                    ),

                    const SizedBox(height: 16),
                    Text(
                      "Adresse e-mail",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: greyColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: blackColor2,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withValues(alpha: 0.2),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Nous ne partagerons jamais votre adresse e-mail avec personne.",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: greyColor,
                      ),
                    ),

                    const SizedBox(height: 16),
                    Text(
                      "Localisation",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: greyColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: blackColor2,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Los Angeles, West America',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey.withValues(alpha: 0.2),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                style: GoogleFonts.playfairDisplay(
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
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: greyColor,
                      ),
                    ),

                    SizedBox(height: 8),
                    TextFormField(
                      style: GoogleFonts.playfairDisplay(
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
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Nouveau mot de passe",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: greyColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: GoogleFonts.playfairDisplay(
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
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Confirmer le mot de passe",
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: greyColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      style: GoogleFonts.playfairDisplay(
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(
          onPressed: () {
            print("button pressed");
          },
          color: blueColor,
          width: MediaQuery.sizeOf(Get.context!).width,
          height: 60,
          borderRadius: 30,
          child: Text(
            "Enregistrer les modifications",
            style: GoogleFonts.playfairDisplay(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
