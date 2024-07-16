class YearWiseGraphModel {
  String? type;
  List<YearWiseGraphModelValues>? values;

  YearWiseGraphModel({this.type, this.values});

  YearWiseGraphModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <YearWiseGraphModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(YearWiseGraphModelValues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['\$type'] = type;
    if (values != null) {
      data['\$values'] = values!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class YearWiseGraphModelValues {
  String? type;
  double? totalAmount;
  String? month;
  int? year;

  YearWiseGraphModelValues({this.type, this.totalAmount, this.month, this.year});

  YearWiseGraphModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    totalAmount = json['Total_Amount'];
    month = json['Month'];
    year = json['Year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['Total_Amount'] = totalAmount;
    data['Month'] = month;
    data['Year'] = year;
    return data;
  }
}
