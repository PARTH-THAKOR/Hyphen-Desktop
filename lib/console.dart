// CONSOLE ACTIVITY

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hyphen/jsonmodel.dart';
import 'package:hyphen/loginpage.dart';
import 'package:hyphen/projectpage.dart';
import 'package:http/http.dart' as http;

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
                      child: Text(
                        "ProjectName: $projectNameCurrunt",
                        style: GoogleFonts.orbitron(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        "Password🔒: $passwordCurrunt",
                        style: GoogleFonts.orbitron(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
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
          height: MediaQuery.of(context).size.height * 0.6,
          child: const ConsoleApiTypeButtons(),
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
      ),
      Scaffold(
        backgroundColor: Color(0xFF414141),
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
      ),
      Scaffold(
        backgroundColor: Color(0xFF414141),
      ),
      Scaffold(
        backgroundColor: Color(0xFF414141),
      ),
      Scaffold(
        backgroundColor: Color(0xFF414141),
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
            "http://hyphen-v7.onrender.com/org.roundrobin/hyphen/dev/$projectNameCurrunt"),
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
                                    onPressed: () {},
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
                  child: Text(
                    "http://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/<chatId>/asc",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                    textAlign: TextAlign.center,
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
                  Text(
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
                    "           http://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/87646463864365/asc",
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
                  child: Text(
                    "http://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/<chatId>/desc",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                    textAlign: TextAlign.center,
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
                  Text(
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
                    "           http://hyphen-v7.onrender.com/org.roundrobin/hyphen/$projectNameCurrunt/user/87646463864365/desc",
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
                  child: Text(
                    "http://hyphen-v7.onrender.com/org.roundrobin/hyphen/dev/$projectNameCurrunt",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.amberAccent),
                    textAlign: TextAlign.center,
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
                  Text(
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
                        "This Url is used to get all chat of project",
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
                    "your ProjectName is $projectNameCurrunt\n\n\n"
                    "your Project GetUrl is :\n"
                    "           http://hyphen-v7.onrender.com/org.roundrobin/hyphen/dev/$projectNameCurrunt",
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
            const SizedBox(
              height: 70,
            )
          ],
        )
      ],
    );
  }
}

class ConsoleJsonPage extends StatefulWidget {
  const ConsoleJsonPage({Key? key}) : super(key: key);

  @override
  State<ConsoleJsonPage> createState() => _ConsoleJsonPageState();
}

class _ConsoleJsonPageState extends State<ConsoleJsonPage> {
  List<Jsonmodel> userDataList = [];

  getUserData() async {
    final responce = await http.get(
        Uri.parse(
            "http://hyphen-v7.onrender.com/org.roundrobin/hyphen/dev/$projectNameCurrunt"),
        headers: {
          'Content-Type': 'application/json',
          'Password': passwordCurrunt,
          'UserName': projectNameCurrunt,
          'Authorization':
              'Bearer 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'
        });
    var data = jsonDecode(responce.body.toString());
    if (responce.statusCode == 200) {
      for (var i in data) {
        userDataList.add(Jsonmodel.fromJson(i));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
              future: getUserData(),
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: userDataList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(userDataList[index].id.toString()),
                        subtitle: Text(userDataList[index].message.toString()),
                      );
                    });
              }),
        )
      ],
    );
  }
}
