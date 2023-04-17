// ProjectPage Activity

import 'package:firedart/firestore/firestore.dart';
import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyphen/console.dart';
import 'package:hyphen/loginpage.dart';
import 'package:hyphen/random.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:window_manager/window_manager.dart';

class ProjectPage extends StatefulWidget {
  const ProjectPage({Key? key}) : super(key: key);

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
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
                  child: const ProjectOpenForm(),
                )
              ],
            )
          ],
        ));
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

class ProjectOpenForm extends StatefulWidget {
  const ProjectOpenForm({Key? key}) : super(key: key);

  @override
  State<ProjectOpenForm> createState() => _ProjectOpenFormState();
}

class _ProjectOpenFormState extends State<ProjectOpenForm> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var projectName = TextEditingController();
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 100),
            child: Text("Welcome in HYPHEN project",
                style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold))),
        Container(
            margin: const EdgeInsets.only(top: 30),
            child: Text("Open project",
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
              const EdgeInsets.only(top: 105, bottom: 0, left: 150, right: 150),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextFormField(
              controller: projectName,
              cursorColor: Colors.lime,
              style: GoogleFonts.orbitron(
                  color: Colors.lime,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  hintText: "ProjectName",
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
          margin: const EdgeInsets.only(top: 50, right: 20, left: 20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                var collection = Firestore.instance.collection(
                    "${sharedPreferences.getString("user")}project");
                bool isSignedUp = false;
                int docIndex = 0;
                final stream = await collection.get();
                List<Document> list = stream.toList();
                for (int i = 0; i < list.length; i++) {
                  if (list[i]['projectName'].toString() ==
                      projectName.text.toString()) {
                    isSignedUp = true;
                    projectNameCurrunt = list[i]['projectName'].toString();
                    passwordCurrunt = list[i]['password'].toString();
                    docIndex = i;
                  }
                }
                if (isSignedUp == true) {
                  if (list[docIndex]['projectName'].toString() ==
                      projectName.text.toString()) {
                    collection.get().then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Console())));
                  } else {
                    collection.get().then((value) => MotionToast.error(
                            title: const Text("Error"),
                            description: const Text("Password is not Matched"))
                        .show(context));
                    setState(() {
                      isLoading = false;
                    });
                  }
                } else if (projectName.text.toString().isEmpty) {
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
                          description: const Text("No Project found"))
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
                    : Text("Open Project",
                        style: GoogleFonts.orbitron(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProjectCreatePage()));
              },
              style: ButtonStyle(
                  overlayColor: const MaterialStatePropertyAll(Colors.pink),
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.cyanAccent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27)))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("New Project",
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

class ProjectCreatePage extends StatelessWidget {
  const ProjectCreatePage({Key? key}) : super(key: key);

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
                  child: const ProjectCreatePageForm(),
                )
              ],
            )
          ],
        ));
  }
}

class ProjectCreatePageForm extends StatefulWidget {
  const ProjectCreatePageForm({Key? key}) : super(key: key);

  @override
  State<ProjectCreatePageForm> createState() => _ProjectCreatePageFormState();
}

class _ProjectCreatePageFormState extends State<ProjectCreatePageForm> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var projectName = TextEditingController();
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 100),
            child: Text("Welcome in HYPHEN project",
                style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold))),
        Container(
            margin: const EdgeInsets.only(top: 30),
            child: Text("Create project",
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
              const EdgeInsets.only(top: 105, bottom: 0, left: 150, right: 150),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: TextFormField(
              controller: projectName,
              cursorColor: Colors.lime,
              style: GoogleFonts.orbitron(
                  color: Colors.lime,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                  hintText: "Create ProjectName",
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
          margin: const EdgeInsets.only(top: 50, right: 20, left: 20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () async {
                SharedPreferences sharedPreferences =
                    await SharedPreferences.getInstance();
                setState(() {
                  isLoading = true;
                });
                var collection = Firestore.instance.collection(
                    "${sharedPreferences.getString("user")}project");
                final stream = await collection.get();
                List<Document> list = stream.toList();
                bool newUser = true;
                if (projectName.text.toString().isEmpty) {
                  collection.get().then((value) => MotionToast.error(
                          title: const Text("Error"),
                          description: const Text("Fields are empty"))
                      .show(context));
                  setState(() {
                    isLoading = false;
                  });
                } else {
                  for (int i = 0; i < list.length; i++) {
                    if (list[i]['projectName'].toString() ==
                        projectName.text.toString()) {
                      collection.get().then((value) => MotionToast.error(
                              title: const Text("Error"),
                              description:
                                  const Text("project is already created"))
                          .show(context));
                      setState(() {
                        isLoading = false;
                      });
                      newUser = false;
                      break;
                    }
                  }
                  if (newUser) {
                    String pass = passWord();
                    await collection.add({
                      'projectName': projectName.text.toString(),
                      'password': pass
                    }).then((value) {
                      projectNameCurrunt = projectName.text.toString();
                      passwordCurrunt = pass;
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Console()));
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
                    : Text("Create Project",
                        style: GoogleFonts.orbitron(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 20, left: 20, bottom: 20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProjectPage()));
              },
              style: ButtonStyle(
                  overlayColor: const MaterialStatePropertyAll(Colors.pink),
                  backgroundColor:
                      const MaterialStatePropertyAll(Colors.cyanAccent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27)))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("Open Exiting Project",
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
