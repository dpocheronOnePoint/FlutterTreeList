import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_tree_list/Repositories/data_repository.dart';
import 'package:flutter_tree_list/ui/screens/tree_list_screen.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    loadTrees();
  }

  void loadTrees() async {
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    await dataProvider.getTrees();

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const TreeListScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.center, children: const [
        SpinKitFadingCircle(
          color: Colors.white,
          size: 30,
        )
      ]),
    );
  }
}
