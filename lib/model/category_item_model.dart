import 'dart:convert';

class CategoriesApiItem {
  final int iivrscurLId;
  final int iivrsCId;
  final String iivrscurLAPIName;
  final String iivrscurLAPIURL;
  CategoriesApiItem({
    required this.iivrscurLId,
    required this.iivrsCId,
    required this.iivrscurLAPIName,
    required this.iivrscurLAPIURL,
  });

  CategoriesApiItem copyWith({
    int? iivrscurLId,
    int? iivrsCId,
    String? iivrscurLAPIName,
    String? iivrscurLAPIURL,
  }) {
    return CategoriesApiItem(
      iivrscurLId: iivrscurLId ?? this.iivrscurLId,
      iivrsCId: iivrsCId ?? this.iivrsCId,
      iivrscurLAPIName: iivrscurLAPIName ?? this.iivrscurLAPIName,
      iivrscurLAPIURL: iivrscurLAPIURL ?? this.iivrscurLAPIURL,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'iivrscurLId': iivrscurLId,
      'iivrsCId': iivrsCId,
      'iivrscurLAPIName': iivrscurLAPIName,
      'iivrscurLAPIURL': iivrscurLAPIURL,
    };
  }

  factory CategoriesApiItem.fromMap(Map<String, dynamic> json) {
    return CategoriesApiItem(
      iivrscurLId: json['iivrscurL_Id'],
      iivrsCId: json['iivrsC_Id'],
      iivrscurLAPIName: json['iivrscurL_APIName'],
      iivrscurLAPIURL: json['iivrscurL_APIURL'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoriesApiItem.fromJson(String source) =>
      CategoriesApiItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CategoriesApiItem(iivrscurLId: $iivrscurLId, iivrsCId: $iivrsCId, iivrscurLAPIName: $iivrscurLAPIName, iivrscurLAPIURL: $iivrscurLAPIURL)';
  }

  @override
  bool operator ==(covariant CategoriesApiItem other) {
    if (identical(this, other)) return true;

    return other.iivrscurLId == iivrscurLId &&
        other.iivrsCId == iivrsCId &&
        other.iivrscurLAPIName == iivrscurLAPIName &&
        other.iivrscurLAPIURL == iivrscurLAPIURL;
  }

  @override
  int get hashCode {
    return iivrscurLId.hashCode ^
    iivrsCId.hashCode ^
    iivrscurLAPIName.hashCode ^
    iivrscurLAPIURL.hashCode;
  }
}
