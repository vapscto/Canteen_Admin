class FoodListModel {
  String? type;
  List<FoodListModelValues>? values;

  FoodListModel({this.type, this.values});

  FoodListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <FoodListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(FoodListModelValues.fromJson(v));
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

class FoodListModelValues {
  int? cmmfIId;
  int? mIId;
  int? amsTId;
  int? asmaYId;
  int? userId;
  int? icaIId;
  String? cmmfIFoodItemName;
  String? cmmfIFoodItemDescription;
  String? cmmcACategoryName;
  double? cmmfIUnitRate;
  bool? cmmfIOutofStockFlg;
  String? cmmfIPathURL;
  int? cmmcAId;
  bool? cmmfIActiveFlg;
  bool? cmmfIFoodItemFlag;
  String? icaIAttachment;
  String? foodCode;

  FoodListModelValues(
      {this.cmmfIId,
      this.mIId,
      this.amsTId,
      this.asmaYId,
      this.userId,
      this.icaIId,
      this.cmmfIFoodItemName,
      this.cmmfIFoodItemDescription,
      this.cmmcACategoryName,
      this.cmmfIUnitRate,
      this.cmmfIOutofStockFlg,
      this.cmmfIPathURL,
      this.cmmcAId,
      this.cmmfIActiveFlg,
      this.cmmfIFoodItemFlag,
      this.icaIAttachment,this.foodCode,});

  FoodListModelValues.fromJson(Map<String, dynamic> json) {
    cmmfIId = json['cmmfI_Id'];
    mIId = json['mI_Id'];
    amsTId = json['amsT_Id'];
    asmaYId = json['asmaY_Id'];
    userId = json['userId'];
    icaIId = json['icaI_Id'];
    cmmfIFoodItemName = json['cmmfI_FoodItemName'];
    cmmfIFoodItemDescription = json['cmmfI_FoodItemDescription'];
    cmmcACategoryName = json['cmmcA_CategoryName'];
    cmmfIUnitRate = json['cmmfI_UnitRate'];
    cmmfIOutofStockFlg = json['cmmfI_OutofStockFlg'];
    cmmfIPathURL = json['cmmfI_PathURL'];
    cmmcAId = json['cmmcA_Id'];
    cmmfIActiveFlg = json['cmmfI_ActiveFlg'];
    cmmfIFoodItemFlag = json['cmmfI_FoodItemFlag'];
    icaIAttachment = json['icaI_Attachment'];
    foodCode = json['cmmfI_FoodItemCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cmmfI_Id'] = cmmfIId;
    data['mI_Id'] = mIId;
    data['amsT_Id'] = amsTId;
    data['asmaY_Id'] = asmaYId;
    data['userId'] = userId;
    data['icaI_Id'] = icaIId;
    data['cmmfI_FoodItemName'] = cmmfIFoodItemName;
    data['cmmfI_FoodItemDescription'] = cmmfIFoodItemDescription;
    data['cmmcA_CategoryName'] = cmmcACategoryName;
    data['cmmfI_UnitRate'] = cmmfIUnitRate;
    data['cmmfI_OutofStockFlg'] = cmmfIOutofStockFlg;
    data['cmmfI_PathURL'] = cmmfIPathURL;
    data['cmmcA_Id'] = cmmcAId;
    data['cmmfI_ActiveFlg'] = cmmfIActiveFlg;
    data['cmmfI_FoodItemFlag'] = cmmfIFoodItemFlag;
    data['icaI_Attachment'] = icaIAttachment;
    data['cmmfI_FoodItemCode'] = foodCode;
    return data;
  }
}
