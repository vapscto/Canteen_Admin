class OneTimePrintModel {
  String? type;
  List<OneTimePrintModelValues>? values;

  OneTimePrintModel({this.type, this.values});

  OneTimePrintModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <OneTimePrintModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(OneTimePrintModelValues.fromJson(v));
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

class OneTimePrintModelValues {
  String? type;
  String? returnvalue;

  OneTimePrintModelValues({this.type, this.returnvalue});

  OneTimePrintModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    returnvalue = json['returnvalue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['returnvalue'] = returnvalue;
    return data;
  }
}
