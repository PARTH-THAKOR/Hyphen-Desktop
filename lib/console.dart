// CONSOLE ACTIVITY

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyphen/jsonmodel.dart';
import 'package:hyphen/loginpage.dart';
import 'package:hyphen/projectpage.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:motion_toast/motion_toast.dart';

String buttonmode = "get";
String projectNameCurrunt = "";
String passwordCurrunt = "";

class Console extends StatelessWidget {
  const Console({Key? key}) : super(key: key);

  buttonModePage() {
    if (buttonmode == "get") {
      return const ConsoleApiUrlPageGet();
    } else if (buttonmode == "post") {
      return const ConsoleApiUrlPagePost();
    } else if (buttonmode == "json") {
      return const ConsoleDataApiPage();
    } else {
      return const ConsoleApiUrlPageDelete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF313131),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [ConsoleBackButton(), ApplicationCloseButton()],
      ),
      body: ListView(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.27,
                height: MediaQuery.of(context).size.height,
                child: const ConsoleInfoSection(),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.73,
                height: MediaQuery.of(context).size.height,
                color: const Color(0xFF414141),
                child: buttonModePage(),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ConsoleInfoSection extends StatelessWidget {
  const ConsoleInfoSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.27,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: CircleAvatar(
                  backgroundColor: Colors.pink,
                  radius: 70.0,
                  child: Text(
                    projectNameCurrunt,
                    style: GoogleFonts.orbitron(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.cyanAccent),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onLongPress: () {
                          Clipboard.setData(
                                  ClipboardData(text: projectNameCurrunt))
                              .then((value) => MotionToast.success(
                                      title: const Text("Success"),
                                      description: const Text(
                                          "ProjectName copied on clipboard"))
                                  .show(context));
                        },
                        child: Text(
                          "ProjectName: $projectNameCurrunt",
                          style: GoogleFonts.orbitron(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onLongPress: () {
                          Clipboard.setData(
                                  ClipboardData(text: passwordCurrunt))
                              .then((value) => MotionToast.success(
                                      title: const Text("Success"),
                                      description: const Text(
                                          "Password copied on clipboard"))
                                  .show(context));
                        },
                        child: Text(
                          "Password🔒: $passwordCurrunt",
                          style: GoogleFonts.orbitron(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.27,
          height: MediaQuery.of(context).size.height * 0.55,
          child: const ConsoleApiTypeButtons(),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.27,
          height: MediaQuery.of(context).size.height * 0.05,
          child: Text(
            "developers.roundrobin",
            textAlign: TextAlign.center,
            style: GoogleFonts.orbitron(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class ConsoleBackButton extends StatelessWidget {
  const ConsoleBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 10),
      child: FloatingActionButton.small(
        onPressed: () {
          buttonmode = "get";
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ProjectPage()));
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

class ConsoleApiTypeButtons extends StatelessWidget {
  const ConsoleApiTypeButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(30),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.cyanAccent),
              borderRadius: BorderRadius.circular(30.0)),
          child: ListTile(
            title: Text(
              "Select the type of Api",
              style: GoogleFonts.orbitron(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, right: 20, left: 20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                if (buttonmode == "get") {
                } else {
                  buttonmode = "get";
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Console()));
                }
              },
              style: ButtonStyle(
                  overlayColor: const MaterialStatePropertyAll(Colors.pink),
                  backgroundColor: MaterialStatePropertyAll(
                      (buttonmode == "get") ? Colors.pink : Colors.cyanAccent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27)))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("GetApis",
                    style: GoogleFonts.orbitron(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, right: 20, left: 20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                if (buttonmode == "post") {
                } else {
                  buttonmode = "post";
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Console()));
                }
              },
              style: ButtonStyle(
                  overlayColor: const MaterialStatePropertyAll(Colors.pink),
                  backgroundColor: MaterialStatePropertyAll(
                      (buttonmode == "post") ? Colors.pink : Colors.cyanAccent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27)))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("PostApis",
                    style: GoogleFonts.orbitron(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 10, right: 20, left: 20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {
                if (buttonmode == "delete") {
                } else {
                  buttonmode = "delete";
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Console()));
                }
              },
              style: ButtonStyle(
                  overlayColor: const MaterialStatePropertyAll(Colors.pink),
                  backgroundColor: MaterialStatePropertyAll(
                      (buttonmode == "delete")
                          ? Colors.pink
                          : Colors.cyanAccent),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27)))),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text("DeleteApis",
                    style: GoogleFonts.orbitron(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ConsoleApiUrlPageGet extends StatefulWidget {
  const ConsoleApiUrlPageGet({Key? key}) : super(key: key);

  @override
  State<ConsoleApiUrlPageGet> createState() => _ConsoleApiUrlPageGetState();
}

class _ConsoleApiUrlPageGetState extends State<ConsoleApiUrlPageGet>
    with TickerProviderStateMixin {
  late TabController tabController;
  var length = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    tabController.addListener(() {
      setState(() {
        length = tabController.index;
      });
    });
  }

  tabBar() {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      controller: tabController,
      indicatorColor: Colors.cyanAccent,
      tabs: [
        Tab(
            child: Text(
          "Ascending Order",
          style: GoogleFonts.orbitron(
              fontSize: 13,
              color: (length == 0) ? Colors.cyanAccent : Colors.white,
              fontWeight: FontWeight.bold),
        )),
        Tab(
            child: Text(
          "Descending Order",
          style: GoogleFonts.orbitron(
              fontSize: 13,
              color: (length == 1) ? Colors.cyanAccent : Colors.white,
              fontWeight: FontWeight.bold),
        )),
        Tab(
            child: Text(
          "Developer Get Api",
          style: GoogleFonts.orbitron(
              fontSize: 13,
              color: (length == 2) ? Colors.cyanAccent : Colors.white,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  tabBody(BuildContext context) {
    return TabBarView(controller: tabController, children: const [
      Scaffold(
        backgroundColor: Color(0xFF414141),
        body: ConsoleGetApiAscendingPage(),
      ),
      Scaffold(
        backgroundColor: Color(0xFF414141),
        body: ConsoleGetApiDescendingPage(),
      ),
      Scaffold(
        backgroundColor: Color(0xFF414141),
        body: ConsoleGetApiDeveloperPage(),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF414141),
        floatingActionButton: const ConsoleUserDataPageButton(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          bottom: tabBar(),
          actions: const [],
          title: Text(
            "GetApis for User",
            style: GoogleFonts.orbitron(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
          ),
        ),
        body: tabBody(context));
  }
}

class ConsoleApiUrlPagePost extends StatefulWidget {
  const ConsoleApiUrlPagePost({Key? key}) : super(key: key);

  @override
  State<ConsoleApiUrlPagePost> createState() => _ConsoleApiUrlPagePostState();
}

class _ConsoleApiUrlPagePostState extends State<ConsoleApiUrlPagePost>
    with TickerProviderStateMixin {
  late TabController tabController;
  var length = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    tabController.addListener(() {
      setState(() {
        length = tabController.index;
      });
    });
  }

  tabBar() {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      controller: tabController,
      indicatorColor: Colors.cyanAccent,
      tabs: [
        Tab(
            child: Text(
          "on Project",
          style: GoogleFonts.orbitron(
              fontSize: 13,
              color: (length == 0) ? Colors.cyanAccent : Colors.white,
              fontWeight: FontWeight.bold),
        )),
        Tab(
            child: Text(
          "Developer Post Api",
          style: GoogleFonts.orbitron(
              fontSize: 13,
              color: (length == 1) ? Colors.cyanAccent : Colors.white,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  tabBody(BuildContext context) {
    return TabBarView(controller: tabController, children: const [
      Scaffold(
        backgroundColor: Color(0xFF414141),
        body: ConsolePostApiOnProjectPage(),
      ),
      Scaffold(
        backgroundColor: Color(0xFF414141),
        body: ConsolePostApiDeveloperPage(),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF414141),
        floatingActionButton: const ConsoleUserDataPageButton(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          bottom: tabBar(),
          title: Text(
            "PostApis for User",
            style: GoogleFonts.orbitron(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
          ),
        ),
        body: tabBody(context));
  }
}

class ConsoleApiUrlPageDelete extends StatefulWidget {
  const ConsoleApiUrlPageDelete({Key? key}) : super(key: key);

  @override
  State<ConsoleApiUrlPageDelete> createState() =>
      _ConsoleApiUrlPageDeleteState();
}

class _ConsoleApiUrlPageDeleteState extends State<ConsoleApiUrlPageDelete>
    with TickerProviderStateMixin {
  late TabController tabController;
  var length = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(initialIndex: 0, length: 4, vsync: this);
    tabController.addListener(() {
      setState(() {
        length = tabController.index;
      });
    });
  }

  tabBar() {
    return TabBar(
      indicatorSize: TabBarIndicatorSize.tab,
      controller: tabController,
      indicatorColor: Colors.cyanAccent,
      tabs: [
        Tab(
            child: Text(
          "by DeleteId",
          style: GoogleFonts.orbitron(
              fontSize: 13,
              color: (length == 0) ? Colors.cyanAccent : Colors.white,
              fontWeight: FontWeight.bold),
        )),
        Tab(
            child: Text(
          "by ChatId",
          style: GoogleFonts.orbitron(
              fontSize: 13,
              color: (length == 1) ? Colors.cyanAccent : Colors.white,
              fontWeight: FontWeight.bold),
        )),
        Tab(
            child: Text(
          "by SendId",
          style: GoogleFonts.orbitron(
              fontSize: 13,
              color: (length == 2) ? Colors.cyanAccent : Colors.white,
              fontWeight: FontWeight.bold),
        )),
        Tab(
            child: Text(
          "Developer Delete Api",
          style: GoogleFonts.orbitron(
              fontSize: 13,
              color: (length == 3) ? Colors.cyanAccent : Colors.white,
              fontWeight: FontWeight.bold),
        )),
      ],
    );
  }

  tabBody(BuildContext context) {
    return TabBarView(controller: tabController, children: const [
      Scaffold(
        backgroundColor: Color(0xFF414141),
        body: ConsoleDeleteApiByDeleteIdPage(),
      ),
      Scaffold(
        backgroundColor: Color(0xFF414141),
        body: ConsoleDeleteApiByChatIdPage(),
      ),
      Scaffold(
        backgroundColor: Color(0xFF414141),
        body: ConsoleDeleteApiBySendIdPage(),
      ),
      Scaffold(
        backgroundColor: Color(0xFF414141),
        body: ConsoleDeleteApiDeveloperPage(),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF414141),
        floatingActionButton: const ConsoleUserDataPageButton(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          bottom: tabBar(),
          title: Text(
            "DeleteApis for User",
            style: GoogleFonts.orbitron(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
          ),
        ),
        body: tabBody(context));
  }
}

class ConsoleUserDataPageButton extends StatelessWidget {
  const ConsoleUserDataPageButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: (buttonmode == "json") ? Colors.pink : Colors.cyanAccent,
      onPressed: () {
        if (buttonmode == "json") {
          buttonmode = "get";
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Console()));
        } else {
          buttonmode = "json";
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Console()));
        }
      },
      child: Icon(
        Icons.code_off,
        color: (buttonmode == "json") ? Colors.white : Colors.black,
      ),
    );
  }
}

class RobotAnimation2 extends StatelessWidget {
  const RobotAnimation2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 50),
            child: Lottie.network(
                "https://assets3.lottiefiles.com/packages/lf20_SI8fvW.json",
                fit: BoxFit.cover))
      ],
    );
  }
}

class ConsoleDataApiPage extends StatefulWidget {
  const ConsoleDataApiPage({Key? key}) : super(key: key);

  @override
  State<ConsoleDataApiPage> createState() => _ConsoleDataApiPageState();
}

class _ConsoleDataApiPageState extends State<ConsoleDataApiPage> {
  List<Jsonmodel> userDataList = [];

  Future<List<Jsonmodel>> getUserData() async {
    final responce = await http.get(
        Uri.parse(
            "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/dev/$projectNameCurrunt"),
        headers: {
          'Content-Type': 'application/json',
          'Password': passwordCurrunt,
          'UserName': projectNameCurrunt,
          'Authorization':
              'Bearer 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'
        });
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (Map i in data) {
        if (!userDataList.contains(Jsonmodel.fromJson(i))) {
          userDataList.add(Jsonmodel.fromJson(i));
        }
      }
    }
    return userDataList;
  }

  deleteUserData() async {
    final responce = await http.delete(
        Uri.parse(
            "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/dev/$projectNameCurrunt"),
        headers: {
          'Content-Type': 'application/json',
          'Password': passwordCurrunt,
          'UserName': projectNameCurrunt,
          'Authorization':
              'Bearer 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'
        });
    if (responce.statusCode == 204) {
      setState(() {
        Navigator.pop(context);
        userDataList.clear();
        MotionToast.success(
                title: const Text("Success"),
                description: const Text("All data deleted"))
            .show(context);
      });
    } else {
      setState(() {
        Navigator.pop(context);
        MotionToast.error(
                title: const Text("Error"),
                description: const Text("Error occured"))
            .show(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF414141),
      floatingActionButton: const ConsoleUserDataPageButton(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Data of your project on our SERVER",
              style: GoogleFonts.orbitron(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10, right: 20, left: 20),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: const BorderSide(
                                        color: Colors.pinkAccent, width: 2)),
                                title: Text(
                                  "Delete all Data",
                                  style: GoogleFonts.orbitron(
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.cyanAccent),
                                ),
                                content: Text(
                                    "Do you want to delete all data ?",
                                    style: GoogleFonts.orbitron(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      deleteUserData();
                                    },
                                    style: ButtonStyle(
                                        overlayColor:
                                            const MaterialStatePropertyAll(
                                                Colors.pink),
                                        backgroundColor:
                                            const MaterialStatePropertyAll(
                                                Colors.cyanAccent),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        27)))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        "Delete",
                                        style: GoogleFonts.orbitron(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            });
                      },
                      style: ButtonStyle(
                          overlayColor:
                              const MaterialStatePropertyAll(Colors.pink),
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.cyanAccent),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(27)))),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("Delete all Data",
                            style: GoogleFonts.orbitron(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 70),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getUserData(),
                  builder: (context, AsyncSnapshot<List<Jsonmodel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.cyanAccent,
                      ));
                    } else if (snapshot.data!.isEmpty) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 40,
                              ),
                              Text(
                                "No Data",
                                style: GoogleFonts.orbitron(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                              const RobotAnimation2()
                            ],
                          ),
                        ],
                      );
                    } else {
                      return ListView.builder(
                          itemCount: userDataList.length,
                          itemBuilder: (context, index) {
                            return Text(
                              "{\n"
                              "\t\t\t'id' : ${snapshot.data![index].id.toString()}\n"
                              "\t\t\t'projectName': ${snapshot.data![index].projectName.toString()}\n"
                              "\t\t\tchatId : ${snapshot.data![index].chatId.toString()}\n"
                              "\t\t\tsendId : ${snapshot.data![index].sendId.toString()}\n"
                              "\t\t\tdeleteId : ${snapshot.data![index].deleteId.toString()}\n"
                              "\t\t\ttime : ${snapshot.data![index].time.toString()}\n"
                              "\t\t\tmessage : ${snapshot.data![index].message.toString()}\n"
                              '},\n',
                              style: const TextStyle(
                                  color: Colors.lightBlueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            );
                          });
                    }
                  }),
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}

