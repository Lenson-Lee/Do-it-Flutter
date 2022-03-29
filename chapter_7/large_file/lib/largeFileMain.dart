import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class LargeFileMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LargeFileMain();
}

class _LargeFileMain extends State<LargeFileMain> {
  bool downloading = false; //지금 내려받는 중인지 확인
  var progressString = ""; //현재 얼마나 내려받았는지 표시
  String file = ""; //내려받은 파일

  //내려받을 이미지 주소
  // final imgUrl =
  //     'https://images.pexels.com/photos/240040/pexels-photo-240040.jpeg'
  //     '?auto=compress';

  TextEditingController? _editingController;

  @override
  void initState() {
    super.initState();
    _editingController = new TextEditingController(
      text: 'https:images.pexels.com/photos/240040/pexels-photo-240040.jpeg'
          '?auto=compress');
  }

  Future<void> downloadFile() async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();
      await dio.download(_editingController!.value.text, '${dir.path}/myimage.jpg',
          onReceiveProgress: (rec, total) {
        print('Rec:$rec, Total: $total');
        file = '${dir.path}/myimage.jpg';
        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + '%';
        });
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = 'Completed';
    });
    print('Download completed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: InputDecoration(hintText: 'url을 입력하세요'),
        ),
      ),
      body: Center(
          child: downloading
              ? Container(
                  //downlad = true 일 때
                  height: 120.0,
                  width: 200.0,
                  child: Card(
                    color: Colors.black,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Downloading File: $progressString',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ) //Container(true) end


              : FutureBuilder(
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        print('none');
                        return Text('데이터 없음'); //downloading = false 일 때
                      case ConnectionState.waiting:
                        print('waiting');
                        return CircularProgressIndicator();
                      case ConnectionState.active:
                        print('active');
                        return CircularProgressIndicator();
                      case ConnectionState.done:
                        print('done');
                        if (snapshot.hasData) {
                          return snapshot.data as Widget;
                        } //if end
                    } //switch end
                    print('end process');
                    return Text('데이터 없음');
                  },
                  future: downloadWidget(file), //파일경로 존재시에 이미지 띄우기
                )), //center end


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          downloadFile();
        },
        child: Icon(Icons.file_download),
      ),
    ); //scaffold end
  } //build end


  Future<Widget>downloadWidget(String filePath) async {
    File file = File(filePath);
    bool exist = await file.exists();
    new FileImage(file).evict(); //캐시 초기화

    if(exist) { //file이 존재하면 true -> 이미지파일 위젯에 세로로 배치
      return Center(
        child: Column(
          children: <Widget>[Image.file(File(filePath))],
        ),
      );
    } else {
      return Text('No Data');
    }
  } //downloadWidget() end

}
