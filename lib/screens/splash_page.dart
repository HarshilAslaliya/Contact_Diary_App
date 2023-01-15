import 'dart:async';

import 'package:contact_app/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _splashScreen();
  }

  _splashScreen() async {
    await Future.delayed(const Duration(seconds: 5));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      // Color(0xff06beb6),
                      // Color(0xff48b1bf),
                      Colors.black54,
                      Colors.black,
                    ]),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('asset/images/contact.png'),
                  height: 150,
                  width: 150,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "CONTACT DIARY APP",
                  style: GoogleFonts.ibmPlexSans(
                    letterSpacing: 6,
                    textStyle:
                        const TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 190,
                ),
                const CircularProgressIndicator(strokeWidth: 2.5),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Made by Harshil Aslaliya",
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
