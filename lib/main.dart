// ignore_for_file: avoid_print
import 'package:firebase_class/Home.dart';
import 'package:firebase_class/Login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              bottomNavigationBar: SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 0),
                  child: BottomAppBar(
                    shape: const CircularNotchedRectangle(),
                    color: Colors.teal,
                    child: IconTheme(
                      data: const IconThemeData(color: Colors.black26),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          IconButton(
                            hoverColor: Colors.white60,
                            tooltip: 'Home Page',
                            icon: const Icon(
                              Icons.home,
                              size: 40,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Registeration()));
                            },
                          ),
                          IconButton(
                            hoverColor: Colors.white60,
                            tooltip: 'Login page',
                            icon: const Icon(
                              Icons.login_rounded,
                              size: 40,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Login()));
                            },
                          ),
                          // IconButton(
                          //     tooltip: 'Favorite',
                          //     icon: const Icon(Icons.pos),
                          //     onPressed: () {},
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              body: const Registeration(),
            ),
          );
        }
        // Check for errors
        if (snapshot.hasError) {
          print(snapshot.error);
          return Container(
            width: 300,
            height: 200,
            color: Colors.blue,
            child: Text('${snapshot.error}'),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          width: 300,
          height: 200,
          color: Colors.cyan,
        );
      },
    );
  }
}
