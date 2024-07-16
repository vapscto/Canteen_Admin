class DayWiseGraphModel {
  String? type;
  List<DayWiseGraphModelValues>? values;

  DayWiseGraphModel({this.type, this.values});

  DayWiseGraphModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DayWiseGraphModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DayWiseGraphModelValues.fromJson(v));
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

class DayWiseGraphModelValues {
  String? type;
  double? totalAmount;
  String? date;

  DayWiseGraphModelValues({this.type, this.totalAmount, this.date});

  DayWiseGraphModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    totalAmount = json['Total_Amount'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['Total_Amount'] = totalAmount;
    data['Date'] = date;
    return data;
  }
}
