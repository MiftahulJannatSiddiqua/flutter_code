import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class DeleteAndUpdate extends StatefulWidget {
  @override
  State<DeleteAndUpdate> createState() => _DeleteAndUpdateState();
}

class _DeleteAndUpdateState extends State<DeleteAndUpdate> {
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
        .add({"name": name, "age": age, "address": address, "gender": gender})
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
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: "name"),
              controller: username,
            ),
            TextField(
              decoration: InputDecoration(labelText: "age"),
              controller: userage,
            ),
            TextField(
              decoration: InputDecoration(labelText: "gender"),
              controller: usergender,
            ),
            TextField(
              decoration: InputDecoration(labelText: "address"),
              controller: useraddress,
            ),
            ElevatedButton(onPressed: _adduser, child: Text("add")),
            StreamBuilder(
                stream: _stream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("data is not found");
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return Container(
                    height: 400,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          snapshot.data!.docs.forEach((element) {
                            iddoc = element.id;
                          });
                          return Container(
                            height: 100,
                            width: double.maxFinite,
                            child: Card(
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
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              editId =
                                                  snapshot.data!.docs[index].id;
                                            });
                                            user
                                                .doc(editId)
                                                .delete()
                                                .then((value) =>
                                                    Text("succecfully deleted"))
                                                .onError((error, stackTrace) =>
                                                    Text("$error"));
                                          },
                                          child: Text("Delete")),
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              editId =
                                                  snapshot.data!.docs[index].id;
                                            });
                                            // snapshot.data!.docs[editId].["Age"]
                                            var s = user.doc(editId).get().then(
                                                (value) => {
                                                      uname = value["name"],
                                                      value["age"],
                                                      value["gender"],
                                                      value["address"],
                                                    }
                                                //  print(
                                                //     "Hell ${value["Name"]}")
                                                );
                                            print(s);

                                            username.text = snapshot
                                                .data!.docs[index]["name"];
                                            userage.text = snapshot
                                                .data!.docs[index]["age"];
                                            useraddress.text = snapshot
                                                .data!.docs[index]["address"];
                                            usergender.text = snapshot
                                                .data!.docs[index]["gender"];
                                          },
                                          child: Text("Edit")),
                                      ElevatedButton(
                                        onPressed: () {
                                          user.doc(editId).update({
                                            "age": userage.text,
                                            "name": username.text,
                                            "gender": usergender.text,
                                            "address": useraddress.text
                                          });
                                        },

                                        // users.doc("1uhq3YJvwvqXFbRg6rbS").set({
                                        //   "Gender": "female",
                                        //   "Name": "Akash",
                                        //   "Age": userupdate.text,
                                        // });
                                        // },
                                        child: Text("Update"),
                                      ),
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
                                  Text(snapshot.data!.docs[index]["name"]),
                                  Text(snapshot.data!.docs[index]["age"]),
                                  Text(snapshot.data!.docs[index]["gender"]),
                                  Text(snapshot.data!.docs[index]["address"]),
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
          ],
        ),
      ),
    );
  }
}
