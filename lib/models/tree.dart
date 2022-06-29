// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Tree {
  final String name;
  Tree({
    required this.name,
  });

  Tree copyWith({
    String? name,
  }) {
    return Tree(
      name: name ?? this.name,
    );
  }

  factory Tree.fromJson(Map<String, dynamic> map) {
    return Tree(
      name: map['libellefrancais'] as String,
    );
  }
}
