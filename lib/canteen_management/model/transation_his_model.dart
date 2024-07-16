class TransationHistoryModel {
  String? type;
  List<TransationHistoryModelValues>? values;

  TransationHistoryModel({this.type, this.values});

  TransationHistoryModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <TransationHistoryModelValues>[];
      json['\$values'].forEach((v) {
        values!.add( TransationHistoryModelValues.fromJson(v));
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

class TransationHistoryModelValues {
  String? type;
  int? cMTRANSId;
  int? mIId;
  int? aCMSTId;
  int? hRMEId;
  double? cMTRANSAmount;
  double? cMTRANSTotalAmount;
  int? cMOrderID;
  String? cMTransactionnum;
  String? cMTRANSUpdateddate;
  String? cMTRANSPMPaymentMode;

  TransationHistoryModelValues(
      {this.type,
        this.cMTRANSId,
        this.mIId,
        this.aCMSTId,
        this.hRMEId,
        this.cMTRANSAmount,
        this.cMTRANSTotalAmount,
        this.cMOrderID,
        this.cMTransactionnum,
        this.cMTRANSUpdateddate,
        this.cMTRANSPMPaymentMode});

  TransationHistoryModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    cMTRANSId = json['CMTRANS_Id'];
    mIId = json['MI_Id'];
    aCMSTId = json['ACMST_Id'];
    hRMEId = json['HRME_Id'];
    cMTRANSAmount = json['CMTRANS_Amount'];
    cMTRANSTotalAmount = json['CMTRANS_TotalAmount'];
    cMOrderID = json['CM_orderID'];
    cMTransactionnum = json['CM_Transactionnum'];
    cMTRANSUpdateddate = json['CMTRANS_Updateddate'];
    cMTRANSPMPaymentMode = json['CMTRANSPM_PaymentMode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['CMTRANS_Id'] = cMTRANSId;
    data['MI_Id'] = mIId;
    data['ACMST_Id'] = aCMSTId;
    data['HRME_Id'] = hRMEId;
    data['CMTRANS_Amount'] = cMTRANSAmount;
    data['CMTRANS_TotalAmount'] = cMTRANSTotalAmount;
    data['CM_orderID'] = cMOrderID;
    data['CM_Transactionnum'] = cMTransactionnum;
    data['CMTRANS_Updateddate'] = cMTRANSUpdateddate;
    data['CMTRANSPM_PaymentMode'] = cMTRANSPMPaymentMode;
    return data;
  }
}
