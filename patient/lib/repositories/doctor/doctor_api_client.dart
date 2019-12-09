import 'dart:io';
import 'package:patient/models/models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

class DoctorApiClient {
  static final baseUrl = DotEnv().env['BASE_URL'];
  final http.Client httpClient;

  DoctorApiClient({@required this.httpClient}) : assert(httpClient != null);

  Future<Doctor> update({@required dynamic record, @required String id, @required String token}) async {
    String url = '$baseUrl/doctor/$id';
    try {
      final response = await httpClient.put(
        url,
        body: jsonEncode(record),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        }
      );
      final data = jsonDecode(response.body);
      return Doctor.fromJson(data);
    } catch(error) {
      throw error;
    }
  }

  Future<List<PatientInfo>> patients({@required String id, @required String token}) async {
    String url = '$baseUrl/doctor/$id/patients';
    try {
      final response = await httpClient.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          'Authorization': 'Bearer $token',
        }
      );
      if (response.statusCode != 200) {
        throw HttpException('Something went wrong');
      }
      final data = jsonDecode(response.body);
      return data.map<PatientInfo>((item) {
        return PatientInfo.fromJson(item);
      }).toList();
    } catch(error) {
    }
  }

  Future<Doctor> doctor({String token, String id}) async {
    String url = '$baseUrl/doctor/$id';
    try {
      final response = await httpClient.get(
          url,
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
            'Authorization': 'Bearer $token',
          }
      );
      if (response.statusCode != 200) {
        throw HttpException('Something went wrong');
      }
      final data = jsonDecode(response.body);
      print(data);
      return Doctor.fromJson(data);
    } catch(error) {
      print('hello from here');
      throw error;
    }
  }
}
