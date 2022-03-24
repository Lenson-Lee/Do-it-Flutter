import 'package:flutter/material.dart';
import 'package:listview_example/animalItem.dart';



class SecondApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SecondApp();
  List<Animal>? list;

  SecondApp({Key? key, @required this.list}) : super(key: key);
}

class _SecondApp extends State<SecondApp> {
  final nameController = TextEditingController();
  int? _radioValue = 0;
  bool? flyExist = false;
  String? _imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: nameController,
            keyboardType: TextInputType.text,
            maxLines: 1,
          ),
          Row(
            children: <Widget>[
              Radio(value: 0, groupValue: _radioValue, onChanged: _radioChange),
              Text('양서류'),
              Radio(value: 1, groupValue: _radioValue, onChanged: _radioChange),
              Text('파충류'),
              Radio(value: 2, groupValue: _radioValue, onChanged: _radioChange),
              Text('포유류'),
            ],
          ),
          Row(
            children: <Widget>[
              Text('날 수 있나요?'),
              Checkbox(
                  value: flyExist,
                  onChanged: (bool? check) {
                    setState(() {
                      flyExist = check;
                    });
                  })
            ],
          ),
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,

              children: <Widget>[
                GestureDetector(
                  child: Image.asset(
                    'repo/images/cow.png',
                    width: 80,
                  ),
                  onTap: () {
                    _imagePath = 'repo/images/cow.png';

                  },

                ),
                GestureDetector(
                  child: Image.asset(
                    'repo/images/pig.png',
                    width: 80,
                  ),
                  onTap: () {
                    _imagePath = 'repo/images/pig.png';
                  },
                ),
                GestureDetector(
                  child: Image.asset(
                    'repo/images/bee.png',
                    width: 80,
                  ),
                  onTap: () {
                    _imagePath = 'repo/images/bee.png';
                  },
                ),
                GestureDetector(
                  child: Image.asset(
                    'repo/images/cat.png',
                    width: 80,
                  ),
                  onTap: () {
                    _imagePath = 'repo/images/cat.png';
                  },
                ),
                GestureDetector(
                  child: Image.asset(
                    'repo/images/dog.png',
                    width: 80,
                  ),
                  onTap: () {
                    _imagePath = 'repo/images/dog.png';
                  },
                ),
                GestureDetector(
                  child: Image.asset(
                    'repo/images/fox.png',
                    width: 80,
                  ),
                  onTap: () {
                    _imagePath = 'repo/images/fox.png';
                  },
                ),
                GestureDetector(
                  child: Image.asset(
                    'repo/images/monkey.png',
                    width: 80,
                  ),
                  onTap: () {
                    _imagePath = 'repo/images/monkey.png';
                  },
                ),
              ],
              // mainAxisAlignment: MainAxisAlignment.spaceAround
            ),
          ),
          ElevatedButton(
              child: Text('동물 추가하기'),
              onPressed: () {
                var animal = Animal(
                    animalName: nameController.value.text,
                    kind: getKind(_radioValue),
                    imagePath: _imagePath,
                    flyExist: flyExist,
                    fly: getFly(flyExist)
                );
                AlertDialog dialog = AlertDialog(
                  title: Text('동물 추가하기'),
                  content: Text(
                    '이 동물은 ${animal.fly} ${animal.animalName}이며\n종류는 ${animal.kind} 입니다.'
                    '\n이 동물을 추가하시겠습니까?',
                    style: TextStyle(fontSize: 24.0),
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        widget.list?.add(animal);
                        Navigator.of(context).pop();
                      },
                      child: Text('예'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('아니요'),
                    ),
                  ],
                );
                showDialog(
                    context: context,
                    builder: (BuildContext context) => dialog);
              })
        ],
      )),
    );
  }

  _radioChange(int? value) {
    setState(() {
      _radioValue = value;
    });
  } //_radioChange end

  getKind(int? radioValue) {
    switch (radioValue) {
      case 0:
        return "양서류";
      case 1:
        return "파충류";
      case 2:
        return "포유류";
    }
  }

  getFly(bool? flyExist) {
    if (flyExist == true) {
      return "날 수 있는";
    } else {
      return "날 수 없는";
    }
  }
}
