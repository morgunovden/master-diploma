import 'dart:math';
import 'dart:ui';

import 'package:patient/models/models.dart';

Color getColorFromGlucose(double glucose) {
  return glucose < 4 ? Color.fromRGBO(124, 85, 237, 1) : glucose >= 4 && glucose < 5
      ? Color.fromRGBO(85, 194, 255, 1) : glucose >= 8.5 && glucose < 11
      ? Color.fromRGBO(249, 187, 30, 1) : glucose >= 11
      ? Color.fromRGBO(242, 60, 60, 1) : Color.fromRGBO(9, 202, 109, 1);
}

String getWeekDay(int number) {
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

String generateParamsString (params) {
  return params.map((param) {
    return '${param['name']}=${param['value']}';
  }).join('&');
}

String calculateA1c(glucoseAvg) {
  return ((2.59 + glucoseAvg) / 1.59).toStringAsFixed(1);
}

String getA1cTitle(a1c) {
  return a1c < 5 || a1c > 7.5 ? 'Все плохо' : 'Всё хорошо';
}

String getA1cSubTitle(a1c) {
  return a1c < 5 || a1c > 7.5 ? 'Нужно лучше контролировать уровень сахара в крови!' : 'Вы отлично справляетесь!';
}

double calculateStandartDeviation(List<Diary> records) {
  double avg = double.parse(records.map((item) => item.glucose).reduce((value, element) => (double.parse(value) + double.parse(element)).toString())) / records.length;
  double difference = records.map<double>((item) => pow(double.parse(item.glucose) - avg, 2)).reduce((accum, value) => accum + value);
  return sqrt((difference / (records.length - 1)));
}

double calculateTIR(List<Diary> records) {
  int counter = 0;
  records.forEach((record) {
    if (double.parse(record.glucose) <= 9.99 && double.parse(record.glucose) >= 3.88) {
      counter++;
    }
  });
  return counter / records.length * 100;
}
