import 'package:flutter/material.dart';
import 'package:todo_bro/screens/todo_screen.dart';

void main() => runApp(App());

class App extends StatelessWidget
{
  Map<String,Widget Function(BuildContext)> routes = {
        "/home" : (BuildContext context){
          return TODOScreen();
        },
      };


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.blue,accentColor: Colors.amber),
      title: "TODO Bro",
      initialRoute: "/home",
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}