import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patient/blocs/diary/bloc.dart';
import 'package:patient/widgets/CommonButton.dart';
import 'package:patient/widgets/DIary/CreateRecordRequired.dart';

class CreateDiaryRecord extends StatefulWidget {
  @override
  _CreateDiaryRecordState createState() => _CreateDiaryRecordState();
}

class _CreateDiaryRecordState extends State<CreateDiaryRecord> {
  static final _form = GlobalKey<FormState>();
  var _data = {
    'date': '',
    'time': '',
    'glucose': '',
    'carbohydrates': '',
    'bolus_count': '',
    'basal_count': '',
    'notes': '',
    'category': '',
    'drugs_bolus': '',
    'drugs_basal': '',
  };

  _callback(String name, String value) {
    if (name == 'time') {
      List<String> tempDateArray = _data['date'].split('T');
      _data['date'] = '${tempDateArray[0]}T$value:00';
    }
    _data[name] = value;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          elevation: 0,
          titleSpacing: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          automaticallyImplyLeading: false,
          title: FlatButton.icon(
            label: Text(
              'Назад',
              style: TextStyle(
                color: Color.fromRGBO(31, 31, 31, 0.6),
                fontSize: 16,
              ),
            ),
            icon: Icon(
              Icons.arrow_back,
              color: Color.fromRGBO(31, 31, 31, 0.6),
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Color.fromRGBO(31, 31, 31, 0.3),
            labelStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w400,
            ),
            labelColor: Theme.of(context).primaryColor,
            tabs: <Widget>[
              Tab(
                text: 'Основные',
              ),
              Tab(
                text: 'Дополнительно',
              ),
            ],
          ),
        ),
        body: Form(
          key: _form,
          child: BlocBuilder<DiaryBloc, DiaryState>(
            builder: (context, state) {
              _createRecord() {
                if (!_form.currentState.validate()) {
                  return;
                }
                _form.currentState.save();
                BlocProvider.of<DiaryBloc>(context).add(
                  CreateDiaryRecordEvent(record: jsonEncode(_data)),
                );
              }

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: SingleChildScrollView(
                            child: CreateRecordRequired(callback: _callback,),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(15),
                    child: CommonButton(
                      onPressed: _createRecord,
                      text: 'Добавить запись',
                      isPrimaryFilled: true,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
