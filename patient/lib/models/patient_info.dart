import 'package:equatable/equatable.dart';

class PatientInfo extends Equatable {
  final int id;
  final String first_name;
  final String last_name;
  final String sex;
  final double weight;
  final double growth;
  final String birthday;
  final String doctor;

  const PatientInfo({
    this.id,
    this.first_name = '',
    this.last_name = '',
    this.sex = '',
    this.weight = 0,
    this.growth = 0,
    this.birthday = '',
    this.doctor = '',
  });

  @override
  List<Object> get props => [
    id,
    first_name,
    last_name,
    sex,
    weight,
    growth,
    birthday,
    doctor,
  ];

  static PatientInfo fromJson(dynamic json) {
    return PatientInfo(
      id: json['id'] as int,
      first_name: json['first_name'],
      last_name: json['last_name'],
      sex: json['sex'],
      weight: double.parse(json['weight'].toString()),
      growth: double.parse(json['growth'].toString()),
      birthday: json['birthday'],
      doctor: json['doctor'].toString(),
    );
  }
}
