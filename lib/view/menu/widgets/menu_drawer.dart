import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_nav_bar/constants/colors.dart';
import 'package:simple_nav_bar/view/menu/widgets/sub_title.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget menuDrawer({
  required BuildContext context,
  required VoidCallback? closeDrawer,
  required Animation<Offset> offsetAnimation,
}) {
  return SlideTransition(
    position: offsetAnimation,
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Menu",
            style: GoogleFonts.playfairDisplay(
              fontWeight: FontWeight.bold,
              color: blackColor2,
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.close, color: blackColor2),
              onPressed: closeDrawer,
            ),
          ],
        ),
        body:SafeArea (
          bottom: true,
          child: Column(
            children: [
              Divider(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  subTitle(
                    leading: Icon(Icons.add, color: blackColor2),
                    title: "Publier une annonce",
                  ),
                  subTitle(title: "Parcourir les categories"),
                  subTitle(title: "Mes annonces"),
                  subTitle(title: "Annonces sauvegardees"),
                  subTitle(title: "Contactez-nous"),
                  subTitle(title: "FAQ"),
                ],
              ),
              Spacer(),
              //SizedBox(height: MediaQuery.of(context).size.height * 0.27),
              Divider(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 210, 234, 253),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Icon(FontAwesomeIcons.facebook, color: blackColor2),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 245, 223, 222),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Icon(FontAwesomeIcons.instagram, color: blackColor2),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 223, 223, 223),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Icon(FontAwesomeIcons.xTwitter, color: blackColor2),
                        ],
                      ),
                      const SizedBox(width: 30),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 226, 211, 250),
                              shape: BoxShape.circle,
                            ),
                          ),
                          Icon(FontAwesomeIcons.linkedin, color: blackColor2),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "© ${DateTime.now().year} Announces. Tous droits réservés",
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 13,
                      color: blackColor2,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Politique de\nconfidentialité",
                        softWrap: true,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 13,
                          color: blackColor2,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: VerticalDivider(
                          color: blackColor2,
                          thickness: 1.5,
                        ),
                      ),
                      Text(
                        " Conditions\nd'utilisation",
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 13,
                          color: blackColor2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}