class ConsoleGetApiAscendingPage extends StatelessWidget {
  const ConsoleGetApiAscendingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              "Url of GetApi in Ascending Order",
              style: GoogleFonts.orbitron(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30.0)),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text:
                                  "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/<chatId>/asc"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Link copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/<chatId>/asc",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 1:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "First you need to authenticate the API\n"
                        "So set header parameter of this API in your code like this",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text: "headers = {\n\n"
                                  "       'Content-Type': 'application/json',\n"
                                  "       'Password': '$passwordCurrunt',\n"
                                  "       'UserName': '$projectNameCurrunt',\n"
                                  "       'Authorization': 'Bearer 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'\n\n"
                                  "}"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Header copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "headers = {\n\n"
                      "       'Content-Type': 'application/json',\n"
                      "       'Password': '$passwordCurrunt',\n"
                      "       'UserName': '$projectNameCurrunt',\n"
                      "       'Authorization': 'Bearer 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'\n\n"
                      "}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 2:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Now make Get API request in your code,\n"
                        "This Url is used in chat between two people\n"
                        "Now you need to concatenate this API URL with ChatId\n"
                        "Like this...",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  Text(
                    "Suppose your ChatId is 87646463864365\n\n\n"
                    "So now your GetUrl is :\n"
                    "           https://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/87646463864365/asc",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 3:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Now you need to know the status code which is used in this API,\n"
                        "Use this Codes as API call verification",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "STATUS CODES\n\n\n"
                    "200 : RequestAccepted, Request is valid\n"
                    "401 : Unauthorized, Username or Password is not valid",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is ChatId ?",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "ChatId is common Id number between two people,\n"
                        "ChatId is the Unique Number which is used to Perform CRUD operations on messages of chatters,\n"
                        "Make chatId like this while perform PostApi call",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Person A's phoneNumber : 123456789\n"
                    "Person A have the phoneNumber of Person B in contacts: 987654321\n\n\n"
                    "Person B's phoneNumber : 987654321\n"
                    "Person B have the phoneNumber of Person A in contacts: 123456789\n\n\n"
                    "Now both have the numbers of each other\n\n\n"
                    "Now Id of A is : Sum(123456789 + 987654321)\n"
                    "Now Id of B is : Sum(987654321 + 123456789)\n\n"
                    "After this you get Id of(A) = Id of(B)\n\n\n"
                    "Now Find the digit sum of Id of(A) and Id of(B)\n"
                    "Now ChatId(A) = String(digit sum of Id of(A)) + String(Id of(A))\n"
                    "Now ChatId(B) = String(digit sum of Id of(B)) + String(Id of(B))\n\n"
                    "Now you get ChatId = ChatId(A) = ChatId(B)\n\n\n"
                    "Type of ChatId is String",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            )
          ],
        )
      ],
    );
  }
}

