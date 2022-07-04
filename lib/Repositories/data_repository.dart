import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tree_list/models/tree.dart';
import 'package:flutter_tree_list/services/api_service.dart';
import 'package:sqflite/sqlite_api.dart';

class DataRepository with ChangeNotifier {
  final APIService apiService = APIService();
  final List<Tree> _treeList = [];
  int startIndex = 0;

  // bool wsAlreadyInProgress = false;

  // Getters
  List<Tree> get treeList => _treeList;

  final Database database;

  DataRepository({required this.database});

  Future<void> getTrees() async {
    try {
      // List<Tree> trees = await apiService.getTreeList(startIndex);
      await addTreeInDatabase();

      List<Tree> trees = await getTreesFromDd();
      _treeList.addAll(trees);
      print(treeList.length);
      notifyListeners();
      // wsAlreadyInProgress = false;
    } on Response catch (response) {
      print("Error: ${response.statusCode}");
      // wsAlreadyInProgress = false;
      rethrow;
    }
  }

  Future<List<Tree>> getTreesFromDd() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tree');

    return List.generate(maps.length, (index) {
      return Tree(id: maps[index]['id'], name: maps[index]['name'] ?? '');
    });
  }

  Future<void> addTreeInDatabase() async {
    final db = await database;

    final Tree treeToAdd = Tree(id: 0, name: "Blood");

    db.insert("tree", treeToAdd.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeTreeInDatabase(Tree treeToRemove) async {
    final db = await database;

    db.delete("tree", where: 'id = ?', whereArgs: [treeToRemove.id]);
  }
}
