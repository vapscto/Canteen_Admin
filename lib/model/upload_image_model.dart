// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UploadHwCwModel {
  final String name;
  final String path;
  UploadHwCwModel({
    required this.name,
    required this.path,
  });

  UploadHwCwModel copyWith({
    String? name,
    String? path,
  }) {
    return UploadHwCwModel(
      name: name ?? this.name,
      path: path ?? this.path,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'path': path,
    };
  }

  factory UploadHwCwModel.fromMap(Map<String, dynamic> map) {
    return UploadHwCwModel(
      name: map['name'] as String,
      path: map['path'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UploadHwCwModel.fromJson(String source) =>
      UploadHwCwModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UploadHwCwModel(name: $name, path: $path)';

  @override
  bool operator ==(covariant UploadHwCwModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.path == path;
  }

  @override
  int get hashCode => name.hashCode ^ path.hashCode;
}
