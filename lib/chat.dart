import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class Chat extends StatefulWidget {
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  //FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference user = FirebaseFirestore.instance.collection('users3');
  Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('users3').snapshots();
  String name = "";
  String age = "";
  String gender = "";
  String address = "";
  _adduser() {
    name = username.text;
    age = userage.text;
    gender = usergender.text;
    address = useraddress.text;
    return user
        .add({
          "name": name, //"age": age, "address": address, "gender": gender
        })
        .then((value) => Text("fond"))
        .catchError((onError) => Text("$onError"));
  }

  TextEditingController username = TextEditingController();
  TextEditingController userage = TextEditingController();
  TextEditingController usergender = TextEditingController();
  TextEditingController useraddress = TextEditingController();
  var iddoc;
  var uname;
  var editId;
  // Stream<QuerySnapshot> stream =
  //     FirebaseFirestore.instance.collection('users3').snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      appBar: AppBar(
        title: Text(
          "fahim",
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyuNmKLH6z4CQcAIyXxT-QkhP7zaUR73L43g&usqp=CAU"),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: Icon(Icons.video_call)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.power_input)),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Container(
                  //   height: 300,
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //         filled: true,
                  //         fillColor: Colors.white30,
                  //         //focusColor: Colors.red,
                  //         // hoverColor:,
                  //         labelText: "name",
                  //         icon: IconButton(
                  //             onPressed: _adduser, icon: Icon(Icons.send))),
                  //     controller: username,
                  //   ),
                  // ),
                  // TextField(
                  //   decoration: InputDecoration(labelText: "age"),
                  //   controller: userage,
                  // ),
                  // TextField(
                  //   decoration: InputDecoration(labelText: "gender"),
                  //   controller: usergender,
                  // ),
                  // TextField(
                  //   decoration: InputDecoration(labelText: "address"),
                  //   controller: useraddress,
                  // ),
                  // ElevatedButton(onPressed: _adduser, child: Text("add")),
                  ///IconButton(onPressed: _adduser, icon: Icon(Icons.send)),
                  StreamBuilder(
                      stream: _stream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text("data is not found");
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        }
                        return Container(
                          height: 490,
                          width: double.infinity,
                          child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                snapshot.data!.docs.forEach((element) {
                                  iddoc = element.id;
                                });
                                return Container(
                                  width: double.maxFinite,
                                  child: Card(
                                    color: Colors.white70,
                                    child: Column(
                                      children: [
                                        // Text("${snapshot.data!.docs[index]["name"]}"),
                                        // Text("${snapshot.data!.docs[index]["age"]}"),
                                        // Text(
                                        //     "${snapshot.data!.docs[index]["gender"]}"),
                                        // Text(
                                        //     "${snapshot.data!.docs[index]["address"]}"),

                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    editId = snapshot
                                                        .data!.docs[index].id;
                                                  });
                                                  user
                                                      .doc(editId)
                                                      .delete()
                                                      .then((value) => Text(
                                                          "succecfully deleted"))
                                                      .onError(
                                                          (error, stackTrace) =>
                                                              Text("$error"));
                                                },
                                                icon: Icon(Icons.delete)),
                                            IconButton(
                                                onPressed: () {
                                                  setState(() {
                                                    editId = snapshot
                                                        .data!.docs[index].id;
                                                  });
                                                  // snapshot.data!.docs[editId].["Age"]
                                                  var s = user
                                                      .doc(editId)
                                                      .get()
                                                      .then((value) => {
                                                                uname = value[
                                                                    "name"],
                                                                // value["age"],
                                                                // value["gender"],
                                                                // value["address"],
                                                              }
                                                          //  print(
                                                          //     "Hell ${value["Name"]}")
                                                          );
                                                  print(s);

                                                  username.text = snapshot.data!
                                                      .docs[index]["name"];
                                                  // userage.text = snapshot
                                                  //     .data!.docs[index]["age"];
                                                  // useraddress.text = snapshot
                                                  //     .data!.docs[index]["address"];
                                                  // usergender.text = snapshot
                                                  //     .data!.docs[index]["gender"];
                                                },
                                                icon: Icon(Icons.edit)),
                                            // ElevatedButton(
                                            //     onPressed: () {
                                            //       setState(() {
                                            //         editId =
                                            //             snapshot.data!.docs[index].id;
                                            //       });
                                            //       user
                                            //           .doc(editId)
                                            //           .delete()
                                            //           .then((value) =>
                                            //               Text("succecfully deleted"))
                                            //           .onError((error, stackTrace) =>
                                            //               Text("$error"));
                                            //     },
                                            //     child: Text("Delete")),
                                            // ElevatedButton(
                                            //     onPressed: () {
                                            //       setState(() {
                                            //         editId =
                                            //             snapshot.data!.docs[index].id;
                                            //       });
                                            //       // snapshot.data!.docs[editId].["Age"]
                                            //       var s = user.doc(editId).get().then(
                                            //           (value) => {
                                            //                 uname = value["name"],
                                            //                 // value["age"],
                                            //                 // value["gender"],
                                            //                 // value["address"],
                                            //               }
                                            //           //  print(
                                            //           //     "Hell ${value["Name"]}")
                                            //           );
                                            //       print(s);

                                            //       username.text = snapshot
                                            //           .data!.docs[index]["name"];
                                            //       // userage.text = snapshot
                                            //       //     .data!.docs[index]["age"];
                                            //       // useraddress.text = snapshot
                                            //       //     .data!.docs[index]["address"];
                                            //       // usergender.text = snapshot
                                            //       //     .data!.docs[index]["gender"];
                                            //     },
                                            //     child: Text("Edit")),
                                            IconButton(
                                                onPressed: () {
                                                  user.doc(editId).update({
                                                    // "age": userage.text,
                                                    "name": username.text,
                                                    // "gender": usergender.text,
                                                    // "address": useraddress.text
                                                  });
                                                },
                                                icon: Icon(Icons.update)),
                                            // ElevatedButton(
                                            //   onPressed: () {
                                            //     user.doc(editId).update({
                                            //       // "age": userage.text,
                                            //       "name": username.text,
                                            //       // "gender": usergender.text,
                                            //       // "address": useraddress.text
                                            //     });
                                            //   },

                                            //   // users.doc("1uhq3YJvwvqXFbRg6rbS").set({
                                            //   //   "Gender": "female",
                                            //   //   "Name": "Akash",
                                            //   //   "Age": userupdate.text,
                                            //   // });
                                            //   // },
                                            //   child: Text("Update"),
                                            // ),
                                            // ElevatedButton(
                                            //     onPressed: () {
                                            //       setState(() {
                                            //         user.doc(iddoc).delete();
                                            //       });
                                            //     },
                                            //     child: Text("delete")),

                                            // ElevatedButton(
                                            //     onPressed: () {
                                            //       user.doc(iddoc).update({
                                            //         "name": username.text,
                                            //         "age": userage.text,
                                            //         "gender": usergender.text,
                                            //         "address": useraddress.text
                                            //       });
                                            //     },
                                            //     child: Text("update"))
                                          ],
                                        ),
                                        Text(
                                          snapshot.data!.docs[index]["name"],
                                          // textAlign: TextAlign.right,
                                        ),
                                        // Text(snapshot.data!.docs[index]["age"]),
                                        // Text(snapshot.data!.docs[index]["gender"]),
                                        // Text(snapshot.data!.docs[index]["address"]),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              // => Container(
                              //   child: Card(
                              //         child: Column(
                              //           children: [
                              //             Text(snapshot.data!.docs[index]["name"]),
                              //             Text(snapshot.data!.docs[index]["age"]),
                              //             Text(snapshot.data!.docs[index]["gender"]),
                              //             Text(snapshot.data!.docs[index]["address"]),

                              //           ],
                              //         ),
                              //       ),
                              // ),
                              ),
                        );
                      }),
                  // Container(
                  //   height: 100,
                  //   child: TextField(
                  //     // textAlign: TextAlign.left,
                  //     decoration: InputDecoration(
                  //         filled: true,
                  //         fillColor: Colors.white30,
                  //         //focusColor: Colors.red,
                  //         // hoverColor:,
                  //         labelText: "message",
                  //         icon: IconButton(
                  //             onPressed: _adduser, icon: Icon(Icons.send))),
                  //     controller: username,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: TextField(
                // textAlign: TextAlign.left,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white30,
                  //focusColor: Colors.red,
                  // hoverColor:,
                  labelText: "message",
                  suffixIcon: IconButton(
                      onPressed: _adduser,
                      icon: Icon(Icons.send)), //Icon(Icons.send),
                  // icon: IconButton(
                  //   onPressed: _adduser,
                  //   icon: Icon(Icons.send),
                  // ),
                ),
                controller: username,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// import 'dart:js_util';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:project1/home2.dart';
