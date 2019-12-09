import 'package:flutter/material.dart';
import 'package:patient/helpers/functions.dart';
import 'package:patient/models/diary.dart';
import 'package:patient/models/models.dart';
import 'package:patient/widgets/DIary/DiaryItem.dart';

class DiaryItemWrapper extends StatefulWidget {
  final List<Diary> diaryItems;
  final String date;

  DiaryItemWrapper({@required this.diaryItems, @required this.date});

  @override
  _DiaryItemWrapperState createState() => _DiaryItemWrapperState(date: date, diaryItems: diaryItems);
}

class _DiaryItemWrapperState extends State<DiaryItemWrapper> {
  final List<Diary> diaryItems;
  final String date;

  _DiaryItemWrapperState({@required this.diaryItems, @required this.date});

  String _getWeekDay(int number) {
    switch(number) {
      case 2:
        return 'Вт, ';
      case 3:
        return 'Ср, ';
      case 4:
        return 'Чт, ';
      case 5:
        return 'Пт, ';
      case 6:
        return 'Сб, ';
      case 7:
        return 'Нд, ';
      default:
        return 'Пн, ';
    }
  }

  List<DiaryItem> generateItems(List<Diary> items) {
    List<DiaryItem> tempList = [];
    items.forEach((item) {
      DateTime date = DateTime.parse(item.date);
      String time = '${_getWeekDay(date.weekday)} ${item.time}';

      DiaryItem tempItem = DiaryItem(
        id: item.id,
        time: time,
        category: item.category,
        carbohydrates: item.carbohydrates,
        glucose: item.glucose,
        bolus: item.bolus_count,
        basal: item.basal_count,
        notes: item.notes,
        drugs_bolus: item.drugs_bolus,
        drugs_basal: item.drugs_basal,
      );

      tempList.add(tempItem);
    });
    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    String glucoseAvg = (double.parse(diaryItems.map((item) => item.glucose).reduce((value, element) => (double.parse(value) + double.parse(element)).toString())) / diaryItems.length).toStringAsFixed(1);

    List<DiaryItem> _data = generateItems(diaryItems);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                date,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$glucoseAvg средний уровень с.к.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(31, 31, 31, 0.6),
                ),
              ),
            ],
          ),
        ),
        ..._data.map((item) {
          return ExpansionTile(
            key: PageStorageKey<String>(item.id),
            initiallyExpanded: true,
            title: Container(
              width: double.infinity,
              constraints: BoxConstraints(minHeight: 20),
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                color: Color.fromRGBO(31, 31, 31, 0.06),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                border: Border(
                  top: BorderSide(width: 1, color: Color.fromRGBO(31, 31, 31, 0.06)),
                  left: BorderSide(width: 1, color: Color.fromRGBO(31, 31, 31, 0.06)),
                  bottom: BorderSide(width: 1, color: Color.fromRGBO(31, 31, 31, 0.06)),
                  right: BorderSide(width: 1, color: Color.fromRGBO(31, 31, 31, 0.06)),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: <Widget>[
                        Text(
                          item.time,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 20,),
                        Text(
                          item.category,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(31, 31, 31, 0.6),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 60,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                      color: getColorFromGlucose(double.parse(item.glucose)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          item.glucose,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            trailing: IgnorePointer(
              child: null,
            ),
            children: <Widget>[
              item.carbohydrates != '0' ? Container(
                padding: EdgeInsets.only(left: 32, right: 15, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Углеводы',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(31, 31, 31, 0.6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${item.carbohydrates} грамм',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(89, 89, 89, 0.6),
                        ),
                      ),
                    )
                  ],
                ),
              ) : Container(),
              item.bolus != '0' ? Container(
                padding: EdgeInsets.only(left: 32, right: 15, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        item.drugs_bolus,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(31, 31, 31, 0.6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${item.bolus} ед.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(213, 162, 33, 0.6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ) : Container(),
              item.basal != '0' ? Container(
                padding: EdgeInsets.only(left: 32, right: 15, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        item.drugs_basal,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(31, 31, 31, 0.6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        '${item.basal} ед.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(213, 162, 33, 0.6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ) : Container(),
              item.notes.length > 0 ? Container(
                padding: EdgeInsets.only(left: 32, right: 15, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        'Примечания',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(31, 31, 31, 0.6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        item.notes,
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromRGBO(31, 31, 31, 0.6),
                        ),
                      ),
                    )
                  ],
                ),
              ) : Container(),
            ],
          );
        }).toList(),
      ],
    );
  }
}