class ConsoleGetApiDescendingPage extends StatelessWidget {
  const ConsoleGetApiDescendingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              "Url of GetApi in Descending Order",
              style: GoogleFonts.orbitron(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30.0)),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text:
                                  "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/<chatId>/desc"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Link copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/<chatId>/desc",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 1:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "First you need to authenticate the API\n"
                        "So set header parameter of this API in your code like this",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text: "headers = {\n\n"
                                  "       'Content-Type': 'application/json',\n"
                                  "       'Password': '$passwordCurrunt',\n"
                                  "       'UserName': '$projectNameCurrunt',\n"
                                  "       'Authorization': 'Bearer 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'\n\n"
                                  "}"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Header copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "headers = {\n\n"
                      "       'Content-Type': 'application/json',\n"
                      "       'Password': '$passwordCurrunt',\n"
                      "       'UserName': '$projectNameCurrunt',\n"
                      "       'Authorization': 'Bearer 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'\n\n"
                      "}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 2:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Now make Get API request in your code,\n"
                        "This Url is used in chat between two people\n"
                        "Now you need to concatenate this API URL with ChatId\n"
                        "Like this...",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  Text(
                    "Suppose your ChatId is 87646463864365\n\n\n"
                    "So now your GetUrl is :\n"
                    "           https://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/87646463864365/desc",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 3:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Now you need to know the status code which is used in this API,\n"
                        "Use this Codes as API call verification",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "STATUS CODES\n\n\n"
                    "200 : RequestAccepted, Request is valid\n"
                    "401 : Unauthorized, Username or Password is not valid",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is ChatId ?",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "ChatId is common Id number between two people,\n"
                        "ChatId is the Unique Number which is used to Perform CRUD operations on messages of chatters,\n"
                        "Make chatId like this while perform PostApi call",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Person A's phoneNumber : 123456789\n"
                    "Person A have the phoneNumber of Person B in contacts: 987654321\n\n\n"
                    "Person B's phoneNumber : 987654321\n"
                    "Person B have the phoneNumber of Person A in contacts: 123456789\n\n\n"
                    "Now both have the numbers of each other\n\n\n"
                    "Now Id of A is : Sum(123456789 + 987654321)\n"
                    "Now Id of B is : Sum(987654321 + 123456789)\n\n"
                    "After this you get Id of(A) = Id of(B)\n\n\n"
                    "Now Find the digit sum of Id of(A) and Id of(B)\n"
                    "Now ChatId(A) = String(digit sum of Id of(A)) + String(Id of(A))\n"
                    "Now ChatId(B) = String(digit sum of Id of(B)) + String(Id of(B))\n\n"
                    "Now you get ChatId = ChatId(A) = ChatId(B)\n\n\n"
                    "Type of ChatId is String",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            )
          ],
        )
      ],
    );
  }
}

