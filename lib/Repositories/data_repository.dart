import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tree_list/models/tree.dart';
import 'package:flutter_tree_list/services/api_service.dart';

class DataRepository with ChangeNotifier {
  final APIService apiService = APIService();
  final List<Tree> _treeList = [];
  int startIndex = 0;

  // Getters
  List<Tree> get treeList => _treeList;

  Future<void> getTrees() async {
    try {
      List<Tree> trees = await apiService.getTreeList(startIndex);
      _treeList.addAll(trees);
      notifyListeners();
    } on Response catch (response) {
      print("Error: ${response.statusCode}");
      rethrow;
    }
  }
}
