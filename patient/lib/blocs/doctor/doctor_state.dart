import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:patient/models/models.dart';

abstract class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object> get props => throw UnimplementedError();
}

class InitialDoctorState extends DoctorState {
  @override
  List<Object> get props => [];
}

class DoctorFetched extends DoctorState {
  final Doctor doctor;

  DoctorFetched({this.doctor});
}

class DoctorFailure extends DoctorState {
  final String error;

  const DoctorFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