class ConsoleGetApiDeveloperPage extends StatelessWidget {
  const ConsoleGetApiDeveloperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              "Url of Project GetApi",
              style: GoogleFonts.orbitron(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30.0)),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text:
                                  "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/dev/$projectNameCurrunt"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Link copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/dev/$projectNameCurrunt",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.cyanAccent)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "This Api is for developer of project, "
                          "It is used to get all data of project",
                          style: GoogleFonts.orbitron(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 1:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "First you need to authenticate the API\n"
                        "So set header parameter of this API in your code like this",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text: "headers = {\n\n"
                                  "       'Content-Type': 'application/json',\n"
                                  "       'Password': '$passwordCurrunt',\n"
                                  "       'UserName': '$projectNameCurrunt',\n"
                                  "       'Authorization': 'Bearer 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'\n\n"
                                  "}"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Header copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "headers = {\n\n"
                      "       'Content-Type': 'application/json',\n"
                      "       'Password': '$passwordCurrunt',\n"
                      "       'UserName': '$projectNameCurrunt',\n"
                      "       'Authorization': 'Bearer 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'\n\n"
                      "}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 3:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Now you need to know the status code which is used in this API,\n"
                        "Use this Codes as API call verification",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "STATUS CODES\n\n\n"
                    "200 : RequestAccepted, Request is valid\n"
                    "401 : Unauthorized, Username or Password is not valid",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            )
          ],
        )
      ],
    );
  }
}

