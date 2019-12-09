import 'package:meta/meta.dart';
import 'package:patient/models/models.dart';
import 'package:patient/repositories/category/category_api_client.dart';

class CategoryRepository {
  final CategoryApiClient categoryApiClient;

  CategoryRepository({
    @required this.categoryApiClient,
  });

  Future<List<Category>> list(
    String token,
  ) async {
    return await this.categoryApiClient.list(token);
  }

  Future<List<Drugs>> drugs(
    String token,
  ) async {
    return await this.categoryApiClient.drugs(token);
  }

  Future<List<Activity>> activities(
    String token,
  ) async {
    return await this.categoryApiClient.activities(token);
  }
}
