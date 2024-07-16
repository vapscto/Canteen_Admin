class OptVerificationModel {
  int? pageid;
  int? rcredit;
  int? paymentNootificationGeneral;
  int? smscreditalert;
  int? pageId;
  int? roleId;
  int? ivrMMOId;
  String? prestartdate;
  String? presenddate;
  int? ivrMMIId;
  bool? ivrmrPAddFlag;
  bool? smsalrtflag;
  bool? ivrmrPUpdateFlag;
  bool? ivrmrPDeleteFlag;
  bool? ivrmrPProcessFlag;
  bool? ivrmrPReportFlag;
  int? asmaYId;
  int? asmcLId;
  int? pamsTId;
  int? pasrapSID;
  int? role;
  int? userId;
  int? count;
  int? amCId;
  int? smsmobileno;
  int? acayearid;
  int? acaclsid;
  String? displaymessage;
  int? miId;
  int? virtualid;
  int? amstId;
  bool? payment;
  bool? registration;
  String? message;
  bool? smscheck;
  bool? emailcheck;
  bool? defaultsmsemail;
  int? institutionid;
  int? apIID;
  bool? noint;
  int? amcOId;
  int? pacAId;

  OptVerificationModel(
      {this.pageid,
      this.rcredit,
      this.paymentNootificationGeneral,
      this.smscreditalert,
      this.pageId,
      this.roleId,
      this.ivrMMOId,
      this.prestartdate,
      this.presenddate,
      this.ivrMMIId,
      this.ivrmrPAddFlag,
      this.smsalrtflag,
      this.ivrmrPUpdateFlag,
      this.ivrmrPDeleteFlag,
      this.ivrmrPProcessFlag,
      this.ivrmrPReportFlag,
      this.asmaYId,
      this.asmcLId,
      this.pamsTId,
      this.pasrapSID,
      this.role,
      this.userId,
      this.count,
      this.amCId,
      this.smsmobileno,
      this.acayearid,
      this.acaclsid,
      this.displaymessage,
      this.miId,
      this.virtualid,
      this.amstId,
      this.payment,
      this.registration,
      this.message,
      this.smscheck,
      this.emailcheck,
      this.defaultsmsemail,
      this.institutionid,
      this.apIID,
      this.noint,
      this.amcOId,
      this.pacAId});

  OptVerificationModel.fromJson(Map<String, dynamic> json) {
    pageid = json['pageid'];
    rcredit = json['rcredit'];
    paymentNootificationGeneral = json['paymentNootificationGeneral'];
    smscreditalert = json['smscreditalert'];
    pageId = json['pageId'];
    roleId = json['roleId'];
    ivrMMOId = json['ivrM_MO_Id'];
    prestartdate = json['prestartdate'];
    presenddate = json['presenddate'];
    ivrMMIId = json['ivrM_MI_Id'];
    ivrmrPAddFlag = json['ivrmrP_AddFlag'];
    smsalrtflag = json['smsalrtflag'];
    ivrmrPUpdateFlag = json['ivrmrP_UpdateFlag'];
    ivrmrPDeleteFlag = json['ivrmrP_DeleteFlag'];
    ivrmrPProcessFlag = json['ivrmrP_ProcessFlag'];
    ivrmrPReportFlag = json['ivrmrP_ReportFlag'];
    asmaYId = json['asmaY_Id'];
    asmcLId = json['asmcL_Id'];
    pamsTId = json['pamsT_Id'];
    pasrapSID = json['pasrapS_ID'];
    role = json['role'];
    userId = json['userId'];
    count = json['count'];
    amCId = json['amC_Id'];
    smsmobileno = json['smsmobileno'];
    acayearid = json['acayearid'];
    acaclsid = json['acaclsid'];
    displaymessage = json['displaymessage'];
    miId = json['mi_id'];
    virtualid = json['virtualid'];
    amstId = json['amst_id'];
    payment = json['payment'];
    registration = json['registration'];
    message = json['message'];
    smscheck = json['smscheck'];
    emailcheck = json['emailcheck'];
    defaultsmsemail = json['defaultsmsemail'];
    institutionid = json['institutionid'];
    apIID = json['apI_ID'];
    noint = json['noint'];
    amcOId = json['amcO_Id'];
    pacAId = json['pacA_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pageid'] = pageid;
    data['rcredit'] = rcredit;
    data['paymentNootificationGeneral'] = paymentNootificationGeneral;
    data['smscreditalert'] = smscreditalert;
    data['pageId'] = pageId;
    data['roleId'] = roleId;
    data['ivrM_MO_Id'] = ivrMMOId;
    data['prestartdate'] = prestartdate;
    data['presenddate'] = presenddate;
    data['ivrM_MI_Id'] = ivrMMIId;
    data['ivrmrP_AddFlag'] = ivrmrPAddFlag;
    data['smsalrtflag'] = smsalrtflag;
    data['ivrmrP_UpdateFlag'] = ivrmrPUpdateFlag;
    data['ivrmrP_DeleteFlag'] = ivrmrPDeleteFlag;
    data['ivrmrP_ProcessFlag'] = ivrmrPProcessFlag;
    data['ivrmrP_ReportFlag'] = ivrmrPReportFlag;
    data['asmaY_Id'] = asmaYId;
    data['asmcL_Id'] = asmcLId;
    data['pamsT_Id'] = pamsTId;
    data['pasrapS_ID'] = pasrapSID;
    data['role'] = role;
    data['userId'] = userId;
    data['count'] = count;
    data['amC_Id'] = amCId;
    data['smsmobileno'] = smsmobileno;
    data['acayearid'] = acayearid;
    data['acaclsid'] = acaclsid;
    data['displaymessage'] = displaymessage;
    data['mi_id'] = miId;
    data['virtualid'] = virtualid;
    data['amst_id'] = amstId;
    data['payment'] = payment;
    data['registration'] = registration;
    data['message'] = message;
    data['smscheck'] = smscheck;
    data['emailcheck'] = emailcheck;
    data['defaultsmsemail'] = defaultsmsemail;
    data['institutionid'] = institutionid;
    data['apI_ID'] = apIID;
    data['noint'] = noint;
    data['amcO_Id'] = amcOId;
    data['pacA_Id'] = pacAId;
    return data;
  }
}