class ConsolePostApiOnProjectPage extends StatelessWidget {
  const ConsolePostApiOnProjectPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              "Url of PostApi on Project",
              style: GoogleFonts.orbitron(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30.0)),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text:
                                  "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/user/$projectNameCurrunt/post"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Link copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/user/$projectNameCurrunt/post",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 1:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "First you need to authenticate the API\n"
                        "So set header parameter of this API in your code like this",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text: "headers = {\n\n"
                                  "       'Content-Type': 'application/json',\n"
                                  "       'Password': '$passwordCurrunt',\n"
                                  "       'UserName': '$projectNameCurrunt',\n"
                                  "       'Authorization': 'Bearer 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'\n\n"
                                  "}"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Header copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "headers = {\n\n"
                      "       'Content-Type': 'application/json',\n"
                      "       'Password': '$passwordCurrunt',\n"
                      "       'UserName': '$projectNameCurrunt',\n"
                      "       'Authorization': 'Bearer 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'\n\n"
                      "}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 2:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Now make Post API request in your code,\n"
                        "This Url is used to upload message on API server\n"
                        "Give body Like this....",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text: "body = {\n\n"
                                  "       'projectName': '$projectNameCurrunt',\n"
                                  "       'chatId': '< Dynamic >',\n"
                                  "       'sendId': '< Dynamic >',\n"
                                  "       'deleteId': '< Dynamic >',\n"
                                  "       'time': '< Dynamic >',\n"
                                  "       'message': '< Dynamic >'\n\n"
                                  "}"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Body copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "body = {\n\n"
                      "       'projectName': '$projectNameCurrunt',\n"
                      "       'chatId': '< Dynamic >',\n"
                      "       'sendId': '< Dynamic >',\n"
                      "       'deleteId': '< Dynamic >',\n"
                      "       'time': '< Dynamic >',\n"
                      "       'message': '< Dynamic >'\n\n"
                      "}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is ChatId ?",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "ChatId is common Id number between two people,\n"
                        "ChatId is the Unique Number which is used to Perform CRUD operations on messages of chatters,\n"
                        "Make chatId like this while perform PostApi call",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Person A's phoneNumber : 123456789\n"
                    "Person A have the phoneNumber of Person B in contacts: 987654321\n\n\n"
                    "Person B's phoneNumber : 987654321\n"
                    "Person B have the phoneNumber of Person A in contacts: 123456789\n\n\n"
                    "Now both have the numbers of each other\n\n\n"
                    "Now Id of A is : Sum(123456789 + 987654321)\n"
                    "Now Id of B is : Sum(987654321 + 123456789)\n\n"
                    "After this you get Id of(A) = Id of(B)\n\n\n"
                    "Now Find the digit sum of Id of(A) and Id of(B)\n"
                    "Now ChatId(A) = String(digit sum of Id of(A)) + String(Id of(A))\n"
                    "Now ChatId(B) = String(digit sum of Id of(B)) + String(Id of(B))\n\n"
                    "Now you get ChatId = ChatId(A) = ChatId(B)\n\n\n"
                    "Type of ChatId is String",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is SendId ?",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "SendId is nothing but the mobile number of message sender,\n"
                        "SendId is used to delete all messages of sender,\n"
                        "Also it is used to identify the sender",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is DeleteId ?",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "DeleteId is the unique id of the message,\n"
                        "DeleteId is used to delete specific messages of sender,\n"
                        "DeleteId should be unique so use milliseconds from epoch in your implementation,\n"
                        "because milliseconds from epoch is always unique",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is Time ?",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Time is used to identify the timing of message,\n"
                        "Time is used to Order the messages in Ascending or Descending Order,\n"
                        "So give the proper DateTimeCalender object in Time parameter",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is Message ?",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Message is the text parameter,\n"
                        "Attach message in this parameter",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 3:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Now you need to know the status code which is used in this API,\n"
                        "Use this Codes as API call verification",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "STATUS CODES\n\n\n"
                    "201 : RequestAccepted, Content created on server\n"
                    "401 : Unauthorized, Username or Password is not valid",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            )
          ],
        )
      ],
    );
  }
}

