class AddedCategoryModel {
  String? type;
  List<AddedCategoryModelValues>? values;

  AddedCategoryModel({this.type, this.values});

  AddedCategoryModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <AddedCategoryModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(AddedCategoryModelValues.fromJson(v));
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

class AddedCategoryModelValues {
  int? cmmcAId;
  int? mIId;
  String? cmmcACategoryName;
  String? cmmcARemarks;
  bool? cmmcAActiveFlag;
  String? cmmcACreatedDate;
  String? cmmcAUpdatedDate;
  int? createdBy;
  int? updatedBy;

  AddedCategoryModelValues(
      {this.cmmcAId,
        this.mIId,
        this.cmmcACategoryName,
        this.cmmcARemarks,
        this.cmmcAActiveFlag,
        this.cmmcACreatedDate,
        this.cmmcAUpdatedDate,
        this.createdBy,
        this.updatedBy});

  AddedCategoryModelValues.fromJson(Map<String, dynamic> json) {
    cmmcAId = json['cmmcA_Id'];
    mIId = json['mI_Id'];
    cmmcACategoryName = json['cmmcA_CategoryName'];
    cmmcARemarks = json['cmmcA_Remarks'];
    cmmcAActiveFlag = json['cmmcA_ActiveFlag'];
    cmmcACreatedDate = json['cmmcA_CreatedDate'];
    cmmcAUpdatedDate = json['cmmcA_UpdatedDate'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cmmcA_Id'] = cmmcAId;
    data['mI_Id'] = mIId;
    data['cmmcA_CategoryName'] = cmmcACategoryName;
    data['cmmcA_Remarks'] = cmmcARemarks;
    data['cmmcA_ActiveFlag'] = cmmcAActiveFlag;
    data['cmmcA_CreatedDate'] = cmmcACreatedDate;
    data['cmmcA_UpdatedDate'] = cmmcAUpdatedDate;
    data['createdBy'] = createdBy;
    data['updatedBy'] = updatedBy;
    return data;
  }
}
