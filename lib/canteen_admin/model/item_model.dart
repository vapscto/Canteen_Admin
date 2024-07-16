class ItemModel {
  int? aCMSTId;
  String? aMSTFirstName;
  double? cMTRANSTotalAmount;
  String? cMTransactionnum;
  int? cMOrderID;
  String? cMTRANSIName;
  double? cMTRANSQty;
  double? cMTRANSIUnitRate;
  bool? isSelect;
  String? paymentType;
  int? transactionId;
  int? itemId;
  bool? voidAmountFlag;

  ItemModel(
      {this.aCMSTId,
      this.aMSTFirstName,
      this.cMTRANSTotalAmount,
      this.cMTransactionnum,
      this.cMOrderID,
      this.cMTRANSIName,
      this.cMTRANSQty,
      this.cMTRANSIUnitRate,
      this.isSelect,
      this.paymentType,
      this.transactionId,
      this.itemId,
      this.voidAmountFlag});

  ItemModel.fromJson(Map<String, dynamic> json) {
    aCMSTId = json['ACMST_Id'];
    aMSTFirstName = json['AMST_FirstName'];
    cMTRANSTotalAmount = json['CMTRANS_TotalAmount'];
    cMTransactionnum = json['CM_Transactionnum'];
    cMOrderID = json['CM_orderID'];
    cMTRANSIName = json['CMTRANSI_name'];
    cMTRANSQty = json['CMTRANS_Qty'];
    cMTRANSIUnitRate = json['CMTRANSI_UnitRate'];
    isSelect = json['isSelect'];
    paymentType = json['paymentType'];
    transactionId = json['transactionId'];
    itemId = json['CMMFI_Id'];
    voidAmountFlag = json['CMTRANSI_VoidItemFlg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ACMST_Id'] = aCMSTId;
    data['AMST_FirstName'] = aMSTFirstName;
    data['CMTRANS_TotalAmount'] = cMTRANSTotalAmount;
    data['CM_Transactionnum'] = cMTransactionnum;
    data['CM_orderID'] = cMOrderID;
    data['CMTRANSI_name'] = cMTRANSIName;
    data['CMTRANS_Qty'] = cMTRANSQty;
    data['CMTRANSI_UnitRate'] = cMTRANSIUnitRate;
    data['isSelect'] = isSelect;
    data['paymentType'] = paymentType;
    data['transactionId'] = transactionId;
    data['CMMFI_Id'] = itemId;
    data['CMTRANSI_VoidItemFlg'] = voidAmountFlag;
    return data;
  }
}