class ConsolePostApiDeveloperPage extends StatelessWidget {
  const ConsolePostApiDeveloperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              "Url of Developer PostApi",
              style: GoogleFonts.orbitron(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30.0)),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text:
                                  "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/dev/$projectNameCurrunt"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Link copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/dev/$projectNameCurrunt",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.cyanAccent)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "This Api is for developer of project, "
                          "It is used to add on server from developer side",
                          style: GoogleFonts.orbitron(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 1:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "First you need to authenticate the API\n"
                        "So set header parameter of this API in your code like this",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text: "headers = {\n\n"
                                  "       'Content-Type': 'application/json',\n"
                                  "       'Password': '$passwordCurrunt',\n"
                                  "       'UserName': '$projectNameCurrunt',\n"
                                  "       'Authorization': 'Bearer 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'\n\n"
                                  "}"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Header copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "headers = {\n\n"
                      "       'Content-Type': 'application/json',\n"
                      "       'Password': '$passwordCurrunt',\n"
                      "       'UserName': '$projectNameCurrunt',\n"
                      "       'Authorization': 'Bearer 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'\n\n"
                      "}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 2:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Now make Post API request in your code,\n"
                        "This Url is used to upload message on API server\n"
                        "Give body Like this....",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text: "body = {\n\n"
                                  "       'projectName': '$projectNameCurrunt',\n"
                                  "       'chatId': '< Dynamic >',\n"
                                  "       'sendId': '< Dynamic >',\n"
                                  "       'deleteId': '< Dynamic >',\n"
                                  "       'time': '< Dynamic >',\n"
                                  "       'message': '< Dynamic >'\n\n"
                                  "}"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Body copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "body = {\n\n"
                      "       'projectName': '$projectNameCurrunt',\n"
                      "       'chatId': '< Dynamic >',\n"
                      "       'sendId': '< Dynamic >',\n"
                      "       'deleteId': '< Dynamic >',\n"
                      "       'time': '< Dynamic >',\n"
                      "       'message': '< Dynamic >'\n\n"
                      "}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is ChatId ?",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "ChatId is common Id number between two people,\n"
                        "ChatId is the Unique Number which is used to Perform CRUD operations on messages of chatters,\n"
                        "Make chatId like this while perform PostApi call",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Person A's phoneNumber : 123456789\n"
                    "Person A have the phoneNumber of Person B in contacts: 987654321\n\n\n"
                    "Person B's phoneNumber : 987654321\n"
                    "Person B have the phoneNumber of Person A in contacts: 123456789\n\n\n"
                    "Now both have the numbers of each other\n\n\n"
                    "Now Id of A is : Sum(123456789 + 987654321)\n"
                    "Now Id of B is : Sum(987654321 + 123456789)\n\n"
                    "After this you get Id of(A) = Id of(B)\n\n\n"
                    "Now Find the digit sum of Id of(A) and Id of(B)\n"
                    "Now ChatId(A) = String(digit sum of Id of(A)) + String(Id of(A))\n"
                    "Now ChatId(B) = String(digit sum of Id of(B)) + String(Id of(B))\n\n"
                    "Now you get ChatId = ChatId(A) = ChatId(B)\n\n\n"
                    "Type of ChatId is String",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is SendId ?",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "SendId is nothing but the mobile number of message sender,\n"
                        "SendId is used to delete all messages of sender,\n"
                        "Also it is used to identify the sender",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is DeleteId ?",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "DeleteId is the unique id of the message,\n"
                        "DeleteId is used to delete specific messages of sender,\n"
                        "DeleteId should be unique so use milliseconds from epoch in your implementation,\n"
                        "because milliseconds from epoch is always unique",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is Time ?",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Time is used to identify the timing of message,\n"
                        "Time is used to Order the messages in Ascending or Descending Order,\n"
                        "So give the proper DateTimeCalender object in Time parameter",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is Message ?",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Message is the text parameter,\n"
                        "Attach message in this parameter",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 3:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Now you need to know the status code which is used in this API,\n"
                        "Use this Codes as API call verification",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "STATUS CODES\n\n\n"
                    "201 : RequestAccepted, Content created on server\n"
                    "401 : Unauthorized, Username or Password is not valid",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            )
          ],
        )
      ],
    );
  }
}