// import 'package:project1/home3.dart';

// class loginpage extends StatefulWidget {
//   @override
//   _loginpageState createState() => _loginpageState();
// }

// class _loginpageState extends State<loginpage> {
//   var getText = TextEditingController();
//   TextEditingController getpass = TextEditingController();
//   TextEditingController getclr = TextEditingController();

//   var clr = Colors.white;
//   var istrue;
//   var clrs2;
//   onpress() {
//     var s = getText.text;
//     var p = getpass.text;
//     if (s == "mifta" && p == "12345") {
//       Navigator.push(context, MaterialPageRoute(builder: (_) => SecondPage()));
//     } else {
//       var snackBar = SnackBar(
//         content: Text(
//           "try again",
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: Colors.red,
//       );
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: clr,
//       // backgroundColor: clrs2,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 setState(() {
//                   if (istrue == false) {
//                     clr = Colors.white;
//                     istrue = true;
//                   } else if (clr == "red") {
//                     clr = Colors.red;
//                   } else {
//                     clr = Colors.black;
//                     istrue = false;
//                   }
//                 });
//               },
//               icon: Icon(FontAwesomeIcons.moon))
//         ],
//         title: Center(
//             child: Text(
//           "teacher",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         )),
//       ),
//       body: Center(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text("enter color"),
//             ),
//             Center(
//               child: TextField(
//                 controller: getclr,
//                 keyboardAppearance: Brightness.dark,
//                 autocorrect: true,
//                 enableSuggestions: true,
//                 autofocus:
//                     false, //likhar jnno aladha vabe click korte na howar jnno use hoi
//                 textCapitalization: TextCapitalization.characters,
//                 textAlignVertical:
//                     TextAlignVertical.bottom, //?????????????????????jante chai
//                 scrollPhysics: BouncingScrollPhysics(),
//                 enableInteractiveSelection:
//                     false, //&&&&&&&&select kore copy paste korte na parar jnno
//                 maxLength: 20, //koita letter dewa jabe setar jnno
//                 maxLines: 1, //koi line hbe setar jnno
//                 textAlign: TextAlign.start,
//                 textDirection: TextDirection.ltr,
//                 showCursor: true,
//                 // obscureText: true,
//                 cursorHeight: 30,
//                 cursorWidth: 10,
//                 cursorColor: Colors.yellow,
//                 cursorRadius: Radius.circular(12),

