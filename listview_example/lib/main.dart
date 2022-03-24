import 'package:flutter/material.dart';

import 'sub/firstPage.dart';
import 'sub/secondPage.dart';
import 'animalItem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  TabController? controller;
  List<Animal> animalList = new List.empty(growable: true);

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);

    animalList.add(Animal(animalName: "벌", kind: "곤충", imagePath: "repo/images/bee.png", fly: "날 수 있음"));
    animalList.add(Animal(animalName: "고양이", kind: "포유류", imagePath: "repo/images/cat.png", fly: "날 수 없는"));
    animalList.add(Animal(animalName: "젖소",kind: "포유류", imagePath: "repo/images/cow.png", fly: "날 수 없는"));
    animalList.add(Animal(animalName: "강아지", kind: "포유류", imagePath: "repo/images/dog.png", fly: "날 수 없는"));
    animalList.add(Animal(animalName: "여우", kind: "포유류", imagePath: "repo/images/fox.png", fly: "날 수 없는"));
    animalList.add(Animal(animalName: "원숭이", kind: "포유류", imagePath: "repo/images/monkey.png", fly: "날 수 없는"));
    animalList.add(Animal(animalName: "돼지", kind: "포유류", imagePath: "repo/images/pig.png", fly: "날 수 없는"));
    animalList.add(Animal(animalName: "늑대", kind: "포유류F", imagePath: "repo/images/wolf.png", fly: "날 수 없는"));

  } //initState end

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('동물 정보 카드'),
      ),
      body: TabBarView(
        children: <Widget>[
          FirstApp(
            list: animalList,
          ),
          SecondApp(
            list: animalList,
          )
        ],
        controller: controller,
      ),
      bottomNavigationBar: TabBar( tabs: <Tab>[
        Tab(icon: Icon(Icons.looks_one, color: Colors.blue),),
        Tab(icon: Icon(Icons.looks_two, color: Colors.blue),)
      ], controller: controller,

      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
} // _MyHomePageState
