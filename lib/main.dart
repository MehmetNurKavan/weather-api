import 'package:flutter/material.dart';
import 'package:havadurumu/screen/my_home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHome(),
      title: "How is the weather?",
      debugShowCheckedModeBanner: false,
    );
  }

}

