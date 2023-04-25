// SPLASH SCREEN ACTIVITY

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyphen/loginpage.dart';
import 'package:hyphen/projectpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isLoggedIn = false;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    getLogInInfo();
    projectList();
    super.initState();
  }

  getLogInInfo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.containsKey("dm5")) {
      setState(() {
        isLoggedIn = sharedPreferences.getBool("dm5")!;
      });
    } else {
      setState(() {
        isLoggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF313131),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/ee.png"), fit: BoxFit.cover)),
        child: Container(
          color: Colors.transparent,
          child: Center(
            child: DefaultTextStyle(
              style: const TextStyle(
                  fontSize: 42.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 370),
                      child: AnimatedTextKit(
                        animatedTexts: [
                          FadeAnimatedText(' developers.roundrobin',
                              textStyle: GoogleFonts.orbitron(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                        totalRepeatCount: 2,
                        onFinished: () {
                          if (isLoggedIn) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ProjectPage()));
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          }
                        },
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
