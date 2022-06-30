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
          SizedBox(
            height: 200,
            child: NotificationListener<ScrollNotification>(
              // Method to check if the user has scroll 2/3 of the list
              // To load the next page
              onNotification: (ScrollNotification notification) {
                final currentPosition = notification.metrics.pixels;
                final maxPosition = notification.metrics.maxScrollExtent;
                if (currentPosition >= maxPosition * 2 / 3) {
                  print('test');
                }
                return true;
              },
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 50,
                        margin: const EdgeInsets.only(right: 8),
                        color: Colors.grey,
                        child: Center(
                          child: Text(dataProvider.treeList[index].name),
                        ));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
