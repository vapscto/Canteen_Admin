class CounterWiseFoodModel {
  String? type;
  List<CounterWiseFoodModelValues>? values;

  CounterWiseFoodModel({this.type, this.values});

  CounterWiseFoodModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CounterWiseFoodModelValues>[];
      json['\$values'].forEach((v) {
        values!.add( CounterWiseFoodModelValues.fromJson(v));
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

class CounterWiseFoodModelValues {
  String? type;
  String? cmmfIFoodItemName;
  String? cmmfIFoodItemDescription;
  double? cmmfIUnitRate;
  bool? cmmfIOutofStockFlg;
  String? cmmfIPathURL;
  int? cmmfIId;
  String? cmmcACategoryName;
  int? cmmcAId;
  bool? cmmfIActiveFlg;
  bool? cmmfIFoodItemFlag;

  CounterWiseFoodModelValues(
      {this.type,
        this.cmmfIFoodItemName,
        this.cmmfIFoodItemDescription,
        this.cmmfIUnitRate,
        this.cmmfIOutofStockFlg,
        this.cmmfIPathURL,
        this.cmmfIId,
        this.cmmcACategoryName,
        this.cmmcAId,
        this.cmmfIActiveFlg,
        this.cmmfIFoodItemFlag});

  CounterWiseFoodModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    cmmfIFoodItemName = json['cmmfI_FoodItemName'];
    cmmfIFoodItemDescription = json['cmmfI_FoodItemDescription'];
    cmmfIUnitRate = json['cmmfI_UnitRate'];
    cmmfIOutofStockFlg = json['cmmfI_OutofStockFlg'];
    cmmfIPathURL = json['cmmfI_PathURL'];
    cmmfIId = json['cmmfI_Id'];
    cmmcACategoryName = json['cmmcA_CategoryName'];
    cmmcAId = json['cmmcA_Id'];
    cmmfIActiveFlg = json['cmmfI_ActiveFlg'];
    cmmfIFoodItemFlag = json['cmmfI_FoodItemFlag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['cmmfI_FoodItemName'] = cmmfIFoodItemName;
    data['cmmfI_FoodItemDescription'] = cmmfIFoodItemDescription;
    data['cmmfI_UnitRate'] = cmmfIUnitRate;
    data['cmmfI_OutofStockFlg'] = cmmfIOutofStockFlg;
    data['cmmfI_PathURL'] = cmmfIPathURL;
    data['cmmfI_Id'] = cmmfIId;
    data['cmmcA_CategoryName'] = cmmcACategoryName;
    data['cmmcA_Id'] = cmmcAId;
    data['cmmfI_ActiveFlg'] = cmmfIActiveFlg;
    data['cmmfI_FoodItemFlag'] = cmmfIFoodItemFlag;
    return data;
  }
}
