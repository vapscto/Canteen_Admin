class GeneratePinModel {
  String? type;
  List<GeneratePinModelValues>? values;

  GeneratePinModel({this.type, this.values});

  GeneratePinModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <GeneratePinModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(GeneratePinModelValues.fromJson(v));
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

class GeneratePinModelValues {
  int? amcstWId;
  int? mIId;
  int? amstId;
  String? amcstWWalletPIN;
  String? amcstWCreatedDate;
  int? amcstWCreatedBy;

  GeneratePinModelValues(
      {this.amcstWId,
      this.mIId,
      this.amstId,
      this.amcstWWalletPIN,
      this.amcstWCreatedDate,
      this.amcstWCreatedBy});

  GeneratePinModelValues.fromJson(Map<String, dynamic> json) {
    amcstWId = json['amcstW_Id'];
    mIId = json['mI_Id'];
    amstId = json['amst_Id'];
    amcstWWalletPIN = json['amcstW_WalletPIN'];
    amcstWCreatedDate = json['amcstW_CreatedDate'];
    amcstWCreatedBy = json['amcstW_CreatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amcstW_Id'] = amcstWId;
    data['mI_Id'] = mIId;
    data['amst_Id'] = amstId;
    data['amcstW_WalletPIN'] = amcstWWalletPIN;
    data['amcstW_CreatedDate'] = amcstWCreatedDate;
    data['amcstW_CreatedBy'] = amcstWCreatedBy;
    return data;
  }
}
