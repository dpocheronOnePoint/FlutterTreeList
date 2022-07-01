// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Tree {
  final int id;
  final String? name;
  Tree({
    required this.id,
    this.name,
  });

  Tree copyWith({
    String? name,
  }) {
    return Tree(
      id: id,
      name: name ?? this.name,
    );
  }

  factory Tree.fromJson(Map<String, dynamic> map) {
    return Tree(
      id: map['idbase'] as int,
      name: map['libellefrancais'] != null
          ? map['libellefrancais'] as String
          : null,
    );
  }

  // Convert a Tree into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
