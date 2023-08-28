import 'package:second_app/first_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:second_app/third_page.dart';
import 'NewTaskWidget.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
      title: 'To Do List',
      initialRoute: '/first_page',
      routes: {
        '/first_page': (context) => secondApp(),
        '/NewTaskWidget': (context) => NewTaskWidget(),
        '/third_page':(context) => third_page(),
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (context) => NotFoundPage(),
        );
      },
    debugShowCheckedModeBanner: false,
      )
  );
}

class NotFoundPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Not Found")),
      body: Center(
        child: Text("Page Not Found"),
      ),
    );
  }
}
