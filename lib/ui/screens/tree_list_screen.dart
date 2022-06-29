import 'package:flutter/material.dart';
import 'package:flutter_tree_list/models/tree.dart';
import 'package:flutter_tree_list/services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';

class TreeListScreen extends StatefulWidget {
  const TreeListScreen({Key? key}) : super(key: key);

  @override
  State<TreeListScreen> createState() => _TreeListScreenState();
}

class _TreeListScreenState extends State<TreeListScreen> {
  List<Tree>? trees;

  @override
  void initState() {
    super.initState();
    getTrees();
  }

  void getTrees() {
    APIService().getTreeList(0).then((treeList) {
      setState(() {
        trees = treeList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Liste des arbres'),
      ),
      body: ListView(
        children: [
          Container(
            height: 500,
            color: Colors.red,
            child: trees == null
                ? const Center()
                : Text(
                    trees![0].name,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
          ),
        ],
      ),
    );
  }
}
