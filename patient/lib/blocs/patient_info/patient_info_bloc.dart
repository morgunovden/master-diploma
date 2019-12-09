import 'dart:async';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:patient/blocs/auth/auth_bloc.dart';
import 'package:patient/blocs/auth/blocs.dart';
import 'package:patient/models/patient_info.dart';
import 'package:patient/repositories/patient_info/patient_info_repository.dart';
import 'blocs.dart';

class PatientInfoBloc extends Bloc<PatientInfoEvent, PatientInfoState> {
  final AuthBloc authBloc;
  final PatientInfoRepository patientInfoRepository;

  PatientInfoBloc({
    @required this.authBloc,
    @required this.patientInfoRepository,
  })
    : assert(authBloc != null),
    assert(patientInfoRepository != null);

  @override
  PatientInfoState get initialState => InitialPatientInfoState(step: 0, progress: 0.2);

  @override
  Stream<PatientInfoState> mapEventToState(
    PatientInfoEvent event,
  ) async* {
    if (event is InitialStep) {
      yield InitialPatientInfoState(step: 0, progress: 0.2);
    }
    if (event is StepOneDone) {
      yield StepOneDonePatientInfoState(step: 1, progress: 0.4,);
    }
    if (event is StepTwoDone) {
      yield StepTwoDonePatientInfoState(step: 2, progress: 0.6,);
    }
    if (event is StepThreeDone) {
      yield StepThreeDonePatientInfoState(step: 3, progress: 0.8,);
    }
    if (event is StepFourDone) {
      yield StepFourDonePatientInfoState(step: 4, progress: 1);
    }
    if (event is SaveInfoToDatabase) {
      try {
        PatientInfo patient = await this.patientInfoRepository.updateInfo(
          authBloc.state.token,
          authBloc.state.patinet_info,
          event.first_name,
          event.last_name,
          event.sex,
          event.birthday,
          event.weight,
          event.growth,
          event.diabetes_type,
        );
        yield FilledPatientInfoState(patientInfo: patient);
      } catch(error) {
        print(error);
        yield PatientUpdateFailure(error: error.toString());
      }
    }
  }
}
