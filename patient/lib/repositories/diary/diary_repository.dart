import 'package:meta/meta.dart';
import 'package:patient/models/models.dart';
import 'package:patient/repositories/diary/diary_api_client.dart';

class DiaryRepository {
  final DiaryApiClient diaryApiClient;

  DiaryRepository({@required this.diaryApiClient});

  Future<List<Diary>> fetch({@required String token, var params = const []}) async {
    return await this.diaryApiClient.fetchDiaryRecords(token: token, params: params);
  }

  Future<void> create({@required String token, @required String record}) async {
    return await this.diaryApiClient.create(token: token, record: record);
  }
}
