import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class PatientInfoEvent extends Equatable {
  const PatientInfoEvent();

  @override
  List<Object> get props => [];
}

class InitialStep extends PatientInfoEvent {}

class StepOneDone extends PatientInfoEvent {}

class StepTwoDone extends PatientInfoEvent {}

class StepThreeDone extends PatientInfoEvent {}

class StepFourDone extends PatientInfoEvent {}

class SaveInfoToDatabase extends PatientInfoEvent {
  final String first_name;
  final String last_name;
  final String sex;
  final double weight;
  final double growth;
  final String birthday;
  final int diabetes_type;

  const SaveInfoToDatabase({
    @required this.first_name,
    @required this.last_name,
    @required this.sex,
    @required this.weight,
    @required this.growth,
    @required this.birthday,
    @required this.diabetes_type,
  });

  @override
  List<Object> get props => [
    first_name,
    last_name,
    sex,
    weight,
    growth,
    birthday,
    diabetes_type,
  ];
}
