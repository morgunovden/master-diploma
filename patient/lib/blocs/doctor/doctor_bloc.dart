import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:patient/blocs/auth/auth_bloc.dart';
import 'package:patient/models/models.dart';
import 'package:patient/repositories/doctor/repositories.dart';
import 'package:patient/repositories/patient_info/repositories.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final DoctorRepository _doctorRepository = DoctorRepository(doctorApiClient: DoctorApiClient(httpClient: http.Client()));
  final PatientInfoRepository patientInfoRepository = PatientInfoRepository(patientInfoAPiClient: PatientInfoAPiClient(httpClient: http.Client()));
  AuthBloc authBloc;

  DoctorBloc({this.authBloc});

  @override
  DoctorState get initialState => InitialDoctorState();

  @override
  Stream<DoctorState> mapEventToState(
    DoctorEvent event,
  ) async* {
    if (event is FetchDoctor) {
      try {
        PatientInfo patient = await patientInfoRepository.info(token: authBloc.state.token, id: authBloc.state.patinet_info.toString());
        Doctor doctor = await _doctorRepository.doctor(token: authBloc.state.token, id: patient.doctor);

        yield DoctorFetched(doctor: doctor);
      } catch(error) {
        print(error);
        yield DoctorFailure(error: error.toString());
      }
    }
  }
}
