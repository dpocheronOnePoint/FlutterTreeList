// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_tree_list/models/tree.dart';

class RecordData {
  final Tree fields;
  RecordData({
    required this.fields,
  });

  RecordData copyWith({
    Tree? fields,
  }) {
    return RecordData(
      fields: fields ?? this.fields,
    );
  }

  factory RecordData.fromJson(Map<String, dynamic> map) {
    return RecordData(
      fields: Tree.fromJson(map['fields'] as Map<String, dynamic>),
    );
  }
}
