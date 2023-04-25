// LOGINPAGE ACTIVITY

import 'dart:io';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyphen/projectpage.dart';
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

class ApplicationCloseButton extends StatelessWidget {
  const ApplicationCloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: FloatingActionButton.small(
        onPressed: () {
          exit(0);
        },
        backgroundColor: Colors.pink,
        child: const Icon(
          Icons.close_sharp,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ApplicationBackButton extends StatelessWidget {
  const ApplicationBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 10),
      child: FloatingActionButton.small(
        onPressed: () {
          Navigator.pop(context);
        },
        backgroundColor: Colors.cyanAccent,
        child: const Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    windowManager.setFullScreen(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: const ApplicationCloseButton(),
        backgroundColor: const Color(0xFF313131),
        body: ListView(
          children: [
            Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  child: const RobotAnimation(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  child: const LoginPageForm(),
                )
              ],
            )
          ],
        ));
  }
}

class RobotAnimation extends StatelessWidget {
  const RobotAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 180),
            child: Lottie.network(
                "https://assets3.lottiefiles.com/packages/lf20_SI8fvW.json",
                fit: BoxFit.cover))
      ],
    );
  }
}

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({Key? key}) : super(key: key);

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var userName = TextEditingController();
    var passWord = TextEditingController();
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 100),
            decoration: BoxDecoration(
              color: Colors.cyanAccent,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Text("HYPHEN",
                style: GoogleFonts.orbitron(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.bold))),
        Container(
            margin: const EdgeInsets.only(top: 30),
            child: Text("stay connected with APIs",
                style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold))),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white, width: 2)),
          margin:
              const EdgeInsets.only(top: 85, bottom: 0, left: 150, right: 150),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextFormField(
              controller: userName,
              cursorColor: Colors.lime,
              style: GoogleFonts.orbitron(
                  color: Colors.lime,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  hintText: "UserName",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.white)),
                  hintStyle: GoogleFonts.orbitron(
                      color: Colors.lime,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white, width: 2)),
          margin:
              const EdgeInsets.only(top: 20, bottom: 3, left: 150, right: 150),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextFormField(
              obscureText: true,
              obscuringCharacter: '#',
              cursorColor: Colors.lime,
              controller: passWord,
              style: GoogleFonts.orbitron(
                  color: Colors.lime,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.white)),
                  hintStyle: GoogleFonts.orbitron(
                      color: Colors.lime,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                  top: 50, right: 20, left: 20, bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    var collection = Firestore.instance.collection("user");
                    bool isSignedUp = false;
                    int docIndex = 0;
                    final stream = await collection.get();
                    List<Document> list = stream.toList();
                    for (int i = 0; i < list.length; i++) {
                      if (list[i]['name'].toString() ==
                          userName.text.toString()) {
                        isSignedUp = true;
                        docIndex = i;
                      }
                    }
                    if (isSignedUp == true) {
                      if (list[docIndex]['password'].toString() ==
                          passWord.text.toString()) {
                        collection.get().then((value) async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setString(
                              "user", userName.text.toString());
                          await projectList();
                          sharedPreferences.setBool("dm5", true).then((value) =>
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ProjectPage())));
                        });
                      } else {
                        collection.get().then((value) => MotionToast.error(
                                title: const Text("Error"),
                                description:
                                    const Text("Password is not Matched"))
                            .show(context));
                        setState(() {
                          isLoading = false;
                        });
                      }
                    } else if (userName.text.toString().isEmpty ||
                        passWord.text.toString().isEmpty) {
                      collection.get().then((value) => MotionToast.error(
                              title: const Text("Error"),
                              description: const Text("Fields are empty"))
                          .show(context));
                      setState(() {
                        isLoading = false;
                      });
                    } else {
                      collection.get().then((value) => MotionToast.error(
                              title: const Text("Error"),
                              description: const Text("No User found"))
                          .show(context));
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  style: ButtonStyle(
                      overlayColor: const MaterialStatePropertyAll(Colors.pink),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.cyanAccent),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27)))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: (isLoading == true)
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : Text("LogIn",
                            style: GoogleFonts.orbitron(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 50, right: 20, left: 20, bottom: 20),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  },
                  style: ButtonStyle(
                      overlayColor: const MaterialStatePropertyAll(Colors.pink),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.cyanAccent),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27)))),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text("SignUp",
                        style: GoogleFonts.orbitron(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ],
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ForgotPassword()));
          },
          style: ButtonStyle(
              overlayColor: const MaterialStatePropertyAll(Colors.pink),
              backgroundColor:
                  MaterialStatePropertyAll(Colors.white.withOpacity(0.3)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(27)))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("forgot password ?",
                style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(top: 50),
            child: Text("developers.roundrobin",
                style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold))),
      ],
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [ApplicationBackButton(), ApplicationCloseButton()],
        ),
        backgroundColor: const Color(0xFF313131),
        body: ListView(
          children: [
            Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  child: const RobotAnimation(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  child: const SignUpPageForm(),
                )
              ],
            )
          ],
        ));
  }
}

