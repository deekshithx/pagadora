import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> namesOfParticipants = [];
  List<String> suggestedParticipants = [
    'Deekshith Shetty',
    'Chaitanya',
    'Chandramouli',
    'Devanand',
    'Deepak',
    'Ganapathy SriRam',
    'Likhita',
    'Nisha',
    'Shreyas',
    'Sushma'
  ];
  TextEditingController nameController = TextEditingController();
  Color themeColor = const Color(0xff171717);
  Color whiteColor = Colors.white;

  void choosePagadora() {
    if (namesOfParticipants.isNotEmpty) {
      var rng = Random();
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PagadoraPage(
                pagadora: namesOfParticipants[
                    rng.nextInt(namesOfParticipants.length)])),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Add some names to check")));
    }
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Widget suggestedPagadora() {
    List<Widget> pagadoras = [];
    for (String pagadora in suggestedParticipants) {
      pagadoras.add(GestureDetector(
        onTap: () {
          setState(() {
            namesOfParticipants.add(pagadora);
            suggestedParticipants.remove(pagadora);
          });
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: themeColor, width: 2),
              color: whiteColor,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  pagadora,
                  style: TextStyle(color: themeColor, fontSize: 16),
                ),
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.add,
                  color: themeColor,
                )
              ],
            ),
          ),
        ),
      ));
    }
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: pagadoras,
    );
  }

  Widget listOfPagadora() {
    List<Widget> pagadoras = [];
    for (String pagadora in namesOfParticipants) {
      pagadoras.add(GestureDetector(
        onTap: () {
          setState(() {
            namesOfParticipants.remove(pagadora);
          });
        },
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: themeColor, width: 2),
              color: themeColor,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  capitalize(pagadora),
                  style: TextStyle(fontSize: 16, color: whiteColor),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  width: 5,
                ),
                Icon(Icons.close, color: whiteColor)
              ],
            ),
          ),
        ),
      ));
    }
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: pagadoras,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(themeColor),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(15)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: themeColor)))),
            onPressed: choosePagadora,
            child: Text(
              'Pick a Pagadora',
              style: TextStyle(color: whiteColor, fontSize: 16),
            )),
      ),
      appBar: AppBar(
        backgroundColor: themeColor,
        title: const Text("The Pagadora"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor, width: 1),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: themeColor, width: 1),
                    ),
                    labelText: 'Enter the names',
                    labelStyle: TextStyle(fontSize: 14, color: themeColor),
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            if (nameController.text.isNotEmpty) {
                              if (namesOfParticipants
                                  .contains(nameController.text)) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text(
                                        "${nameController.text} already added")));
                              } else {
                                namesOfParticipants.add(nameController.text);
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Enter a name first")));
                            }

                            nameController.clear();
                          });
                        },
                        icon: Icon(
                          Icons.person_add_alt_rounded,
                          color: themeColor,
                        ))),
                controller: nameController,
              ),
              if (namesOfParticipants.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Selected Names',
                      style: TextStyle(
                          fontSize: 16,
                          color: themeColor,
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            namesOfParticipants.clear();
                          });
                        },
                        child: Text(
                          'clear all',
                          style: TextStyle(
                            color: themeColor,
                            decoration: TextDecoration.underline,
                          ),
                        )),
                  ],
                ),
              listOfPagadora(),
              SizedBox(
                height: screenSize.width *
                            0.6 *
                            (namesOfParticipants.length * 0.17) >
                        screenSize.width * 0.4
                    ? screenSize.width * 0.4
                    : screenSize.width *
                        0.6 *
                        (namesOfParticipants.length * 0.17),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 5),
                child: Text(
                  'Suggested Names',
                  style: TextStyle(
                      fontSize: 16,
                      color: themeColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
              suggestedPagadora(),
            ],
          ),
        ),
      ),
    );
  }
}

class PagadoraPage extends StatefulWidget {
  PagadoraPage({Key? key, required this.pagadora}) : super(key: key);
  String pagadora;
  @override
  State<PagadoraPage> createState() => _PagadoraPageState();
}

class _PagadoraPageState extends State<PagadoraPage> {
  int rand = 0;

  @override
  void initState() {
    var rng = Random();
    rng.nextInt(14);
    rand = rng.nextInt(14) + 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 10, vertical: screenSize.height * 0.08),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.adaptive.arrow_back,
                  size: 30,
                )),
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Image.asset(
                'assets/gif_$rand.gif',
                width: screenSize.width,
                fit: BoxFit.fitWidth,
              ),
              Positioned(
                bottom: 20,
                child: Container(
                  color: Colors.black54,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      widget.pagadora,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: screenSize.height * 0.1,
          ),
        ],
      ),
    );
  }
}