//                 decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.email),
//                   suffixIcon: Card(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(40)),
//                       color: Colors.blue,
//                       child: Icon(
//                         Icons.search,
//                         size: 45,
//                         color: Colors.white,
//                       )),
//                   // suffix: CircleAvatar(
//                   //   radius: 30,
//                   //   backgroundColor: Colors.green,
//                   //   child: Icon(Icons.access_alarm),
//                   // ),
//                   hoverColor: Colors.blue,
//                   labelText: "enter color...",
//                   hintText: "enter your color please.............",
//                   hintStyle: TextStyle(fontSize: 10),
//                   //  border: InputBorder.none, //border na rakhar jnno
//                   // OutlineInputBorder(borderRadius: BorderRadius.circular(15),
//                   // ),
//                   //contentPadding: EdgeInsets.all(15),
//                   fillColor: Colors.white, //color(0xff00FFF)
//                   filled: true,
//                   enabled: true,
//                   focusColor: Colors.black,
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 5,
//                           color: Colors.blue,
//                           style: BorderStyle.solid),
//                       borderRadius: BorderRadius.circular(40)),
//                   enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(width: 5, color: Colors.blue),
//                       borderRadius: BorderRadius.circular(40)),
//                   disabledBorder: InputBorder.none,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text("enter mail"),
//             ),
//             Center(
//               child: TextField(
//                 keyboardType: TextInputType.numberWithOptions(
//                     decimal: true), //emailAddress,
//                 inputFormatters: [
//                   FilteringTextInputFormatter.allow(RegExp('[0-5.,]+')),
//                   // FilteringTextInputFormatter.deny(RegExp('[1-5.,]+')),
//                 ],
//                 controller: getText,
//                 keyboardAppearance: Brightness.dark,
//                 autocorrect: true,
//                 enableSuggestions: true,
//                 autofocus:
//                     false, //likhar jnno aladha vabe click korte na howar jnno use hoi
//                 textCapitalization: TextCapitalization.characters,
//                 textAlignVertical:
//                     TextAlignVertical.bottom, //?????????????????????jante chai
//                 scrollPhysics: BouncingScrollPhysics(),
//                 enableInteractiveSelection:
//                     false, //&&&&&&&&select kore copy paste korte na parar jnno
//                 maxLength: 20, //koita letter dewa jabe setar jnno
//                 maxLines: 1, //koi line hbe setar jnno
//                 textAlign: TextAlign.start,
//                 textDirection: TextDirection.ltr,
//                 showCursor: true,
//                 // obscureText: true,
//                 cursorHeight: 30,
//                 cursorWidth: 10,
//                 cursorColor: Colors.yellow,
//                 cursorRadius: Radius.circular(12),