class ConsoleDeleteApiByDeleteIdPage extends StatelessWidget {
  const ConsoleDeleteApiByDeleteIdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              "Url of DeleteApi by DeleteId",
              style: GoogleFonts.orbitron(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30.0)),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text:
                                  "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/single/delete/<deleteId>"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Link copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/single/delete/<deleteId>",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 1:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "First you need to authenticate the API\n"
                        "So set header parameter of this API in your code like this",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text: "headers = {\n\n"
                                  "       'Content-Type': 'application/json',\n"
                                  "       'Password': '$passwordCurrunt',\n"
                                  "       'UserName': '$projectNameCurrunt',\n"
                                  "       'Authorization': 'Bearer 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'\n\n"
                                  "}"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Header copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "headers = {\n\n"
                      "       'Content-Type': 'application/json',\n"
                      "       'Password': '$passwordCurrunt',\n"
                      "       'UserName': '$projectNameCurrunt',\n"
                      "       'Authorization': 'Bearer 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'\n\n"
                      "}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 2:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Now make Delete API request in your code,\n"
                        "This Url is used to delete specific message from sender side\n"
                        "Now you need to concatenate this API URL with DeleteId\n"
                        "Like this...",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  Text(
                    "Suppose your DeleteId is 16987575847847488465\n\n\n"
                    "So now your DeleteUrl is :\n"
                    "           https://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/single/delete/16987575847847488465",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 3:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Now you need to know the status code which is used in this API,\n"
                        "Use this Codes as API call verification",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "STATUS CODES\n\n\n"
                    "204 : RequestAccepted, Message deleted, No content\n"
                    "401 : Unauthorized, Username or Password is not valid",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is DeleteId ?",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "DeleteId is the unique id of the message,\n"
                        "DeleteId is used to delete specific messages of sender,\n"
                        "DeleteId should be unique so use milliseconds from epoch in your implementation,\n"
                        "because milliseconds from epoch is always unique",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            )
          ],
        )
      ],
    );
  }
}

class ConsoleDeleteApiByChatIdPage extends StatelessWidget {
  const ConsoleDeleteApiByChatIdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              "Url of DeleteApi by ChatId",
              style: GoogleFonts.orbitron(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30.0)),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text:
                                  "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/multi/chat/<chatId>"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Link copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/multi/chat/<chatId>",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 1:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "First you need to authenticate the API\n"
                        "So set header parameter of this API in your code like this",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text: "headers = {\n\n"
                                  "       'Content-Type': 'application/json',\n"
                                  "       'Password': '$passwordCurrunt',\n"
                                  "       'UserName': '$projectNameCurrunt',\n"
                                  "       'Authorization': 'Bearer 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'\n\n"
                                  "}"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Header copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "headers = {\n\n"
                      "       'Content-Type': 'application/json',\n"
                      "       'Password': '$passwordCurrunt',\n"
                      "       'UserName': '$projectNameCurrunt',\n"
                      "       'Authorization': 'Bearer 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'\n\n"
                      "}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 2:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Now make Delete API request in your code,\n"
                        "This Url is used to delete all message between two people\n"
                        "Now you need to concatenate this API URL with ChatId\n"
                        "Like this...",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  Text(
                    "Suppose your ChatId is 87646463864365\n\n\n"
                    "So now your DeleteUrl is :\n"
                    "           https://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/multi/chat/87646463864365",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 3:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Now you need to know the status code which is used in this API,\n"
                        "Use this Codes as API call verification",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "STATUS CODES\n\n\n"
                    "204 : RequestAccepted, Message deleted, No content\n"
                    "401 : Unauthorized, Username or Password is not valid",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is ChatId ?",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "ChatId is common Id number between two people,\n"
                        "ChatId is the Unique Number which is used to Perform CRUD operations on messages of chatters,\n"
                        "Make chatId like this while perform PostApi call",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Person A's phoneNumber : 123456789\n"
                    "Person A have the phoneNumber of Person B in contacts: 987654321\n\n\n"
                    "Person B's phoneNumber : 987654321\n"
                    "Person B have the phoneNumber of Person A in contacts: 123456789\n\n\n"
                    "Now both have the numbers of each other\n\n\n"
                    "Now Id of A is : Sum(123456789 + 987654321)\n"
                    "Now Id of B is : Sum(987654321 + 123456789)\n\n"
                    "After this you get Id of(A) = Id of(B)\n\n\n"
                    "Now Find the digit sum of Id of(A) and Id of(B)\n"
                    "Now ChatId(A) = String(digit sum of Id of(A)) + String(Id of(A))\n"
                    "Now ChatId(B) = String(digit sum of Id of(B)) + String(Id of(B))\n\n"
                    "Now you get ChatId = ChatId(A) = ChatId(B)\n\n\n"
                    "Type of ChatId is String",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            )
          ],
        )
      ],
    );
  }
}

