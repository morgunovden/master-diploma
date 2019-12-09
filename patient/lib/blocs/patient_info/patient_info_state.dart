import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:patient/models/patient_info.dart';

abstract class PatientInfoState extends Equatable {
  final int step;
  final double progress;

  const PatientInfoState({this.step, this.progress});

  @override
  List<Object> get props => [];

  PatientInfo get patient => null;
}

class InitialPatientInfoState extends PatientInfoState {
  final int step;
  final double progress;

  const InitialPatientInfoState({this.step, this.progress});

  @override
  List<Object> get props => [step, progress];
}

class StepOneDonePatientInfoState extends PatientInfoState {
  final int step;
  final double progress;

  const StepOneDonePatientInfoState({
    @required this.step,
    @required this.progress,
  });

  @override
  List<Object> get props => [step, progress];
}

class StepTwoDonePatientInfoState extends PatientInfoState {
  final int step;
  final double progress;

  const StepTwoDonePatientInfoState({
    @required this.step,
    @required this.progress,
  });

  @override
  List<Object> get props => [step, progress];
}

class StepThreeDonePatientInfoState extends PatientInfoState {
  final int step;
  final double progress;

  const StepThreeDonePatientInfoState({
    @required this.step,
    @required this.progress,
  });

  @override
  List<Object> get props => [step, progress];
}

class StepFourDonePatientInfoState extends PatientInfoState {
  final int step;
  final double progress;

  const StepFourDonePatientInfoState({
    @required this.step,
    @required this.progress,
  });

  @override
  List<Object> get props => [step, progress];
}

class FilledPatientInfoState extends PatientInfoState {
  final PatientInfo patientInfo;
  final step = 4;
  final progress = 1;

  FilledPatientInfoState({@required this.patientInfo}) : assert(patientInfo != null);

  @override
  List<Object> get props => [patientInfo];

  @override
  PatientInfo get patient => patientInfo;
}

class PatientUpdateFailure extends PatientInfoState {
  final String error;
  final step = 4;
  final progress = 1;

  const PatientUpdateFailure({@required this.error});

  @override
  List<Object> get props => [error];
}
