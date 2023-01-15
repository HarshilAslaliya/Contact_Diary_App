import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/globals.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    dynamic h1 = ModalRoute.of(context)!.settings.arguments;
    makecall() async {
      final Uri call = Uri(
        scheme: 'tel',
        path: '+91${h1.phonenumber}',
      );
      await launchUrl(call);
    }

    directcall() async {
      String number = '+91${h1.phonenumber}';
      bool? res = await FlutterPhoneDirectCaller.callNumber(number);
    }

    makesms() async {
      final Uri sms = Uri(
        scheme: 'sms',
        path: '+91${h1.phonenumber}',
      );
      await launchUrl(sms);
    }

    makeEmail() async {
      final Uri email = Uri(
        scheme: 'mailto',
        path: '${h1.email}',
      );
      await launchUrl(email);
    }

    return Scaffold(
      backgroundColor:
          Globals.themeMode ? const Color(0xff181818) : Colors.white,
      appBar: AppBar(
        backgroundColor:
            Globals.themeMode ? const Color(0xff212121) : Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              CupertinoIcons.back,
              size: 30,
              color: (Globals.themeMode) ? Colors.white : Colors.black,
            )),
        title: Text("Contacts",
            style: GoogleFonts.nerkoOne(
              letterSpacing: 1.5,
              textStyle: TextStyle(
                color: Globals.themeMode ? Colors.white : Colors.black,
                fontSize: 40,
              ),
            )),
        actions: const [
          // Container(
          //   width: 80,
          //   child: Transform.scale(
          //     scale: 1.15,
          //     child: DayNightSwitcher(
          //       isDarkModeEnabled: Globals.themeMode,
          //       onStateChanged: (val) {
          //         setState(() {
          //           Globals.themeMode = val;
          //         });
          //       },
          //     ),
          //   ),
          // ),
          SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 50,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          CircleAvatar(
            backgroundImage: (h1.image != null)
                ? FileImage(h1.image!)
                : const AssetImage('asset/images/profile.png') as ImageProvider,
            backgroundColor: Colors.grey,
            radius: 55,
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      return AlertDialog(
                        title: const Text("Are you sure for delete contact..."),
                        actions: <Widget>[
                          TextButton(
                            child: const Text("No"),
                            onPressed: () {
                              Navigator.of(dialogContext)
                                  .pop(); // Dismiss alert dialog
                            },
                          ),
                          TextButton(
                            child: const Text("Yes"),
                            onPressed: () {
                              Globals.allcontacts.remove(h1);

                              Navigator.pushNamedAndRemoveUntil(
                                  context, 'home', (route) => false);
                            },
                          ),
                        ],
                      );
                    },
                  );
                  Globals.allcontacts.remove(h1);

                  // ignore: use_build_context_synchronously
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('home', (route) => false);
                },
                child: const Text(
                  "Delete Contact",
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('editpage', arguments: h1);
                },
                child: const Text(
                  "Edit Contact",
                  style: TextStyle(color: Colors.blue, fontSize: 18),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              "${h1.firstname} ${h1.lastname}",
              style: TextStyle(
                  color: Globals.themeMode ? Colors.white : Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "+91 ${h1.phonenumber} ",
            style: TextStyle(
                color: Globals.themeMode ? Colors.white : Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 20,
          ),
          Divider(
            thickness: 1,
            color: Globals.themeMode ? Colors.white : Colors.black,
            indent: 20,
            endIndent: 20,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                onPressed: () {
                  makecall();
                  // directcall();
                },
                mini: true,
                backgroundColor: Colors.green,
                child: const Icon(Icons.call),
              ),
              FloatingActionButton(
                onPressed: () {
                  makesms();
                },
                mini: true,
                backgroundColor: Colors.amberAccent,
                child: const Icon(Icons.message),
              ),
              FloatingActionButton(
                onPressed: () {
                  makeEmail();
                },
                mini: true,
                backgroundColor: Colors.lightBlue,
                child: const Icon(Icons.email_outlined),
              ),
              FloatingActionButton(
                onPressed: () async {
                  await Share.share(
                      "Name:${h1.firstname} ${h1.lastname}\n+91 ${h1.phonenumber}");
                },
                mini: true,
                backgroundColor: Colors.deepOrangeAccent,
                child: const Icon(Icons.share),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Divider(
            thickness: 1,
            color: Globals.themeMode ? Colors.white : Colors.black,
            indent: 20,
            endIndent: 20,
          ),
          const Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }
}
