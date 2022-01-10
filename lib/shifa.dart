// ignore_for_file: unused_local_variable, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_final_fields, unused_field, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, unused_element, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  var ls = [
    {
      "name": "Rakib",
      "age": "23",
      "gender": "male",
      "Adress": ["address 1", "Adress 2"]
    }
  ];

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirebaseDemo(),
  ));
}

class FirebaseDemo extends StatefulWidget {
  FirebaseDemo({Key? key}) : super(key: key);

  @override
  _FirebaseDemoState createState() => _FirebaseDemoState();
}

class _FirebaseDemoState extends State<FirebaseDemo> {
  // FirebaseFirestore firestore = FirebaseFirestore.instance;

//  CollectionReference user= FirebaseFirestore.instance.collection('user');

  CollectionReference users = FirebaseFirestore.instance.collection('users2');

  // Stream<QuerySnapshot> _stream =
  //     FirebaseFirestore.instance.collection('users2').snapshots();

  // Stream<QuerySnapshot> _stream =
  //     FirebaseFirestore.instance.collection("users2").snapshots();

  Stream<QuerySnapshot> stream =
      FirebaseFirestore.instance.collection('users2').snapshots();

  String name = "";
  String age = "";
  String gender = "";
  String address = "";

  // _adduser() {
  //   name = userName.text;
  //   age = userage.text;
  //   gender = usergender.text;
  //   print("object");
  //   return users.add(
  //     {"name": name, "age": age, "gender": gender},
  //   );
  // }

  // _adduser() {
  //   name = userName.text;
  //   age = userage.text;
  //   address = useraddress.text;
  //   gender = usergender.text;
  //   print(name);
  //   return users.add(
  //     {"Name": "name", "age": "age", "address": "address", "gender": "gender"},
  //   );
  // }

  _adddata() {
    users.add({
      "Gender": usergender.text,
      "Name": userName.text,
      "Age": userage.text,
      "Address": useraddress.text,
    });
  }

  var iddoc;

