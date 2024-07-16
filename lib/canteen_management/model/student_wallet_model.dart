class StudentWalletModel {
  String? type;
  List<StudentWalletModelValues>? values;

  StudentWalletModel({this.type, this.values});

  StudentWalletModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <StudentWalletModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(StudentWalletModelValues.fromJson(v));
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

class StudentWalletModelValues {
  String? type;
  int? pDASId;
  int? mIId;
  int? aSMAYId;
  int? aMSTId;
  double? pDASOBStudentDue;
  double? pDASOBExcessPaid;
  double? pDASCYDeposit;
  double? pDASCYExpenses;
  double? pDASCYRefundAmt;
  double? pDASCBStudentDue;
  double? pDASCBExcessPaid;
  String? createdDate;
  String? updatedDate;
  String? pDASCreatedBy;
  String? pDASUpdatedBy;

  StudentWalletModelValues(
      {this.type,
      this.pDASId,
      this.mIId,
      this.aSMAYId,
      this.aMSTId,
      this.pDASOBStudentDue,
      this.pDASOBExcessPaid,
      this.pDASCYDeposit,
      this.pDASCYExpenses,
      this.pDASCYRefundAmt,
      this.pDASCBStudentDue,
      this.pDASCBExcessPaid,
      this.createdDate,
      this.updatedDate,
      this.pDASCreatedBy,
      this.pDASUpdatedBy});

  StudentWalletModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    pDASId = json['PDAS_Id'];
    mIId = json['MI_Id'];
    aSMAYId = json['ASMAY_Id'];
    aMSTId = json['AMST_Id'];
    pDASOBStudentDue = json['PDAS_OBStudentDue'];
    pDASOBExcessPaid = json['PDAS_OBExcessPaid'];
    pDASCYDeposit = json['PDAS_CYDeposit'];
    pDASCYExpenses = json['PDAS_CYExpenses'];
    pDASCYRefundAmt = json['PDAS_CYRefundAmt'];
    pDASCBStudentDue = json['PDAS_CBStudentDue'];
    pDASCBExcessPaid = json['PDAS_CBExcessPaid'];
    createdDate = json['CreatedDate'];
    updatedDate = json['UpdatedDate'];
    pDASCreatedBy = json['PDAS_CreatedBy'];
    pDASUpdatedBy = json['PDAS_UpdatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['PDAS_Id'] = pDASId;
    data['MI_Id'] = mIId;
    data['ASMAY_Id'] = aSMAYId;
    data['AMST_Id'] = aMSTId;
    data['PDAS_OBStudentDue'] = pDASOBStudentDue;
    data['PDAS_OBExcessPaid'] = pDASOBExcessPaid;
    data['PDAS_CYDeposit'] = pDASCYDeposit;
    data['PDAS_CYExpenses'] = pDASCYExpenses;
    data['PDAS_CYRefundAmt'] = pDASCYRefundAmt;
    data['PDAS_CBStudentDue'] = pDASCBStudentDue;
    data['PDAS_CBExcessPaid'] = pDASCBExcessPaid;
    data['CreatedDate'] = createdDate;
    data['UpdatedDate'] = updatedDate;
    data['PDAS_CreatedBy'] = pDASCreatedBy;
    data['PDAS_UpdatedBy'] = pDASUpdatedBy;
    return data;
  }
}
