class QuickSearchModel {
  String? type;
  List<QuickSearchModelValues>? values;

  QuickSearchModel({this.type, this.values});

  QuickSearchModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <QuickSearchModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(QuickSearchModelValues.fromJson(v));
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

class QuickSearchModelValues {
  String? type;
  int? aCMSTId;
  String? aMSTFirstName;
  double? cMTRANSTotalAmount;
  String? cMTransactionnum;
  int? cMOrderID;
  String? cMTRANSIName;
  double? cMTRANSQty;
  double? cMTRANSIUnitRate;
  int? rollNo;
  String? className;
  String? sectionName;
  String? logo;int? categoryId;

  QuickSearchModelValues(
      {this.type,
        this.aCMSTId,
        this.aMSTFirstName,
        this.cMTRANSTotalAmount,
        this.cMTransactionnum,
        this.cMOrderID,
        this.cMTRANSIName,
        this.cMTRANSQty,
        this.cMTRANSIUnitRate,
        this.rollNo,
        this.className,
        this.sectionName, this.logo, this.categoryId});

  QuickSearchModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    aCMSTId = json['ACMST_Id'];
    aMSTFirstName = json['AMST_FirstName'];
    cMTRANSTotalAmount = json['CMTRANS_TotalAmount'];
    cMTransactionnum = json['CM_Transactionnum'];
    cMOrderID = json['CM_orderID'];
    cMTRANSIName = json['CMTRANSI_name'];
    cMTRANSQty = json['CMTRANS_Qty'];
    cMTRANSIUnitRate = json['CMTRANSI_UnitRate'];
    rollNo = json['RollNo'];
    className = json['ClassName'];
    sectionName = json['SectionName'];
    logo = json['Logo'];
    categoryId= json['CMMCA_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['ACMST_Id'] = aCMSTId;
    data['AMST_FirstName'] = aMSTFirstName;
    data['CMTRANS_TotalAmount'] = cMTRANSTotalAmount;
    data['CM_Transactionnum'] = cMTransactionnum;
    data['CM_orderID'] = cMOrderID;
    data['CMTRANSI_name'] = cMTRANSIName;
    data['CMTRANS_Qty'] = cMTRANSQty;
    data['CMTRANSI_UnitRate'] = cMTRANSIUnitRate;
    data['RollNo'] = rollNo;
    data['ClassName'] = className;
    data['SectionName'] = sectionName;
    data['Logo'] = logo;
    data['CMMCA_Id'] = categoryId;
    return data;
  }
}
