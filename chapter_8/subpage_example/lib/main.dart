import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SubPage Example',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {'/': (context) => FirstPage(),
                '/second': (context) => SecondPage()},
    );
  }//Widget end
}//MyApp end


class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FirstPage();
}


class _FirstPage extends State<FirstPage> {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text('Sub Page Main'),
     ),
     body: Container(
       child: Center(
         child: Text('첫 번째 페이지'),
       ),
     ),
     floatingActionButton: FloatingActionButton(
       onPressed: (){
         Navigator.of(context)
             .pushNamed('/second');
       },//onpressed end
       child: Icon(Icons.add),
     ),
   );//Scaffold
  }//Widget build end,
}// _FirstPage end

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),

      body:Container(
      child: Center(
        child: ElevatedButton(
          onPressed: (){
            Navigator.of(context).pop(); //지금 페이지를 종료
          },//onpressed end
          child: Text('돌아가기'),
        ),
      ),
      ),
    );
  }
} //SecondPage end
