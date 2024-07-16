// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'category_item_model.dart';


class CategoriesApiArrayModel {
  final String type;
  final List<CategoriesApiItem> values;
  CategoriesApiArrayModel({
    required this.type,
    required this.values,
  });

  CategoriesApiArrayModel copyWith({
    String? type,
    List<CategoriesApiItem>? values,
  }) {
    return CategoriesApiArrayModel(
      type: type ?? this.type,
      values: values ?? this.values,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'values': values.map((x) => x.toMap()).toList(),
    };
  }

  factory CategoriesApiArrayModel.fromMap(Map<String, dynamic> map) {
    return CategoriesApiArrayModel(
      type: map['\$type'] as String,
      values: List<CategoriesApiItem>.from(
        (map['\$values'] as List<dynamic>).map<CategoriesApiItem>(
              (x) => CategoriesApiItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesApiArrayModel.fromJson(String source) =>
      CategoriesApiArrayModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CategoriesApiArrayModel(type: $type, values: $values)';

  @override
  bool operator ==(covariant CategoriesApiArrayModel other) {
    if (identical(this, other)) return true;

    return other.type == type && listEquals(other.values, values);
  }

  @override
  int get hashCode => type.hashCode ^ values.hashCode;
}
