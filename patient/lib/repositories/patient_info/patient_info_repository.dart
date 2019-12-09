import 'package:meta/meta.dart';
import 'package:patient/models/patient_info.dart';
import 'package:patient/repositories/patient_info/patinet_info_api_client.dart';

class PatientInfoRepository {
  final PatientInfoAPiClient patientInfoAPiClient;

  PatientInfoRepository({@required this.patientInfoAPiClient})
      : assert(patientInfoAPiClient != null);

  Future<PatientInfo> updateInfo(
    String token,
    int id,
    String first_name,
    String last_name,
    String sex,
    String birthday,
    double weight,
    double growth,
    int diabetes_type,
  ) async {
    return await this.patientInfoAPiClient.updatePatientInfo(
      token: token,
      id: id,
      first_name: first_name,
      last_name: last_name,
      sex: sex,
      birthday: birthday,
      weight: weight,
      growth: growth,
      diabetes_type: diabetes_type,
    );
  }

  Future<PatientInfo> info({String token, String id}) async {
    return await this.patientInfoAPiClient.getInfo(token: token, id: id);
  }
}