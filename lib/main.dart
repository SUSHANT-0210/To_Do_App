import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/page/home_page.dart';
import 'package:to_do_app/provider/todos.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);
  static const String title = 'To_Do_App';

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => TodosProvider(),
        child: MaterialApp(
          title: title,
          theme: ThemeData(
            scaffoldBackgroundColor: Color(0xFFf6f5ee),
            primarySwatch: Colors.pink,
          ),
          home: HomePage(),
        ),
      );
}
