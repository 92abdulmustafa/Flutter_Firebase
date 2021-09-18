import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Registeration extends StatefulWidget {
  const Registeration({Key? key}) : super(key: key);

  @override
  _RegisterationState createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController usernamecontroller = TextEditingController();
    final TextEditingController emailcontroller = TextEditingController();
    final TextEditingController passwordcontroller = TextEditingController();

    void register() async {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      // ignore: unused_local_variable
      final String username = usernamecontroller.text;
      final String email = emailcontroller.text;
      final String password = passwordcontroller.text;
      try {
        final UserCredential user = await auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await firestore.collection("users").doc(user.user.uid).set({"email": email,"username": username});
        print("user is registered");
      } catch (e) {}
      print("error");
    }

    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Registeration")),
          backgroundColor: Colors.teal[200],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10, top: 60),
                child: Center(
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: usernamecontroller,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter your Username',
                        icon: Icon(
                          Icons.account_circle_sharp,
                          color: Colors.teal,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
                child: Center(
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: emailcontroller,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Enter your Email',
                        icon: Icon(
                          Icons.email,
                          color: Colors.teal,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
                child: Center(
                  child: SizedBox(
                    width: 350,
                    child: TextFormField(
                        controller: passwordcontroller,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter your Password',
                          icon: Icon(
                            Icons.password,
                            color: Colors.teal,
                            size: 40,
                          ),
                        )),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  height: 55,
                  width: 130,
                  child: ElevatedButton(
                    onPressed: register,
                    child: const Text("Register"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey,
                      side:
                          const BorderSide(width: 2, color: Colors.blueAccent),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
