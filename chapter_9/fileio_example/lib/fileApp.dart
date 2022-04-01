import 'package:flutter/material.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FileApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FileApp();
}

class _FileApp extends State<FileApp> {
  int _count = 0;
  List<String> itemList = new List.empty(growable: true);
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    readCountFile();
    initData();
  } //initState end

  //initState에 async 못써서 만들었다.
  void initData() async {
    var result = await readListFile();
    setState(() {
      itemList.addAll(result);
    });
  }

  //과일 파일 리스트로 바꾸기
  Future<List<String>> readListFile() async {
    List<String> itemList = new List.empty(growable: true);
    var key = 'first';
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool? firstCheck = pref.getBool(key); // 파일을 처음 열었거나 있/없 구분

    var dir = await getApplicationDocumentsDirectory(); //
    bool fileExist =
        await File(dir.path + '/fruit.txt').exists(); //해당 파일이 존재하면 참

    if (firstCheck == null || firstCheck == false || fileExist == false) {
      //파일이 없거나 처음 열었을 경우 공유환경설정에 true 저장 -> 파일을 연 것으로 기록, 같은 파일생성
      pref.setBool(key, true);
      var file =
          await DefaultAssetBundle.of(context).loadString('repo/fruit.txt');
      File(dir.path + '/fruit.txt').writeAsStringSync(file);

      var array = file.split('\n');
      for (var item in array) {
        print(item);
        itemList.add(item);
      }
      return itemList;
    } else {
      //파일을 처음 연 게 아닌 경우
      var file = await File(dir.path + '/fruit.txt').readAsString();
      var array = file.split('\n');
      for (var item in array) {
        print(item);
        itemList.add(item);
      }
      return itemList;
    }
  }//readListFile

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Example!'),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: controller,
                keyboardType: TextInputType.text,
              ),
              Expanded(
                  child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: Center(
                        child: Text(
                      itemList[index],
                      style: TextStyle(fontSize: 30),
                    )),
                  );
                }, //itemBuilder
                itemCount: itemList.length,
              ))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          writeFruit(controller.value.text);
          setState(() {
            itemList.add(controller.value.text);
          });
        },
        child: Icon(Icons.print),
      ),
    );
  } // build

  void writeCountFile(int count) async {
    var dir = await getApplicationDocumentsDirectory();
    File(dir.path + '/count.txt').writeAsStringSync(count.toString());
  }

  void readCountFile() async {
    try {
      var dir = await getApplicationDocumentsDirectory();
      var file = await File(dir.path + '/count.txt').readAsString();
      print(file);
      setState(() {
        _count = int.parse(file);
      }); //setState
    } catch (e) {
      print(e.toString());
    }
  } //readCountFile end

  //과일 입력 창
  void writeFruit(String fruit) async {
    var dir = await getApplicationDocumentsDirectory();
    var file = await File(dir.path + '/fruit.txt').readAsString();
    file = file + '\n' + fruit;
    File(dir.path + '/fruit.txt').writeAsStringSync(file);
  }
}
