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
      List<Tree> localTrees = await getTreesFromDd();
      if (localTrees.isEmpty) {
        List<Tree> trees = await apiService.getTreeList(startIndex);

        trees.forEach((tree) async {
          await addTreeInDatabase(tree);
        });

        _treeList.addAll(trees);
      } else {
        print('Yes j\'ai de la data');
        _treeList.addAll(localTrees);
      }

      notifyListeners();
      // wsAlreadyInProgress = false;
    } on Response catch (response) {
      print("Error: ${response.statusCode}");
      // wsAlreadyInProgress = false;
      rethrow;
    }
  }

  Future<List<Tree>> getTreesFromDd() async {
    final db = database;
    final List<Map<String, dynamic>> maps = await db.query('tree');

    return List.generate(maps.length, (index) {
      return Tree(id: maps[index]['id'], name: maps[index]['name'] ?? '');
    });
  }

  Future<void> addTreeInDatabase(Tree tree) async {
    final db = database;

    final Tree treeToAdd = Tree(id: tree.id, name: tree.name ?? '');

    db.insert("tree", treeToAdd.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

///////////////////////////////////////
// Functio to remove item from database
/////////////////////////////////////////

  // Future<void> removeTreeInDatabase(Tree treeToRemove) async {
  //   final db = await database;

  //   db.delete("tree", where: 'id = ?', whereArgs: [treeToRemove.id]);
  // }
}
