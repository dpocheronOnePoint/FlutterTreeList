import 'package:flutter/material.dart';
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

    // This boolean is use to hack the fatsly WS refresh
    bool needCall = true;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Liste des arbres'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: NotificationListener<ScrollNotification>(
              // Method to check if the user has scroll 2/3 of the list
              // To load the next page
              onNotification: (ScrollNotification notification) {
                final currentPosition = notification.metrics.pixels;
                final bottomPosition = notification.metrics.extentAfter;
                // print(maxPosition);
                if (bottomPosition < 500) {
                  if (dataProvider.treeList.length > dataProvider.startIndex) {
                    if (needCall) {
                      needCall = false;
                      dataProvider.startIndex += 20;
                      dataProvider.getTrees();
                    } else {
                      needCall = true;
                    }
                  }

                  // if (!dataProvider.wsAlreadyInProgress && needToCall) {
                  //   print("WS Call !!");
                  //   dataProvider.wsAlreadyInProgress = true;
                  //   dataProvider.getTrees();
                  //   needToCall = false;
                  // } else {
                  //   needToCall = true;
                  // }
                }
                return true;
              },
              child: ListView.builder(
                  itemCount: dataProvider.treeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: 150,
                        margin: const EdgeInsets.only(right: 8),
                        color: Colors.grey,
                        child: Center(
                          child: Text(dataProvider.treeList[index].name ?? ""),
                        ));
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