class SignUpPageForm extends StatefulWidget {
  const SignUpPageForm({Key? key}) : super(key: key);

  @override
  State<SignUpPageForm> createState() => _SignUpPageFormState();
}

class _SignUpPageFormState extends State<SignUpPageForm> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var userName = TextEditingController();
    var passWord = TextEditingController();
    var passWord2 = TextEditingController();
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.only(top: 100),
            decoration: BoxDecoration(
              color: Colors.cyanAccent,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Text("HYPHEN",
                style: GoogleFonts.orbitron(
                    color: Colors.black,
                    fontSize: 50,
                    fontWeight: FontWeight.bold))),
        Container(
            margin: const EdgeInsets.only(top: 30),
            child: Text("Register Yourself",
                style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold))),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white, width: 2)),
          margin:
              const EdgeInsets.only(top: 65, bottom: 0, left: 150, right: 150),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextFormField(
              controller: userName,
              cursorColor: Colors.lime,
              style: GoogleFonts.orbitron(
                  color: Colors.lime,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  hintText: "Create UserName",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.white)),
                  hintStyle: GoogleFonts.orbitron(
                      color: Colors.lime,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white, width: 2)),
          margin:
              const EdgeInsets.only(top: 20, bottom: 3, left: 150, right: 150),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextFormField(
              obscureText: true,
              obscuringCharacter: '#',
              cursorColor: Colors.lime,
              controller: passWord,
              style: GoogleFonts.orbitron(
                  color: Colors.lime,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Create Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.white)),
                  hintStyle: GoogleFonts.orbitron(
                      color: Colors.lime,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white, width: 2)),
          margin:
              const EdgeInsets.only(top: 20, bottom: 3, left: 150, right: 150),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextFormField(
              obscureText: true,
              obscuringCharacter: '#',
              cursorColor: Colors.lime,
              controller: passWord2,
              style: GoogleFonts.orbitron(
                  color: Colors.lime,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Create Security Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.white)),
                  hintStyle: GoogleFonts.orbitron(
                      color: Colors.lime,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(top: 30, right: 20, left: 20, bottom: 20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                var collection = Firestore.instance.collection("user");
                final stream = await collection.get();
                List<Document> list = stream.toList();
                bool newUser = true;
                if (userName.text.toString().isEmpty ||
                    passWord.text.toString().isEmpty ||
                    passWord2.text.toString().isEmpty) {
                  collection.get().then((value) => MotionToast.error(
                          title: const Text("Error"),
                          description: const Text("Fields are empty"))
                      .show(context));
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  for (int i = 0; i < list.length; i++) {
                    if (list[i]['name'].toString() ==
                            userName.text.toString() ||
                        list[i]['password2'].toString() ==
                            passWord2.text.toString()) {
                      collection.get().then((value) => MotionToast.error(
                              title: const Text("Error"),
                              description: const Text(
                                  "UserName is taken or Security password is taken"))
                          .show(context));
                      setState(() {
                        isLoading = false;
                      });
                      newUser = false;
                      break;
                    }
                  }
                  if (newUser) {
                    await collection.add({
                      'name': userName.text.toString(),
                      'password': passWord.text.toString(),
                      'password2': passWord2.text.toString()
                    }).then((value) async {
                      SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.setString(
                          "user", userName.text.toString());
                      sharedPreferences.setBool("dm5", true).then((value) =>
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ProjectPage())));
                    });
                  }
                }
              },
              style: ButtonStyle(
                  overlayColor: const MaterialStatePropertyAll(Colors.pink),
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.cyanAccent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27)))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: (isLoading == true)
                    ? const CircularProgressIndicator(
                        color: Colors.black,
                      )
                    : Text("Create Account",
                        style: GoogleFonts.orbitron(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
        Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(top: 30),
            child: Text("developers.roundrobin",
                style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold))),
      ],
    );
  }
}

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [ApplicationBackButton(), ApplicationCloseButton()],
        ),
        backgroundColor: const Color(0xFF313131),
        body: ListView(
          children: [
            Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  child: const RobotAnimation(),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width / 2,
                  child: const ForgotPasswordForm(),
                )
              ],
            )
          ],
        ));
  }
}

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var securityKey = TextEditingController();
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 130),
            child: Text("Forgot Password",
                style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 50,
                    fontWeight: FontWeight.bold))),
        Container(
            margin: const EdgeInsets.only(top: 70),
            child: Text("Enter Your Security Password",
                style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold))),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white, width: 2)),
          margin:
              const EdgeInsets.only(top: 105, bottom: 0, left: 150, right: 150),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextFormField(
              controller: securityKey,
              cursorColor: Colors.lime,
              obscureText: true,
              obscuringCharacter: '#',
              style: GoogleFonts.orbitron(
                  color: Colors.lime,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  hintText: "Security Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: const BorderSide(color: Colors.white)),
                  hintStyle: GoogleFonts.orbitron(
                      color: Colors.lime,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
          ),
        ),
        Container(
          margin:
              const EdgeInsets.only(top: 50, right: 20, left: 20, bottom: 20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                var collection = Firestore.instance.collection("user");
                bool isSignedUp = false;
                int docIndex = 0;
                final stream = await collection.get();
                List<Document> list = stream.toList();
                for (int i = 0; i < list.length; i++) {
                  if (list[i]['password2'].toString() ==
                      securityKey.text.toString()) {
                    isSignedUp = true;
                    docIndex = i;
                  }
                }
                if (isSignedUp == true) {
                  setState(() {
                    isLoading = false;
                  });
                  collection.get().then((value) => showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                              side: const BorderSide(
                                  color: Colors.pinkAccent, width: 2)),
                          title: Text(
                            "User Details",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.orbitron(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.cyanAccent),
                          ),
                          content: Container(
                            margin: const EdgeInsets.all(20),
                            child: Text(
                                "UserName : ${list[docIndex]['name'].toString()}\nPassword : ${list[docIndex]['password'].toString()}",
                                style: GoogleFonts.orbitron(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        );
                      }));
                } else if (securityKey.text.toString().isEmpty) {
                  collection.get().then((value) => MotionToast.error(
                          title: const Text("Error"),
                          description: const Text("Fields are empty"))
                      .show(context));
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  collection.get().then((value) => MotionToast.error(
                          title: const Text("Error"),
                          description: const Text("No User found"))
                      .show(context));
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              style: ButtonStyle(
                  overlayColor: const MaterialStatePropertyAll(Colors.pink),
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.cyanAccent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27)))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: (isLoading == true)
                    ? const CircularProgressIndicator(
                        color: Colors.black,
                      )
                    : Text("Get Details",
                        style: GoogleFonts.orbitron(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
        Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(top: 50),
            child: Text("developers.roundrobin",
                style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold))),
      ],
    );
  }
}
