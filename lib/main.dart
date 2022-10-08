import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopapp/visible/pages/authentication/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MaterialApp(
    home: Launcher(),
  ));
}

class Launcher extends StatefulWidget {
  const Launcher({Key? key}) : super(key: key);

  @override
  _LauncherState createState() => _LauncherState();
}

class _LauncherState extends State<Launcher> {
  @override
  Widget build(BuildContext context){
   return const Login();
  }
}


