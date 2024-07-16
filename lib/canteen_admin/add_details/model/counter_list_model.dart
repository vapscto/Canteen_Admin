class CounterListModel {
  String? type;
  List<CounterListModelValues>? values;

  CounterListModel({this.type, this.values});

  CounterListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CounterListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CounterListModelValues.fromJson(v));
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

class CounterListModelValues {
  int? cmmcOId;
  int? mIId;
  String? cmmcOCounterName;
  String? cmmcORemarks;
  bool? cmmcOActiveFlag;
  String? cmmcOCreatedDate;
  String? cmmcOUpdatedDate;
  dynamic cmmcOCreatedBy;
  dynamic cmmcOUpdatedBy;

  CounterListModelValues(
      {this.cmmcOId,
        this.mIId,
        this.cmmcOCounterName,
        this.cmmcORemarks,
        this.cmmcOActiveFlag,
        this.cmmcOCreatedDate,
        this.cmmcOUpdatedDate,
        this.cmmcOCreatedBy,
        this.cmmcOUpdatedBy});

  CounterListModelValues.fromJson(Map<String, dynamic> json) {
    cmmcOId = json['cmmcO_Id'];
    mIId = json['mI_Id'];
    cmmcOCounterName = json['cmmcO_CounterName'];
    cmmcORemarks = json['cmmcO_Remarks'];
    cmmcOActiveFlag = json['cmmcO_ActiveFlag'];
    cmmcOCreatedDate = json['cmmcO_CreatedDate'];
    cmmcOUpdatedDate = json['cmmcO_UpdatedDate'];
    cmmcOCreatedBy = json['cmmcO_CreatedBy'];
    cmmcOUpdatedBy = json['cmmcO_UpdatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cmmcO_Id'] = cmmcOId;
    data['mI_Id'] = mIId;
    data['cmmcO_CounterName'] = cmmcOCounterName;
    data['cmmcO_Remarks'] = cmmcORemarks;
    data['cmmcO_ActiveFlag'] = cmmcOActiveFlag;
    data['cmmcO_CreatedDate'] = cmmcOCreatedDate;
    data['cmmcO_UpdatedDate'] = cmmcOUpdatedDate;
    data['cmmcO_CreatedBy'] = cmmcOCreatedBy;
    data['cmmcO_UpdatedBy'] = cmmcOUpdatedBy;
    return data;
  }
}
