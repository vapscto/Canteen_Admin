class CanteenInsList {
  String? type;
  List<CanteenInsListValues>? values;

  CanteenInsList({this.type, this.values});

  CanteenInsList.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CanteenInsListValues>[];
      json['\$values'].forEach((v) {
        values!.add(CanteenInsListValues.fromJson(v));
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

class CanteenInsListValues {
  int? mIId;
  // int? mOId;
  String? mIName;
  String? mIType;


  CanteenInsListValues(
      {this.mIId,
        // this.mOId,
        this.mIName,
        this.mIType,
        });

  CanteenInsListValues.fromJson(Map<String, dynamic> json) {
    mIId = json['MI_Id'];
    // mOId = json['mO_Id'];
    mIName = json['MI_Name'];
    // mIType = json['mI_Type'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['MI_Id'] = mIId;
    // data['mO_Id'] = mOId;
    data['MI_Name'] = mIName;
    // data['mI_Type'] = mIType;

    return data;
  }
}