//                 decoration: InputDecoration(
//                   prefixIcon: Icon(Icons.email),
//                   suffixIcon: Card(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(40)),
//                       color: Colors.blue,
//                       child: Icon(
//                         Icons.search,
//                         size: 45,
//                         color: Colors.white,
//                       )),
//                   // suffix: CircleAvatar(
//                   //   radius: 30,
//                   //   backgroundColor: Colors.green,
//                   //   child: Icon(Icons.access_alarm),
//                   // ),
//                   hoverColor: Colors.blue,
//                   labelText: "enter mail...",
//                   hintText: "enter your mail please.............",
//                   hintStyle: TextStyle(fontSize: 10),
//                   //  border: InputBorder.none, //border na rakhar jnno
//                   // OutlineInputBorder(borderRadius: BorderRadius.circular(15),
//                   // ),
//                   //contentPadding: EdgeInsets.all(15),
//                   fillColor: Colors.white, //color(0xff00FFF)
//                   filled: true,
//                   enabled: true,
//                   focusColor: Colors.black,
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(
//                           width: 5,
//                           color: Colors.blue,
//                           style: BorderStyle.solid),
//                       borderRadius: BorderRadius.circular(40)),
//                   enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(width: 5, color: Colors.blue),
//                       borderRadius: BorderRadius.circular(40)),
//                   disabledBorder: InputBorder.none,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text("enter password"),
//             ),
//             Center(
//               child: TextField(
//                 controller: getpass,
//                 enableInteractiveSelection: false,
//                 showCursor: true,
//                 obscureText: true,
//                 cursorHeight: 40,
//                 cursorWidth: 8,
//                 scrollPhysics: BouncingScrollPhysics(),
//                 cursorColor: Colors.yellow,
//                 decoration: InputDecoration(
//                   hoverColor: Colors.blue,
//                   labelText: "enter password...",
//                   hintText: "enter your password please.............",
//                   hintStyle: TextStyle(fontSize: 10),
//                   //  border: InputBorder.none, //&&&&&&&&&&&&&&&&&&&&&&&&&&border na rakhar jnno
//                   // OutlineInputBorder(borderRadius: BorderRadius.circular(15),
//                   // ),
//                   fillColor: Colors.white, //color(0xff00FFF)
//                   filled: true,
//                   enabled: true,
//                   focusColor: Colors.black,
//                   focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(width: 2, color: Colors.blue),
//                       borderRadius: BorderRadius.circular(20)),
//                   enabledBorder: OutlineInputBorder(
//                       borderSide: BorderSide(width: 2, color: Colors.blue),
//                       borderRadius: BorderRadius.circular(30)),
//                   disabledBorder: InputBorder.none,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   onPressed: onpress,
//                   //() {
//                   //   Navigator.push(
//                   //       // context, CupertinoPageRoute(builder: (context) => SecondPage()));
//                   //       context,
//                   //       // MaterialPageRoute(builder: (context) => SecondPage()));
//                   //       MaterialPageRoute(builder: (context) => miftah()));
//                   //},
//                   // onLongPress: (){
//                   //   Navigator.push(context, MaterialPageRoute(builder: (ctx)=>))
//                   // },
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         top: 8, right: 8, bottom: 8, left: 30),
//                     child: Text(
//                       "log in",
//                     ),
//                   ),
//                   style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(
//                           Colors.black.withOpacity(0.4)),
//                       foregroundColor: MaterialStateProperty.all(Colors.white),
//                       elevation: MaterialStateProperty.all(20),
//                       shadowColor: MaterialStateProperty.all(Colors.green),
//                       shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(50))))),
//                 ),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: ElevatedButton(
//                   onPressed: () {
//                     var t = getclr.text.toString();
//                     int c = int.parse(t);
//                     setState(() {
//                       clrs2 =
//                           Colors.red[c]; //jodi color name diye color korte chai
//                       //clrs2 = Color(c); //jodi digit diye korte chai 0xff diye digit dite hoi
//                     });
//                   },
//                   //() {
//                   //   Navigator.push(
//                   //       // context, CupertinoPageRoute(builder: (context) => SecondPage()));
//                   //       context,
//                   //       // MaterialPageRoute(builder: (context) => SecondPage()));
//                   //       MaterialPageRoute(builder: (context) => miftah()));
//                   //},
//                   // onLongPress: (){
//                   //   Navigator.push(context, MaterialPageRoute(builder: (ctx)=>))
//                   // },
//                   child: Padding(
//                     padding: const EdgeInsets.only(
//                         top: 8, right: 8, bottom: 8, left: 30),
//                     child: Text(
//                       "color",
//                     ),
//                   ),
//                   style: ButtonStyle(
//                       backgroundColor: MaterialStateProperty.all(
//                           Colors.black.withOpacity(0.4)),
//                       foregroundColor: MaterialStateProperty.all(Colors.white),
//                       elevation: MaterialStateProperty.all(20),
//                       shadowColor: MaterialStateProperty.all(Colors.green),
//                       shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.all(Radius.circular(50))))),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
