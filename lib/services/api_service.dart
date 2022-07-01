import 'package:dio/dio.dart';
import 'package:flutter_tree_list/models/record_data.dart';
import 'package:flutter_tree_list/models/tree.dart';
import 'package:flutter_tree_list/services/api_url.dart';

class APIService {
  final API_URL apiUrl = API_URL();
  final Dio dio = Dio();

  Future<List<Tree>> getTreeList(int startIndex) async {
    String url = apiUrl.baseURL + apiUrl.searchPath;

    // Global params for all request
    Map<String, dynamic> queryParameters = {
      'dataset': 'les-arbres',
      'start': startIndex,
      'rows': '20'
    };

    final response = await dio.get(url, queryParameters: queryParameters);

    if (response.statusCode == 200) {
      Map data = response.data;
      List<dynamic> results = data['records'];
      List<Tree> trees = [];
      for (Map<String, dynamic> json in results) {
        RecordData recordData = RecordData.fromJson(json);
        trees.add(recordData.fields);
      }
      return trees;
    } else {
      throw response;
    }
  }
}
