import 'package:flutter/material.dart';
import 'package:flutter_tree_list/Repositories/data_repository.dart';
import 'package:flutter_tree_list/models/tree.dart';
import 'package:flutter_tree_list/services/api_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_tree_list/Repositories/data_repository.dart';
import 'package:provider/provider.dart';

class TreeListScreen extends StatefulWidget {
  const TreeListScreen({Key? key}) : super(key: key);

  @override
  State<TreeListScreen> createState() => _TreeListScreenState();
}

class _TreeListScreenState extends State<TreeListScreen> {
  @override
  void initState() {
    super.initState();
    getTrees();
  }

  void getTrees() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    await dataProvider.getTrees();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
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
            child: dataProvider.treeList.isEmpty
                ? const Center()
                : Text(
                    dataProvider.treeList[0].name,
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
