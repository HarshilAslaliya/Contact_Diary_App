import 'package:contact_app/screens/add_new_contact.dart';
import 'package:contact_app/screens/details_page.dart';
import 'package:contact_app/screens/edit_page.dart';
import 'package:contact_app/screens/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/globals.dart';

void main() {
  runApp(const ContactApp());
}

class ContactApp extends StatefulWidget {
  const ContactApp({Key? key}) : super(key: key);

  @override
  State<ContactApp> createState() => _ContactAppState();
}

class _ContactAppState extends State<ContactApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // theme: Globals.themeMode
      //     ? ThemeData.dark()
      //     : ThemeData(
      //         appBarTheme: const AppBarTheme(
      //             color: Colors.white,
      //             titleTextStyle: TextStyle(color: Colors.black)),
      //       ),
      routes: {
        '/': (context) => const Splash(),
        'home': (context) => const HomePage(),
        'homepage': (context) => const ContactApp(),
        'addcontact': (context) => const AddContact(),
        'detail_page': (context) => const DetailsPage(),
        'editpage': (context) => const EditPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  makecall({required phonenumber}) async {
    final Uri call = Uri(
      scheme: 'tel',
      path: '+91 $phonenumber',
    );
    await launchUrl(call);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Globals.themeMode ? const Color(0xff181818) : Colors.white,
      appBar: AppBar(
        backgroundColor:
            Globals.themeMode ? const Color(0xff212121) : Colors.white,
        title: Text(
          "Contacts",
          style: GoogleFonts.nerkoOne(
            letterSpacing: 1.5,
            textStyle: TextStyle(
              color: Globals.themeMode ? Colors.white : Colors.black,
              fontSize: 40,
            ),
          ),
        ),
        actions: [
          SizedBox(
            width: 70,
            child: Transform.scale(
              scale: 1.15,
              child: DayNightSwitcher(
                isDarkModeEnabled: Globals.themeMode,
                onStateChanged: (val) {
                  setState(() {
                    Globals.themeMode = val;
                  });
                },
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_outlined,
                size: 35,
                color: Colors.grey,
              )),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
      body: (Globals.allcontacts.isEmpty)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: const AssetImage("asset/images/openbox.png"),
                    height: 180,
                    width: 180,
                    color: Globals.themeMode ? Colors.white : Colors.black,
                  ),
                  Text(
                    "You have no contacts yet",
                    style: TextStyle(fontSize: 22, color: Colors.grey.shade600),
                  ),
                ],
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: Globals.allcontacts.length,
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: () {
                    makecall(phonenumber: Globals.allcontacts[i].phonenumber);
                  },
                  leading: CircleAvatar(
                    backgroundImage: (Globals.allcontacts[i].image != null)
                        ? FileImage(Globals.allcontacts[i].image as File)
                        : const AssetImage('asset/images/profile.png')
                            as ImageProvider,
                  ),
                  title: Text(
                    "${Globals.allcontacts[i].firstname} ${Globals.allcontacts[i].lastname}",
                    style: TextStyle(
                        color: Globals.themeMode ? Colors.white : Colors.black),
                  ),
                  subtitle: Text(
                    "+91 ${Globals.allcontacts[i].phonenumber} ",
                    style: TextStyle(
                        color: Globals.themeMode ? Colors.white : Colors.black),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('detail_page',
                          arguments: Globals.allcontacts[i]);
                    },
                    icon: const Icon(
                      CupertinoIcons.info,
                      size: 32,
                    ),
                    color: Globals.themeMode
                        ? Colors.teal.shade300
                        : Colors.lightBlue,
                  ),
                );
              },
            ),
      floatingActionButton: SizedBox(
        height: 80,
        width: 80,
        child: FittedBox(
          child: FloatingActionButton(
              backgroundColor:
                  Globals.themeMode ? Colors.teal.shade300 : Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, 'addcontact');
              },
              child: const Icon(
                Icons.add,
                size: 27,
              )),
        ),
      ),
    );
  }
}
