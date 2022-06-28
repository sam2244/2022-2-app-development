import 'package:fitween1/global/global.dart';
import 'package:fitween1/presenter/model/user.dart';
import 'package:fitween1/view/widget/text.dart';
import 'package:fitween1/global/palette.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddPlanPage2 extends StatefulWidget {
  const AddPlanPage2({Key? key}) : super(key: key);

  @override
  State<AddPlanPage2> createState() => _AddPlanPage2State();
}

class _AddPlanPage2State extends State<AddPlanPage2> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_GuestBookState');
  TextEditingController TrainerId = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  String gselectedValue = '0';
  String s1selectedValue1 = '1';
  String s2selectedValue1 = '1';
  String e1selectedValue1 = '1';
  String e2selectedValue1 = '1';
  bool diet = true;
  bool bulk = false;
  String purpose = 'diet';

  @override
  Widget build(BuildContext context) {
    final Size displaysize = MediaQuery
        .of(context)
        .size;

    FWTheme theme = FWTheme.primaryLight;

    return Scaffold(
      appBar: AppBar(
        title: FWText('기본 정보', size: 20.0, color: theme.color),
        backgroundColor: theme.backgroundColor,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: theme.color,
          iconSize: 25.0,
          onPressed: () {
            Get.back();
          },
        ),
        actions: <Widget>[
          TextButton(
              child: FWText('Done', size: 20.0, color: theme.color),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await addPlan(
                    purpose,
                    TrainerId.text,
                    height.text,
                    weight.text,
                    gselectedValue,
                    s1selectedValue1,
                    s2selectedValue1,
                    e1selectedValue1,
                    e2selectedValue1,
                  );
                  Get.toNamed('/main/trainee');
                }
              }),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20.0, left: 20.0),
                  child: FWText('목적', size: 20.0, color: theme.color)
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 20.0),
                      width: 170,
                      height: 40,
                      decoration: BoxDecoration(
                          color: diet ? theme.color : Palette.white,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(10)) //모서리를 둥글게
                      ),
                      child: TextButton(
                          child: FWText('다이어트', size: 20.0, color: diet ? Palette.white : theme.color,),
                          onPressed: () {
                            setState(() {
                              diet = true;
                              bulk = false;
                              purpose = '다이어트';
                            });
                          }),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 20.0),
                      width: 170,
                      height: 40,
                      decoration: BoxDecoration(
                          color: bulk ? theme.color : Palette.white,
                          borderRadius: const BorderRadius.all(
                              Radius.circular(10)) //모서리를 둥글게
                      ),
                      child: TextButton(
                          child: FWText('벌크업', size: 20.0, color: bulk ? Palette.white : theme.color,),
                          onPressed: () {
                            setState(() {
                              diet = false;
                              bulk = true;
                              purpose = '벌크업';
                            });
                          }),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                  child: FWText('담당 트레이너 정보', size: 20.0, color: theme.color)
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 5.0, left: 20.0, right: 20.0),
                  child: TextFormField(
                    controller: TrainerId,
                    decoration: const InputDecoration(
                      hintText: '담당 트레이너 아이디를 입력해주세요.',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '담당 트레이너 아이디를 다시 입력해주세요';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                  child: FWText('키', size: 20.0, color: theme.color)
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 5.0, left: 20.0, right: 20.0),
                  child: TextFormField(
                    controller: height,
                    decoration: const InputDecoration(
                      hintText: '현재 키를 입력해주세요.',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '현재 키를 다시 입력해주세요';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                  child: FWText('몸무게', size: 20.0, color: theme.color)
                ),
                Container(
                  margin: const EdgeInsets.only(
                      top: 5.0, left: 20.0, right: 20.0),
                  child: TextFormField(
                    controller: weight,
                    decoration: const InputDecoration(
                      hintText: '현재 몸무게를 입력해주세요.',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '몸무게를 다시 입력해주세요';
                      }
                      return null;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                      child: FWText('감량 목표', size: 20.0, color: theme.color)
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF0EEEE),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)) //모서리를 둥글게
                      ),
                      margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: DropdownButton<String>(
                        iconSize: 30.0,
                        value: gselectedValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            gselectedValue = newValue!;
                          });
                        },
                        items: <String>['0', '5', '10', '15', '20', '25', '30']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 30.0, left: 10.0),
                        child: FWText('kg', size: 20.0, color: theme.color),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                      child: FWText('트레이닝 시작일', size: 20.0, color: theme.color)
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF0EEEE),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)) //모서리를 둥글게
                      ),
                      margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: DropdownButton<String>(
                        iconSize: 30.0,
                        value: s1selectedValue1,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            s1selectedValue1 = newValue!;
                          });
                        },
                        items: <String>[
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '10',
                          '11',
                          '12',
                        ]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 30.0, left: 10.0),
                        child: FWText('월', size: 20.0, color: theme.color),
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF0EEEE),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)) //모서리를 둥글게
                      ),
                      margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: DropdownButton<String>(
                        iconSize: 30.0,
                        value: s2selectedValue1,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            s2selectedValue1 = newValue!;
                          });
                        },
                        items: <String>[
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '10',
                          '11',
                          '12',
                          '13',
                          '14',
                          '15',
                          '16',
                          '17',
                          '18',
                          '19',
                          '20',
                          '21',
                          '22',
                          '23',
                          '24',
                          '25',
                          '26',
                          '27',
                          '28',
                          '29',
                          '30',
                          '31',
                        ]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 30.0, left: 10.0),
                        child: FWText('일', size: 20.0, color: theme.color),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                      child: FWText('트레이닝 종료일', size: 20.0, color: theme.color)
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF0EEEE),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)) //모서리를 둥글게
                      ),
                      margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: DropdownButton<String>(
                        iconSize: 30.0,
                        value: e1selectedValue1,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            e1selectedValue1 = newValue!;
                          });
                        },
                        items: <String>[
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '10',
                          '11',
                          '12',
                        ]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 30.0, left: 10.0),
                        child: FWText('월', size: 20.0, color: theme.color),
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF0EEEE),
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)) //모서리를 둥글게
                      ),
                      margin: const EdgeInsets.only(top: 30.0, left: 20.0),
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                      child: DropdownButton<String>(
                        iconSize: 30.0,
                        value: e2selectedValue1,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.black),
                        onChanged: (String? newValue) {
                          setState(() {
                            e2selectedValue1 = newValue!;
                          });
                        },
                        items: <String>[
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '10',
                          '11',
                          '12',
                          '13',
                          '14',
                          '15',
                          '16',
                          '17',
                          '18',
                          '19',
                          '20',
                          '21',
                          '22',
                          '23',
                          '24',
                          '25',
                          '26',
                          '27',
                          '28',
                          '29',
                          '30',
                          '31',
                        ]
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 30.0, left: 10.0),
                        child: FWText('일', size: 20.0, color: theme.color),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future addPlan(String purpose, String TrainerId, String height, String weight, String goal, String s1selectedValue1, String s2selectedValue1, String e1selectedValue1, String e2selectedValue1) async {
    UserPresenter userPresenter = Get.find<UserPresenter>();

    await FirebaseFirestore.instance.collection("plans").add({
      "id": "",
      "state":"training",
      "trainerUid":TrainerId,
      "traineeUid": "",
      //"traineeUid": userPresenter.user.uid,
      "purpose": purpose,
      'weight': weight,
      'height': height,
      "goal" : goal,
      "start month": s1selectedValue1,
      "start day": s2selectedValue1,
      "end month": e1selectedValue1,
      "end day": e2selectedValue1,
      'regDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
    });
  }
}