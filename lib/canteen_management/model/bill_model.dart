class TransationBillModel {
  String? type;
  List<TransationBillModelValues>? values;

  TransationBillModel({this.type, this.values});

  TransationBillModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TransationBillModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(TransationBillModelValues.fromJson(v));
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

class TransationBillModelValues {
  String? type;
  int? aCMSTId;
  String? aMSTFirstName;
  dynamic cMTRANSTotalAmount;
  String? cMTransactionnum;
  int? cMOrderID;
  String? cMTRANSIName;
  dynamic cMTRANSQty;
  dynamic cMTRANSIUnitRate;
  dynamic rollNo;
  String? className;
  String? sectionName;
  String? logo;
  int? itemId;
  bool? voidItemFlag;
  String? sGST;
  String? cGST;
  String? gstIn;
  String? fssai;

  TransationBillModelValues(
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
      this.sectionName,
      this.logo,
      this.itemId,
      this.voidItemFlag,
      this.sGST,
      this.cGST,
      this.gstIn});

  TransationBillModelValues.fromJson(Map<String, dynamic> json) {
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
    itemId = json['CMMFI_Id'];
    voidItemFlag = json['CMTRANSI_VoidItemFlg'];
    sGST = json['SGST'];
    cGST = json['CGST'];
    gstIn = json['GSTIN'];
    fssai = json['FSSAI'];
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
    data['CMMFI_Id'] = itemId;
    data['CMTRANSI_VoidItemFlg'] = voidItemFlag;
    data['SGST'] = sGST;
    data ['CGST'] = cGST;
    data['GSTIN'] = gstIn;
    data['FSSAI'] = fssai;
    return data;
  }
}
