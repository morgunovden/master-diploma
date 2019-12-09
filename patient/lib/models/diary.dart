import 'dart:convert';

import 'package:equatable/equatable.dart';

class Diary{
  String id;
  String date;
  String time;
  String glucose;
  String carbohydrates;
  String bolus_count;
  String basal_count;
  String notes;

  String category;
  String drugs_bolus;
  String drugs_basal;

  Diary({
    this.id = '',
    this.date = '',
    this.time = '',
    this.glucose = '',
    this.carbohydrates = '',
    this.bolus_count = '',
    this.basal_count = '',
    this.notes = '',
    this.category = '',
    this.drugs_bolus = '',
    this.drugs_basal = '',
  });

  static Diary fromJson(dynamic json) {
    return Diary(
      id: json['id'].toString(),
      date: json['date'].toString(),
      time: json['time'],
      glucose: json['glucose'].toString(),
      carbohydrates: json['carbohydrates'].toString(),
      bolus_count: json['bolus_count'].toString(),
      basal_count: json['basal_count'].toString(),
      notes: json['notes'],
      category: json['category']['name'],
      drugs_bolus: json['drugs_bolus']['name'],
      drugs_basal: json['drugs_basal']['name'],
    );
  }

  static String toJson(Diary record) {
    return json.encode({
      'date': record.date,
      'time': record.time,
      'glucose': record.glucose,
      'carbohydrates': record.carbohydrates,
      'bolus_count': record.bolus_count,
      'basal_count': record.basal_count,
      'notes': record.notes,
      'category': record.category,
      'drugs_bolus': record.drugs_bolus,
      'drugs_basal': record.drugs_basal,
    });
  }
}