  TextEditingController userName = TextEditingController();
  TextEditingController userage = TextEditingController();
  TextEditingController useraddress = TextEditingController();
  TextEditingController usergender = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                  decoration: InputDecoration(labelText: "User Name"),
                  controller: userName),
              TextField(
                  decoration: InputDecoration(labelText: "User age"),
                  controller: userage),
              TextField(
                  decoration: InputDecoration(labelText: "User Address"),
                  controller: useraddress),
              TextField(
                  decoration: InputDecoration(labelText: "User Gender"),
                  controller: usergender),
              Row(
                children: [
                  ElevatedButton(onPressed: _adddata, child: Text("Click")),
                  ElevatedButton(
                      onPressed: () {
                        users.doc("8dt4PZrV2OcloofErWqK").set({
                          "Gender": usergender.text,
                          "Name": userName.text,
                          "Age": userage.text,
                        });
                      },
                      child: Text("update"))
                ],
              ),

              // StreamBuilder(
              //     stream: stream,
              //     builder: (BuildContext context,
              //         AsyncSnapshot<QuerySnapshot> snapshot) {
              //           if(snapshot.hasError){
              //             return Text("Data not found");
              //           }if(snapshot.connectionState==ConnectionState.waiting){
              //             return CircularProgressIndicator();
              //           }
              //           if(snapshot.connectionState==ConnectionState.done){
              //             return CircularProgressIndicator();
              //           }
              //       return Container(
              //         width: double.maxFinite,
              //         height: 300,
              //         child: ListView.builder(
              //             itemCount: snapshot.data!.docs.length,
              //             itemBuilder: (context, index) => Container(
              //                   child: Card(
              //                     child: Column(
              //                       children: [
              //                         Text(
              //                             "${snapshot.data!.docs[index]["Name"]}"),
              //                         Text(
              //                             "${snapshot.data!.docs[index]["Age"]}"),
              //                             Text(
              //                             "${snapshot.data!.docs[index]["Gender"]}"),
              //                             Text(
              //                             "${snapshot.data!.docs[index]["Address"]}"),
              //                       ],
              //                     ),
              //                   ),
              //                 )),
              //       );
              //     })

              StreamBuilder(
                  stream: stream,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Not found");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }

                    return Container(
                      height: 500,
                      width: double.maxFinite,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            snapshot.data!.docs.forEach((element) {
                              iddoc = element.id;
                            });
                            return Card(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Center(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              users.doc(iddoc).delete().then(
                                                  (value) =>
                                                      Text("successfull"));
                                            },
                                            child: Text("Clear")),
                                      ),
                                    ],
                                  ),
                                  Text("${snapshot.data!.docs[index]["Name"]}"),
                                  Text("${snapshot.data!.docs[index]["Age"]}"),
                                  Text(
                                      "${snapshot.data!.docs[index]["Address"]}"),
                                  Text(
                                      "${snapshot.data!.docs[index]["Gender"]}")
                                ],
                              ),
                            );
                          }),
                    );
                  })

              // StreamBuilder(
              //     stream: FirebaseFirestore.instance
              //         .collection('users2')
              //         .snapshots(),
              //     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //       print(snapshot);
              //       if (snapshot.hasError) {
              //         return Text("hasError");
              //       }
              //       if (snapshot.connectionState == ConnectionState.waiting) {
              //         return CircularProgressIndicator();
              //       }
              //       // if (snapshot.connectionState == ConnectionState.active) {
              //       //   print("ConnectionState.done");
              //       //   return CircularProgressIndicator();
              //       // }
              //       return Container(
              //         color: Colors.amber,
              //         height: 300,
              //         width: double.infinity,
              //         child: ListView.builder(
              //           itemCount: snapshot.data!.docs.length,
              //           itemBuilder: (context, index) =>

              // snapshot.data.docs.foreach((id){
              //   iddoc=id.id;
              // });

              //               ListTile(
              //             title: Text("${snapshot.data!.docs[index]["name"]}"),
              //             leading: Text("${snapshot.data!.docs[index]["age"]}"),
              //             subtitle:
              //                 Text("${snapshot.data!.docs[index]["gender"]}"),
              //           ),
              //         ),
              //       );
              //     })
            ],
          ),
        ));
  }
}

class MyApp extends StatefulWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('users').snapshots();

  String name = "";

  String age = "";
  String gender = "";
  _adduser() {
    return users.add(
      {"name": name, "age": age, "gender": gender},
    );
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final p = [
    Container(
      color: Colors.amber,
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.blue,
    ),
  ];

  int i = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.blue,
            // fixedColor: Colors.black,
            onTap: (t) {
              setState(() {
                i = t;
              });
            },
            currentIndex: i,
            selectedItemColor: Colors.amber[800],
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "a"),
              BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "a"),
              BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "a"),
              BottomNavigationBarItem(icon: Icon(Icons.ac_unit), label: "a")
            ]),
        appBar: AppBar(),
        body: p.elementAt(i)
        //  LiquidSwipe(pages: p)
        //  Center(
        //   child: Container(
        //     child: ElevatedButton(
        //         onPressed: () {
        //           showBottomSheet(
        //               context: context,
        //               builder: (context) => Container(
        //                     child: Column(
        //                       children: [
        //                         ListTile(
        //                           title: Text("heel"),
        //                           trailing: Text("data"),
        //                         )
        //                       ],
        //                     ),
        //                   ));

        //           Fluttertoast.showToast(
        //               msg: "This is Center Short Toast",
        //               toastLength: Toast.LENGTH_LONG,
        //               gravity: ToastGravity.CENTER,
        //               timeInSecForIosWeb: 2,
        //               backgroundColor: Colors.red,
        //               textColor: Colors.white,
        //               fontSize: 16.0);
        //           print("object");
        //         },
        //         child: Text("fsf")),
        //   ),
        // ),
        );
  }
}
