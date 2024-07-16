class CardReaderModel {
  String? type;
  List<CardReaderModelValues>? values;

  CardReaderModel({this.type, this.values});

  CardReaderModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CardReaderModelValues>[];
      json['\$values'].forEach((v) {
        values!.add( CardReaderModelValues.fromJson(v));
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

class CardReaderModelValues {
  String? type;
  int? aMCTSTId;
  int? aMSTId;
  String? aMCTSTIP;
  String? aMCTSTSTATUS;
  int? mIId;
  double? pDAAmount;
  String? schoolCollegeFlag;
  dynamic pDAEHID;
  int? aSMAYId;
  double? walletamount;
  String? flag;

  CardReaderModelValues(
      {this.type,
        this.aMCTSTId,
        this.aMSTId,
        this.aMCTSTIP,
        this.aMCTSTSTATUS,
        this.mIId,
        this.pDAAmount,
        this.schoolCollegeFlag,
        this.pDAEHID,
        this.aSMAYId,
        this.walletamount,
        this.flag});

  CardReaderModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    aMCTSTId = json['AMCTST_Id'];
    aMSTId = json['AMST_Id'];
    aMCTSTIP = json['AMCTST_IP'];
    aMCTSTSTATUS = json['AMCTST_STATUS'];
    mIId = json['MI_Id'];
    pDAAmount = json['PDA_amount'];
    schoolCollegeFlag = json['SchoolCollegeFlag'];
    pDAEHID = json['PDAEH_ID'];
    aSMAYId = json['ASMAY_Id'];
    walletamount = json['walletamount'];
    flag = json['flag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['AMCTST_Id'] = aMCTSTId;
    data['AMST_Id'] = aMSTId;
    data['AMCTST_IP'] = aMCTSTIP;
    data['AMCTST_STATUS'] = aMCTSTSTATUS;
    data['MI_Id'] = mIId;
    data['PDA_amount'] = pDAAmount;
    data['SchoolCollegeFlag'] = schoolCollegeFlag;
    data['PDAEH_ID'] = pDAEHID;
    data['ASMAY_Id'] = aSMAYId;
    data['walletamount'] = walletamount;
    data['flag'] = flag;
    return data;
  }
}
