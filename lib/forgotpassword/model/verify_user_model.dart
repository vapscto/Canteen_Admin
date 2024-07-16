class VerifyUserNameModel {
  int? amsTId;
  int? smscreditalert;
  bool? smsalrtflag;
  int? roleId;
  bool? isLogged;
  int? amaYActiveFlag;
  int? asmaYOrder;
  int? userId;
  int? rcredit;
  String? email;
  int? ivrMMOId;
  int? asmaYId;
  int? imfYId;
  int? role;
  int? ivrmimPId;
  int? mIID;
  String? mobileNo;
  int? pageId;
  bool? ivrmirPAddFlag;
  bool? ivrmirPUpdateFlag;
  bool? ivrmirPDeleteFlag;
  bool? ivrmirPReportFlag;
  bool? ivrmirPSearchFlag;
  bool? ivrmirPProcessFlag;
  String? userNameVerifyStatus;
  int? ivrmrmaPId;
  String? cutoffdate;
  String? subscriptionenddate;
  bool? subscriptionFlag;
  String? dob;
  int? mobno;
  bool? payment;
  bool? registration;
  int? empcode;
  int? mIIdforlogin;
  int? paymentNootificationGeneral;
  int? roleTypeId;
  int? empId;
  bool? ivrmumalPAddFlg;
  bool? ivrmumalPUpdateFlg;
  bool? ivrmumalPDeleteFlg;
  int? almsTId;

  VerifyUserNameModel(
      {this.amsTId,
      this.smscreditalert,
      this.smsalrtflag,
      this.roleId,
      this.isLogged,
      this.amaYActiveFlag,
      this.asmaYOrder,
      this.userId,
      this.rcredit,
      this.email,
      this.ivrMMOId,
      this.asmaYId,
      this.imfYId,
      this.role,
      this.ivrmimPId,
      this.mIID,
      this.mobileNo,
      this.pageId,
      this.ivrmirPAddFlag,
      this.ivrmirPUpdateFlag,
      this.ivrmirPDeleteFlag,
      this.ivrmirPReportFlag,
      this.ivrmirPSearchFlag,
      this.ivrmirPProcessFlag,
      this.userNameVerifyStatus,
      this.ivrmrmaPId,
      this.cutoffdate,
      this.subscriptionenddate,
      this.subscriptionFlag,
      this.dob,
      this.mobno,
      this.payment,
      this.registration,
      this.empcode,
      this.mIIdforlogin,
      this.paymentNootificationGeneral,
      this.roleTypeId,
      this.empId,
      this.ivrmumalPAddFlg,
      this.ivrmumalPUpdateFlg,
      this.ivrmumalPDeleteFlg,
      this.almsTId});

  VerifyUserNameModel.fromJson(Map<String, dynamic> json) {
    amsTId = json['amsT_Id'];
    smscreditalert = json['smscreditalert'];
    smsalrtflag = json['smsalrtflag'];
    roleId = json['roleId'];
    isLogged = json['isLogged'];
    amaYActiveFlag = json['amaY_ActiveFlag'];
    asmaYOrder = json['asmaY_Order'];
    userId = json['userId'];
    rcredit = json['rcredit'];
    email = json['email'];
    ivrMMOId = json['ivrM_MO_Id'];
    asmaYId = json['asmaY_Id'];
    imfYId = json['imfY_Id'];
    role = json['role'];
    ivrmimPId = json['ivrmimP_Id'];
    mIID = json['mI_ID'];
    mobileNo = json['mobileNo'];
    pageId = json['pageId'];
    ivrmirPAddFlag = json['ivrmirP_AddFlag'];
    ivrmirPUpdateFlag = json['ivrmirP_UpdateFlag'];
    ivrmirPDeleteFlag = json['ivrmirP_DeleteFlag'];
    ivrmirPReportFlag = json['ivrmirP_ReportFlag'];
    ivrmirPSearchFlag = json['ivrmirP_SearchFlag'];
    ivrmirPProcessFlag = json['ivrmirP_ProcessFlag'];
    userNameVerifyStatus = json['userNameVerifyStatus'];
    ivrmrmaPId = json['ivrmrmaP_Id'];
    cutoffdate = json['cutoffdate'];
    subscriptionenddate = json['subscriptionenddate'];
    subscriptionFlag = json['subscriptionFlag'];
    dob = json['dob'];
    mobno = json['mobno'];
    payment = json['payment'];
    registration = json['registration'];
    empcode = json['empcode'];
    mIIdforlogin = json['mI_Idforlogin'];
    paymentNootificationGeneral = json['paymentNootificationGeneral'];
    roleTypeId = json['roleTypeId'];
    empId = json['emp_Id'];
    ivrmumalPAddFlg = json['ivrmumalP_AddFlg'];
    ivrmumalPUpdateFlg = json['ivrmumalP_UpdateFlg'];
    ivrmumalPDeleteFlg = json['ivrmumalP_DeleteFlg'];
    almsTId = json['almsT_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amsT_Id'] = amsTId;
    data['smscreditalert'] = smscreditalert;
    data['smsalrtflag'] = smsalrtflag;
    data['roleId'] = roleId;
    data['isLogged'] = isLogged;
    data['amaY_ActiveFlag'] = amaYActiveFlag;
    data['asmaY_Order'] = asmaYOrder;
    data['userId'] = userId;
    data['rcredit'] = rcredit;
    data['email'] = email;
    data['ivrM_MO_Id'] = ivrMMOId;
    data['asmaY_Id'] = asmaYId;
    data['imfY_Id'] = imfYId;
    data['role'] = role;
    data['ivrmimP_Id'] = ivrmimPId;
    data['mI_ID'] = mIID;
    data['mobileNo'] = mobileNo;
    data['pageId'] = pageId;
    data['ivrmirP_AddFlag'] = ivrmirPAddFlag;
    data['ivrmirP_UpdateFlag'] = ivrmirPUpdateFlag;
    data['ivrmirP_DeleteFlag'] = ivrmirPDeleteFlag;
    data['ivrmirP_ReportFlag'] = ivrmirPReportFlag;
    data['ivrmirP_SearchFlag'] = ivrmirPSearchFlag;
    data['ivrmirP_ProcessFlag'] = ivrmirPProcessFlag;
    data['userNameVerifyStatus'] = userNameVerifyStatus;
    data['ivrmrmaP_Id'] = ivrmrmaPId;
    data['cutoffdate'] = cutoffdate;
    data['subscriptionenddate'] = subscriptionenddate;
    data['subscriptionFlag'] = subscriptionFlag;
    data['dob'] = dob;
    data['mobno'] = mobno;
    data['payment'] = payment;
    data['registration'] = registration;
    data['empcode'] = empcode;
    data['mI_Idforlogin'] = mIIdforlogin;
    data['paymentNootificationGeneral'] = paymentNootificationGeneral;
    data['roleTypeId'] = roleTypeId;
    data['emp_Id'] = empId;
    data['ivrmumalP_AddFlg'] = ivrmumalPAddFlg;
    data['ivrmumalP_UpdateFlg'] = ivrmumalPUpdateFlg;
    data['ivrmumalP_DeleteFlg'] = ivrmumalPDeleteFlg;
    data['almsT_Id'] = almsTId;
    return data;
  }
}