class ConsoleDeleteApiBySendIdPage extends StatelessWidget {
  const ConsoleDeleteApiBySendIdPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              "Url of DeleteApi by SendId",
              style: GoogleFonts.orbitron(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30.0)),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text:
                                  "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/multi/send/<sendId>"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Link copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/multi/send/<sendId>",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 1:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "First you need to authenticate the API\n"
                        "So set header parameter of this API in your code like this",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text: "headers = {\n\n"
                                  "       'Content-Type': 'application/json',\n"
                                  "       'Password': '$passwordCurrunt',\n"
                                  "       'UserName': '$projectNameCurrunt',\n"
                                  "       'Authorization': 'Bearer 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'\n\n"
                                  "}"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Header copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "headers = {\n\n"
                      "       'Content-Type': 'application/json',\n"
                      "       'Password': '$passwordCurrunt',\n"
                      "       'UserName': '$projectNameCurrunt',\n"
                      "       'Authorization': 'Bearer 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'\n\n"
                      "}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 2:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Now make Delete API request in your code,\n"
                        "This Url is used to delete all messages of sender\n"
                        "Now you need to concatenate this API URL with SendId\n"
                        "Like this...",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  Text(
                    "Suppose your SendId is 9228373734343\n\n\n"
                    "So now your DeleteUrl is :\n"
                    "           https://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/multi/send/9228373734343",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 3:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Now you need to know the status code which is used in this API,\n"
                        "Use this Codes as API call verification",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "STATUS CODES\n\n\n"
                    "204 : RequestAccepted, Message deleted, No content\n"
                    "401 : Unauthorized, Username or Password is not valid",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What is SendId ?",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "SendId is nothing but the mobile number of message sender,\n"
                        "SendId is used to delete all messages of sender,\n"
                        "Also it is used to identify the sender",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            )
          ],
        )
      ],
    );
  }
}

class ConsoleDeleteApiDeveloperPage extends StatelessWidget {
  const ConsoleDeleteApiDeveloperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              "Url of DeleteApi by SendId",
              style: GoogleFonts.orbitron(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30.0)),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text:
                                  "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/dev/$projectNameCurrunt"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Link copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "https://hyphen-v7.onrender.com/org.roundrobin/hyphen/dev/$projectNameCurrunt",
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.cyanAccent)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "This Api is for developer of project, "
                          "It is used to delete all data from project",
                          style: GoogleFonts.orbitron(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 1:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "First you need to authenticate the API\n"
                        "So set header parameter of this API in your code like this",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(
                              text: "headers = {\n\n"
                                  "       'Content-Type': 'application/json',\n"
                                  "       'Password': '$passwordCurrunt',\n"
                                  "       'UserName': '$projectNameCurrunt',\n"
                                  "       'Authorization': 'Bearer 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'\n\n"
                                  "}"))
                          .then((value) => MotionToast.success(
                                  title: const Text("Success"),
                                  description:
                                      const Text("Header copied on clipboard"))
                              .show(context));
                    },
                    child: Text(
                      "headers = {\n\n"
                      "       'Content-Type': 'application/json',\n"
                      "       'Password': '$passwordCurrunt',\n"
                      "       'UserName': '$projectNameCurrunt',\n"
                      "       'Authorization': 'Bearer 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'\n\n"
                      "}",
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 2:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Now make Delete API request in your code,\n"
                        "This Url is used to delete all messages of project",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Step 3:",
                        style: GoogleFonts.orbitron(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Now you need to know the status code which is used in this API,\n"
                        "Use this Codes as API call verification",
                        style: GoogleFonts.orbitron(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.amberAccent),
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "STATUS CODES\n\n\n"
                    "204 : RequestAccepted, Message deleted, No content\n"
                    "401 : Unauthorized, Username or Password is not valid",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 70,
            )
          ],
        )
      ],
    );
  }
}
