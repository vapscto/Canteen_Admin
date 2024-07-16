class FoodImageListModel {
  String? type;
  List<FoodImageListModelValues>? values;

  FoodImageListModel({this.type, this.values});

  FoodImageListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <FoodImageListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(FoodImageListModelValues.fromJson(v));
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

class FoodImageListModelValues {
  int? cmmfIId;
  int? mIId;
  int? amsTId;
  int? asmaYId;
  int? userId;
  int? icaIId;
  double? cmmfIUnitRate;
  bool? cmmfIOutofStockFlg;
  bool? cmmfIActiveFlg;
  bool? cmmfIFoodItemFlag;
  String? icaIAttachment;

  FoodImageListModelValues(
      {this.cmmfIId,
      this.mIId,
      this.amsTId,
      this.asmaYId,
      this.userId,
      this.icaIId,
      this.cmmfIUnitRate,
      this.cmmfIOutofStockFlg,
      this.cmmfIActiveFlg,
      this.cmmfIFoodItemFlag,
      this.icaIAttachment});

  FoodImageListModelValues.fromJson(Map<String, dynamic> json) {
    cmmfIId = json['cmmfI_Id'];
    mIId = json['mI_Id'];
    amsTId = json['amsT_Id'];
    asmaYId = json['asmaY_Id'];
    userId = json['userId'];
    icaIId = json['icaI_Id'];
    cmmfIUnitRate = json['cmmfI_UnitRate'];
    cmmfIOutofStockFlg = json['cmmfI_OutofStockFlg'];
    cmmfIActiveFlg = json['cmmfI_ActiveFlg'];
    cmmfIFoodItemFlag = json['cmmfI_FoodItemFlag'];
    icaIAttachment = json['icaI_Attachment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cmmfI_Id'] = cmmfIId;
    data['mI_Id'] = mIId;
    data['amsT_Id'] = amsTId;
    data['asmaY_Id'] = asmaYId;
    data['userId'] = userId;
    data['icaI_Id'] = icaIId;
    data['cmmfI_UnitRate'] = cmmfIUnitRate;
    data['cmmfI_OutofStockFlg'] = cmmfIOutofStockFlg;
    data['cmmfI_ActiveFlg'] = cmmfIActiveFlg;
    data['cmmfI_FoodItemFlag'] = cmmfIFoodItemFlag;
    data['icaI_Attachment'] = icaIAttachment;
    return data;
  }
}
