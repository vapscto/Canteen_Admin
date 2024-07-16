class LoginSuccessModel {
  int? amsTId;
  int? asmcLId;
  int? asmSId;
  String? amsTAdmNo;
  int? smscreditalert;
  bool? smsalrtflag;
  int? roleId;
  bool? isLogged;
  int? amaYActiveFlag;
  int? asmaYOrder;
  int? userId;
  int? rcredit;
  int? ivrMMOId;
  List<MiIdList>? miIdList;
  int? asmaYId;
  int? imfYId;
  int? role;
  String? userName;
  String? mobileprivileges;
  int? ivrmimPId;
  int? mIID;
  String? schoolcollegeflag;
  // String? userImagePath;
  String? hrmEEmployeeCode;
  int? pageId;
  bool? ivrmirPAddFlag;
  bool? ivrmirPUpdateFlag;
  bool? ivrmirPDeleteFlag;
  bool? ivrmirPReportFlag;
  bool? ivrmirPSearchFlag;
  bool? ivrmirPProcessFlag;
  int? ivrmrmaPId;
  Staffmobileappprivileges? staffmobileappprivileges;
  CounterNameModel? counterNameModel;
  String? cutoffdate;
  String? subscriptionenddate;
  bool? subscriptionFlag;
  Staffmobileappprivileges? institutionlist;
  String? asmaYYear;
  String? flag;
  String? clsnme;
  String? dob;
  int? mobno;
  String? studname;
  bool? payment;
  bool? registration;
  String? roleforlogin;
  int? empcode;
  int? mIIdforlogin;
  int? paymentNootificationGeneral;
  int? roleTypeId;
  int? empId;
  bool? ivrmumalPAddFlg;
  bool? ivrmumalPUpdateFlg;
  bool? ivrmumalPDeleteFlg;
  int? almsTId;
  String? mIBackgroundImage;
  String? mILogo;
  InstituteDetails? institutedetails;
  String? asmcLClassName;
  String? asmSSectionName;

  LoginSuccessModel({
    this.amsTId,
    this.asmSId,
    this.asmcLId,
    this.smscreditalert,
    this.smsalrtflag,
    this.roleId,
    this.isLogged,
    this.amaYActiveFlag,
    this.asmaYOrder,
    this.userId,
    this.rcredit,
    this.ivrMMOId,
    this.miIdList,
    this.asmaYId,
    this.imfYId,
    this.role,
    this.userName,
    this.mobileprivileges,
    this.ivrmimPId,
    this.mIID,
    this.schoolcollegeflag,
    // this.userImagePath,
    this.pageId,
    this.ivrmirPAddFlag,
    this.ivrmirPUpdateFlag,
    this.ivrmirPDeleteFlag,
    this.ivrmirPReportFlag,
    this.ivrmirPSearchFlag,
    this.ivrmirPProcessFlag,
    this.ivrmrmaPId,
    this.staffmobileappprivileges,
    this.counterNameModel,
    this.cutoffdate,
    this.subscriptionenddate,
    this.subscriptionFlag,
    this.institutionlist,
    this.asmaYYear,
    this.flag,
    this.clsnme,
    this.dob,
    this.mobno,
    this.studname,
    this.payment,
    this.registration,
    this.roleforlogin,
    this.empcode,
    this.mIIdforlogin,
    this.paymentNootificationGeneral,
    this.roleTypeId,
    this.empId,
    this.ivrmumalPAddFlg,
    this.ivrmumalPUpdateFlg,
    this.ivrmumalPDeleteFlg,
    this.almsTId,
    this.mIBackgroundImage,
    this.mILogo,
    this.institutedetails,
    this.amsTAdmNo,
    this.asmSSectionName,
    this.asmcLClassName,
    this.hrmEEmployeeCode,
  });

  LoginSuccessModel.fromJson(Map<String, dynamic> json) {
    amsTId = json['amsT_Id'];
    asmcLId = json['asmcL_Id'];
    asmSId = json['asmS_Id'];
    amsTAdmNo = json['amsT_AdmNo'];
    smscreditalert = json['smscreditalert'];
    smsalrtflag = json['smsalrtflag'];
    roleId = json['roleId'];
    isLogged = json['isLogged'];
    amaYActiveFlag = json['amaY_ActiveFlag'];
    asmaYOrder = json['asmaY_Order'];
    userId = json['userId'];
    rcredit = json['rcredit'];
    ivrMMOId = json['ivrM_MO_Id'];
    if (json['mi_Id_List'] != null) {
      miIdList = <MiIdList>[];
      json['mi_Id_List'].forEach((v) {
        miIdList!.add(MiIdList.fromJson(v));
      });
    }
    asmaYId = json['asmaY_Id'];
    imfYId = json['imfY_Id'];
    role = json['role'];
    userName = json['userName'];
    mobileprivileges = json['mobileprivileges'];
    ivrmimPId = json['ivrmimP_Id'];
    mIID = json['mI_ID'];
    schoolcollegeflag = json['schoolcollegeflag'];
    // userImagePath = json['userImagePath']??"";
    pageId = json['pageId'];
    ivrmirPAddFlag = json['ivrmirP_AddFlag'];
    ivrmirPUpdateFlag = json['ivrmirP_UpdateFlag'];
    ivrmirPDeleteFlag = json['ivrmirP_DeleteFlag'];
    ivrmirPReportFlag = json['ivrmirP_ReportFlag'];
    ivrmirPSearchFlag = json['ivrmirP_SearchFlag'];
    ivrmirPProcessFlag = json['ivrmirP_ProcessFlag'];
    ivrmrmaPId = json['ivrmrmaP_Id'];
    staffmobileappprivileges = json['staffmobileappprivileges'] != null
        ? Staffmobileappprivileges.fromJson(json['staffmobileappprivileges'])
        : null;
    counterNameModel = json['cm_usercounterdeatils'] == null
        ? null
        : CounterNameModel.fromJson(json['cm_usercounterdeatils']);
    cutoffdate = json['cutoffdate'];
    subscriptionenddate = json['subscriptionenddate'];
    subscriptionFlag = json['subscriptionFlag'];
    institutionlist = json['institutionlist'] != null
        ? Staffmobileappprivileges.fromJson(json['institutionlist'])
        : null;
    counterNameModel = json['cm_usercounterdeatils'] != null
        ? CounterNameModel.fromJson(json['cm_usercounterdeatils'])
        : null;
    asmaYYear = json['asmaY_Year'];
    flag = json['flag'];
    clsnme = json['clsnme'];
    dob = json['dob'];
    mobno = json['mobno'];
    studname = json['studname'];
    payment = json['payment'];
    registration = json['registration'];
    roleforlogin = json['roleforlogin'];
    empcode = json['empcode'];
    mIIdforlogin = json['mI_Idforlogin'];
    paymentNootificationGeneral = json['paymentNootificationGeneral'];
    roleTypeId = json['roleTypeId'];
    empId = json['emp_Id'];
    ivrmumalPAddFlg = json['ivrmumalP_AddFlg'];
    ivrmumalPUpdateFlg = json['ivrmumalP_UpdateFlg'];
    ivrmumalPDeleteFlg = json['ivrmumalP_DeleteFlg'];
    almsTId = json['almsT_Id'];
    mIBackgroundImage = json['mI_BackgroundImage'];
    mILogo = json['mI_Logo'];
    institutedetails = json['institutedetails'] != null
        ? InstituteDetails.fromJson(json['institutedetails'])
        : null;

    asmcLClassName = json['asmcL_ClassName'];
    asmSSectionName = json['asmS_SectionName'];
    hrmEEmployeeCode = json['hrmE_EmployeeCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['amsT_Id'] = amsTId;
    data['asmcL_Id'] = asmcLId;
    data['asmS_Id'] = asmSId;
    data['smscreditalert'] = smscreditalert;
    data['smsalrtflag'] = smsalrtflag;
    data['roleId'] = roleId;
    data['isLogged'] = isLogged;
    data['amaY_ActiveFlag'] = amaYActiveFlag;
    data['asmaY_Order'] = asmaYOrder;
    data['userId'] = userId;
    data['rcredit'] = rcredit;
    data['ivrM_MO_Id'] = ivrMMOId;
    if (miIdList != null) {
      data['mi_Id_List'] = miIdList!.map((v) => v.toJson()).toList();
    }
    data['asmaY_Id'] = asmaYId;
    data['imfY_Id'] = imfYId;
    data['role'] = role;
    data['userName'] = userName;
    data['mobileprivileges'] = mobileprivileges;
    data['ivrmimP_Id'] = ivrmimPId;
    data['mI_ID'] = mIID;
    data['schoolcollegeflag'] = schoolcollegeflag;
    // data['userImagePath'] = userImagePath;
    data['pageId'] = pageId;
    data['ivrmirP_AddFlag'] = ivrmirPAddFlag;
    data['ivrmirP_UpdateFlag'] = ivrmirPUpdateFlag;
    data['ivrmirP_DeleteFlag'] = ivrmirPDeleteFlag;
    data['ivrmirP_ReportFlag'] = ivrmirPReportFlag;
    data['ivrmirP_SearchFlag'] = ivrmirPSearchFlag;
    data['ivrmirP_ProcessFlag'] = ivrmirPProcessFlag;
    data['ivrmrmaP_Id'] = ivrmrmaPId;
    if (staffmobileappprivileges != null) {
      data['staffmobileappprivileges'] = staffmobileappprivileges!.toJson();
    }
    if (counterNameModel != null) {
      data['cm_usercounterdeatils'] = counterNameModel!.toJson();
    }
    data['cutoffdate'] = cutoffdate;
    data['subscriptionenddate'] = subscriptionenddate;
    data['subscriptionFlag'] = subscriptionFlag;
    if (institutionlist != null) {
      data['institutionlist'] = institutionlist!.toJson();
    }
    data['asmaY_Year'] = asmaYYear;
    data['flag'] = flag;
    data['clsnme'] = clsnme;
    data['dob'] = dob;
    data['mobno'] = mobno;
    data['studname'] = studname;
    data['payment'] = payment;
    data['registration'] = registration;
    data['roleforlogin'] = roleforlogin;
    data['empcode'] = empcode;
    data['mI_Idforlogin'] = mIIdforlogin;
    data['paymentNootificationGeneral'] = paymentNootificationGeneral;
    data['roleTypeId'] = roleTypeId;
    data['emp_Id'] = empId;
    data['ivrmumalP_AddFlg'] = ivrmumalPAddFlg;
    data['ivrmumalP_UpdateFlg'] = ivrmumalPUpdateFlg;
    data['ivrmumalP_DeleteFlg'] = ivrmumalPDeleteFlg;
    data['almsT_Id'] = almsTId;
    data['mI_BackgroundImage'] = mIBackgroundImage;
    data['mI_Logo'] = mILogo;
    if (institutedetails != null) {
      data['institutedetails'] = institutedetails!.toJson();
    }
    data['asmcL_ClassName'] = asmcLClassName;
    data['asmS_SectionName'] = asmSSectionName;
    data['hrmE_EmployeeCode'] = hrmEEmployeeCode;

    return data;
  }
}

class MiIdList {
  int? mIId;

  MiIdList({this.mIId});

  MiIdList.fromJson(Map<String, dynamic> json) {
    mIId = json['mI_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['mI_Id'] = mIId;
    return data;
  }
}

class Staffmobileappprivileges {
  String? type;
  List<LoginValues>? values;

  Staffmobileappprivileges({this.type, this.values});

  Staffmobileappprivileges.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <LoginValues>[];
      json['\$values'].forEach((v) {
        values!.add(LoginValues.fromJson(v));
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

class LoginValues {
  int? amsTId;
  int? smscreditalert;
  bool? smsalrtflag;
  int? roleId;
  bool? isLogged;
  int? amaYActiveFlag;
  int? asmaYOrder;
  int? userId;
  int? rcredit;
  int? ivrMMOId;
  int? asmaYId;
  int? imfYId;
  int? role;
  int? ivrmimPId;
  int? mIID;
  int? pageId;
  bool? ivrmirPAddFlag;
  bool? ivrmirPUpdateFlag;
  bool? ivrmirPDeleteFlag;
  bool? ivrmirPReportFlag;
  bool? ivrmirPSearchFlag;
  bool? ivrmirPProcessFlag;
  String? pagename;
  String? pageicon;
  String? pageurl;
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
  bool? ivrmmaPAddFlg;
  bool? ivrmmaPUpdateFlg;
  bool? ivrmmaPDeleteFlg;
  bool? ivrmumalPAddFlg;
  bool? ivrmumalPUpdateFlg;
  bool? ivrmumalPDeleteFlg;
  int? almsTId;

  LoginValues(
      {this.amsTId,
      this.smscreditalert,
      this.smsalrtflag,
      this.roleId,
      this.isLogged,
      this.amaYActiveFlag,
      this.asmaYOrder,
      this.userId,
      this.rcredit,
      this.ivrMMOId,
      this.asmaYId,
      this.imfYId,
      this.role,
      this.ivrmimPId,
      this.mIID,
      this.pageId,
      this.ivrmirPAddFlag,
      this.ivrmirPUpdateFlag,
      this.ivrmirPDeleteFlag,
      this.ivrmirPReportFlag,
      this.ivrmirPSearchFlag,
      this.ivrmirPProcessFlag,
      this.pagename,
      this.pageicon,
      this.pageurl,
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
      this.ivrmmaPAddFlg,
      this.ivrmmaPUpdateFlg,
      this.ivrmmaPDeleteFlg,
      this.ivrmumalPAddFlg,
      this.ivrmumalPUpdateFlg,
      this.ivrmumalPDeleteFlg,
      this.almsTId});

  LoginValues.fromJson(Map<String, dynamic> json) {
    amsTId = json['amsT_Id'];
    smscreditalert = json['smscreditalert'];
    smsalrtflag = json['smsalrtflag'];
    roleId = json['roleId'];
    isLogged = json['isLogged'];
    amaYActiveFlag = json['amaY_ActiveFlag'];
    asmaYOrder = json['asmaY_Order'];
    userId = json['userId'];
    rcredit = json['rcredit'];
    ivrMMOId = json['ivrM_MO_Id'];
    asmaYId = json['asmaY_Id'];
    imfYId = json['imfY_Id'];
    role = json['role'];
    ivrmimPId = json['ivrmimP_Id'];
    mIID = json['mI_ID'];
    pageId = json['pageId'];
    ivrmirPAddFlag = json['ivrmirP_AddFlag'];
    ivrmirPUpdateFlag = json['ivrmirP_UpdateFlag'];
    ivrmirPDeleteFlag = json['ivrmirP_DeleteFlag'];
    ivrmirPReportFlag = json['ivrmirP_ReportFlag'];
    ivrmirPSearchFlag = json['ivrmirP_SearchFlag'];
    ivrmirPProcessFlag = json['ivrmirP_ProcessFlag'];
    pagename = json['pagename'];
    pageicon = json['pageicon'];
    pageurl = json['pageurl'];
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
    ivrmmaPAddFlg = json['ivrmmaP_AddFlg'];
    ivrmmaPUpdateFlg = json['ivrmmaP_UpdateFlg'];
    ivrmmaPDeleteFlg = json['ivrmmaP_DeleteFlg'];
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
    data['ivrM_MO_Id'] = ivrMMOId;
    data['asmaY_Id'] = asmaYId;
    data['imfY_Id'] = imfYId;
    data['role'] = role;
    data['ivrmimP_Id'] = ivrmimPId;
    data['mI_ID'] = mIID;
    data['pageId'] = pageId;
    data['ivrmirP_AddFlag'] = ivrmirPAddFlag;
    data['ivrmirP_UpdateFlag'] = ivrmirPUpdateFlag;
    data['ivrmirP_DeleteFlag'] = ivrmirPDeleteFlag;
    data['ivrmirP_ReportFlag'] = ivrmirPReportFlag;
    data['ivrmirP_SearchFlag'] = ivrmirPSearchFlag;
    data['ivrmirP_ProcessFlag'] = ivrmirPProcessFlag;
    data['pagename'] = pagename;
    data['pageicon'] = pageicon;
    data['pageurl'] = pageurl;
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
    data['ivrmmaP_AddFlg'] = ivrmmaPAddFlg;
    data['ivrmmaP_UpdateFlg'] = ivrmmaPUpdateFlg;
    data['ivrmmaP_DeleteFlg'] = ivrmmaPDeleteFlg;
    data['ivrmumalP_AddFlg'] = ivrmumalPAddFlg;
    data['ivrmumalP_UpdateFlg'] = ivrmumalPUpdateFlg;
    data['ivrmumalP_DeleteFlg'] = ivrmumalPDeleteFlg;
    data['almsT_Id'] = almsTId;
    return data;
  }
}

class Institutedetails {
  Institutedetails({
    this.type,
    this.values,
  });

  Institutedetails.fromJson(dynamic json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = [];
      json['\$values'].forEach((v) {
        values?.add(InstitutedetailsValues.fromJson(v));
      });
    }
  }

  String? type;
  List<InstitutedetailsValues>? values;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['\$type'] = type;
    if (values != null) {
      map['\$values'] = values?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class InstitutedetailsValues {
  InstitutedetailsValues({
    this.mIId,
    this.mOId,
    this.mIName,
    this.mIType,
    this.mIAddress1,
    this.mIAddress2,
    this.mIAddress3,
    this.ivrmmcTName,
    this.ivrmmSId,
    this.ivrmmCId,
    this.mIPincode,
    this.mIBackgroundImage,
    this.mIFormColor,
    this.mIFontColor,
    this.mIFontSize,
    this.mIWeekStartDay,
    this.mIDateFormat,
    this.mIDateSeparator,
    this.mILogo,
    this.mIActiveFlag,
    this.mIFranchiseFlag,
    this.mIAffiliation,
    this.mISubdomain,
    this.mIAboutInstitute,
    this.mIContactDetails,
    this.mIHelpFile,
    this.mISchoolCollegeFlag,
    this.mINAACInstitutionTypeFlg,
    this.mINAACSubInstitutionTypeFlg,
    this.mIVCStudentFlag,
    this.mIVCOthersFlag,
    this.mIMSTeamsClientId,
    this.mIMSTeamsTenentId,
    this.mIMSTemasClinetSecretCode,
    this.mIMSTeamsAppAccessTockenURL,
    this.mIMSTeamsUserAceessTockenURL,
    this.mIMSTeamsMeetingScheduleURL,
    this.mIMSTeamsAdminUsername,
    this.mIMSTeamsAdminPassword,
    this.mIMSTeamsScope,
    this.mIMSTeamsGrantType,
    this.mISMSAlertToemailids,
    this.mIWhatsAppTextUrl,
    this.mIWhatsAppImageUrl,
    this.mIWhatsAppPdfUrl,
    this.mIWhatsAppVideoUrl,
    this.mIEntityId,
    this.createdDate,
    this.updatedDate,
  });

  InstitutedetailsValues.fromJson(dynamic json) {
    mIId = json['mI_Id'];
    mOId = json['mO_Id'];
    mIName = json['mI_Name'];
    mIType = json['mI_Type'];
    mIAddress1 = json['mI_Address1'];
    mIAddress2 = json['mI_Address2'];
    mIAddress3 = json['mI_Address3'];
    ivrmmcTName = json['ivrmmcT_Name'];
    ivrmmSId = json['ivrmmS_Id'];
    ivrmmCId = json['ivrmmC_Id'];
    mIPincode = json['mI_Pincode'];
    mIBackgroundImage = json['mI_BackgroundImage'];
    mIFormColor = json['mI_FormColor'];
    mIFontColor = json['mI_FontColor'];
    mIFontSize = json['mI_FontSize'];
    mIWeekStartDay = json['mI_WeekStartDay'];
    mIDateFormat = json['mI_DateFormat'];
    mIDateSeparator = json['mI_DateSeparator'];
    mILogo = json['mI_Logo'];
    mIActiveFlag = json['mI_ActiveFlag'];
    mIFranchiseFlag = json['mI_FranchiseFlag'];
    mIAffiliation = json['mI_Affiliation'];
    mISubdomain = json['mI_Subdomain'];
    mIAboutInstitute = json['mI_AboutInstitute'];
    mIContactDetails = json['mI_ContactDetails'];
    mIHelpFile = json['mI_HelpFile'];
    mISchoolCollegeFlag = json['mI_SchoolCollegeFlag'];
    mINAACInstitutionTypeFlg = json['mI_NAAC_InstitutionTypeFlg'];
    mINAACSubInstitutionTypeFlg = json['mI_NAAC_SubInstitutionTypeFlg'];
    mIVCStudentFlag = json['mI_VCStudentFlag'];
    mIVCOthersFlag = json['mI_VCOthersFlag'];
    mIMSTeamsClientId = json['mI_MSTeamsClientId'];
    mIMSTeamsTenentId = json['mI_MSTeamsTenentId'];
    mIMSTemasClinetSecretCode = json['mI_MSTemasClinetSecretCode'];
    mIMSTeamsAppAccessTockenURL = json['mI_MSTeamsAppAccessTockenURL'];
    mIMSTeamsUserAceessTockenURL = json['mI_MSTeamsUserAceessTockenURL'];
    mIMSTeamsMeetingScheduleURL = json['mI_MSTeamsMeetingScheduleURL'];
    mIMSTeamsAdminUsername = json['mI_MSTeamsAdminUsername'];
    mIMSTeamsAdminPassword = json['mI_MSTeamsAdminPassword'];
    mIMSTeamsScope = json['mI_MSTeamsScope'];
    mIMSTeamsGrantType = json['mI_MSTeamsGrantType'];
    mISMSAlertToemailids = json['mI_SMSAlertToemailids'];
    mIWhatsAppTextUrl = json['mI_WhatsAppTextUrl'];
    mIWhatsAppImageUrl = json['mI_WhatsAppImageUrl'];
    mIWhatsAppPdfUrl = json['mI_WhatsAppPdfUrl'];
    mIWhatsAppVideoUrl = json['mI_WhatsAppVideoUrl'];
    mIEntityId = json['mI_EntityId'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  num? mIId;
  num? mOId;
  String? mIName;
  String? mIType;
  String? mIAddress1;
  String? mIAddress2;
  String? mIAddress3;
  String? ivrmmcTName;
  num? ivrmmSId;
  num? ivrmmCId;
  num? mIPincode;
  String? mIBackgroundImage;
  String? mIFormColor;
  String? mIFontColor;
  num? mIFontSize;
  String? mIWeekStartDay;
  String? mIDateFormat;
  String? mIDateSeparator;
  String? mILogo;
  num? mIActiveFlag;
  num? mIFranchiseFlag;
  String? mIAffiliation;
  String? mISubdomain;
  String? mIAboutInstitute;
  String? mIContactDetails;
  String? mIHelpFile;
  String? mISchoolCollegeFlag;
  String? mINAACInstitutionTypeFlg;
  String? mINAACSubInstitutionTypeFlg;
  String? mIVCStudentFlag;
  String? mIVCOthersFlag;
  String? mIMSTeamsClientId;
  String? mIMSTeamsTenentId;
  String? mIMSTemasClinetSecretCode;
  String? mIMSTeamsAppAccessTockenURL;
  String? mIMSTeamsUserAceessTockenURL;
  String? mIMSTeamsMeetingScheduleURL;
  String? mIMSTeamsAdminUsername;
  String? mIMSTeamsAdminPassword;
  String? mIMSTeamsScope;
  String? mIMSTeamsGrantType;
  String? mISMSAlertToemailids;
  String? mIWhatsAppTextUrl;
  String? mIWhatsAppImageUrl;
  String? mIWhatsAppPdfUrl;
  String? mIWhatsAppVideoUrl;
  String? mIEntityId;
  String? createdDate;
  String? updatedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mI_Id'] = mIId;
    map['mO_Id'] = mOId;
    map['mI_Name'] = mIName;
    map['mI_Type'] = mIType;
    map['mI_Address1'] = mIAddress1;
    map['mI_Address2'] = mIAddress2;
    map['mI_Address3'] = mIAddress3;
    map['ivrmmcT_Name'] = ivrmmcTName;
    map['ivrmmS_Id'] = ivrmmSId;
    map['ivrmmC_Id'] = ivrmmCId;
    map['mI_Pincode'] = mIPincode;
    map['mI_BackgroundImage'] = mIBackgroundImage;
    map['mI_FormColor'] = mIFormColor;
    map['mI_FontColor'] = mIFontColor;
    map['mI_FontSize'] = mIFontSize;
    map['mI_WeekStartDay'] = mIWeekStartDay;
    map['mI_DateFormat'] = mIDateFormat;
    map['mI_DateSeparator'] = mIDateSeparator;
    map['mI_Logo'] = mILogo;
    map['mI_ActiveFlag'] = mIActiveFlag;
    map['mI_FranchiseFlag'] = mIFranchiseFlag;
    map['mI_Affiliation'] = mIAffiliation;
    map['mI_Subdomain'] = mISubdomain;
    map['mI_AboutInstitute'] = mIAboutInstitute;
    map['mI_ContactDetails'] = mIContactDetails;
    map['mI_HelpFile'] = mIHelpFile;
    map['mI_SchoolCollegeFlag'] = mISchoolCollegeFlag;
    map['mI_NAAC_InstitutionTypeFlg'] = mINAACInstitutionTypeFlg;
    map['mI_NAAC_SubInstitutionTypeFlg'] = mINAACSubInstitutionTypeFlg;
    map['mI_VCStudentFlag'] = mIVCStudentFlag;
    map['mI_VCOthersFlag'] = mIVCOthersFlag;
    map['mI_MSTeamsClientId'] = mIMSTeamsClientId;
    map['mI_MSTeamsTenentId'] = mIMSTeamsTenentId;
    map['mI_MSTemasClinetSecretCode'] = mIMSTemasClinetSecretCode;
    map['mI_MSTeamsAppAccessTockenURL'] = mIMSTeamsAppAccessTockenURL;
    map['mI_MSTeamsUserAceessTockenURL'] = mIMSTeamsUserAceessTockenURL;
    map['mI_MSTeamsMeetingScheduleURL'] = mIMSTeamsMeetingScheduleURL;
    map['mI_MSTeamsAdminUsername'] = mIMSTeamsAdminUsername;
    map['mI_MSTeamsAdminPassword'] = mIMSTeamsAdminPassword;
    map['mI_MSTeamsScope'] = mIMSTeamsScope;
    map['mI_MSTeamsGrantType'] = mIMSTeamsGrantType;
    map['mI_SMSAlertToemailids'] = mISMSAlertToemailids;
    map['mI_WhatsAppTextUrl'] = mIWhatsAppTextUrl;
    map['mI_WhatsAppImageUrl'] = mIWhatsAppImageUrl;
    map['mI_WhatsAppPdfUrl'] = mIWhatsAppPdfUrl;
    map['mI_WhatsAppVideoUrl'] = mIWhatsAppVideoUrl;
    map['mI_EntityId'] = mIEntityId;
    map['createdDate'] = createdDate;
    map['updatedDate'] = updatedDate;
    return map;
  }
}

class InstituteDetails {
  String? type;
  List<InstituteDetailsValues>? values;

  InstituteDetails({this.type, this.values});

  InstituteDetails.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <InstituteDetailsValues>[];
      json['\$values'].forEach((v) {
        values!.add(InstituteDetailsValues.fromJson(v));
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

class InstituteDetailsValues {
  String? type;
  int? mIId;
  int? mOId;
  String? mIName;
  String? mIType;
  String? mIAddress1;
  String? mIAddress2;
  String? mIAddress3;
  dynamic mIAddressArea;
  String? iVRMMCTName;
  int? iVRMMSId;
  int? iVRMMCId;
  int? mIPincode;
  dynamic mIFaxNo;
  String? mIBackgroundImage;
  String? mIFormColor;
  String? mIFontColor;
  int? mIFontSize;
  String? mIWeekStartDay;
  String? mIDateFormat;
  String? mIDateSeparator;
  String? mILogo;
  dynamic mIPrecision;
  dynamic mIGradingSystem;
  dynamic mIPasswordFlag;
  int? mIActiveFlag;
  String? mIAffiliation;
  String? mISubdomain;
  int? mIFranchiseFlag;
  String? mIAboutInstitute;
  String? mIContactDetails;
  String? mIHelpFile;
  String? mISchoolCollegeFlag;
  dynamic mIPAN;
  dynamic mITAN;
  dynamic mIGPSUserName;
  dynamic mIIVRSVirtualNo;
  dynamic mIIVRSOutboundNo;
  String? mINAACInstitutionTypeFlg;
  dynamic mIPGDisplayName;
  dynamic mIPGDisplayLogo;
  String? mINAACSubInstitutionTypeFlg;
  dynamic mIPaymentReminderAPI;
  String? mIVCStudentFlag;
  String? mIVCOthersFlag;
  dynamic mICode;
  String? mIMSTeamsClientId;
  String? mIMSTeamsTenentId;
  String? mIMSTemasClinetSecretCode;
  String? mIMSTeamsAppAccessTockenURL;
  String? mIMSTeamsUserAceessTockenURL;
  String? mIMSTeamsMeetingScheduleURL;
  String? mIMSTeamsAdminUsername;
  String? mIMSTeamsAdminPassword;
  String? mIMSTeamsScope;
  String? mIMSTeamsGrantType;
  dynamic mI80GRegNo;
  dynamic mISMSCountAlert;
  String? mISMSAlertToemailids;
  dynamic mIGSTNO;
  dynamic mICINNo;
  dynamic mIWhatsAppAudioUrl;
  String? mIWhatsAppImageUrl;
  String? mIWhatsAppPdfUrl;
  String? mIWhatsAppTextUrl;
  String? mIWhatsAppVideoUrl;
  String? mIEntityId;
  dynamic mICreatedBy;
  dynamic mIUpdatedBy;
  dynamic mIFilePath;
  dynamic mIPGRegisteredEmailId;
  int? mIMNMobileNo;
  int? mIPNPhoneNo;
  String? mIEEmailId;
  String? iVRMGCWebiste;

  InstituteDetailsValues(
      {this.type,
      this.mIId,
      this.mOId,
      this.mIName,
      this.mIType,
      this.mIAddress1,
      this.mIAddress2,
      this.mIAddress3,
      this.mIAddressArea,
      this.iVRMMCTName,
      this.iVRMMSId,
      this.iVRMMCId,
      this.mIPincode,
      this.mIFaxNo,
      this.mIBackgroundImage,
      this.mIFormColor,
      this.mIFontColor,
      this.mIFontSize,
      this.mIWeekStartDay,
      this.mIDateFormat,
      this.mIDateSeparator,
      this.mILogo,
      this.mIPrecision,
      this.mIGradingSystem,
      this.mIPasswordFlag,
      this.mIActiveFlag,
      this.mIAffiliation,
      this.mISubdomain,
      this.mIFranchiseFlag,
      this.mIAboutInstitute,
      this.mIContactDetails,
      this.mIHelpFile,
      this.mISchoolCollegeFlag,
      this.mIPAN,
      this.mITAN,
      this.mIGPSUserName,
      this.mIIVRSVirtualNo,
      this.mIIVRSOutboundNo,
      this.mINAACInstitutionTypeFlg,
      this.mIPGDisplayName,
      this.mIPGDisplayLogo,
      this.mINAACSubInstitutionTypeFlg,
      this.mIPaymentReminderAPI,
      this.mIVCStudentFlag,
      this.mIVCOthersFlag,
      this.mICode,
      this.mIMSTeamsClientId,
      this.mIMSTeamsTenentId,
      this.mIMSTemasClinetSecretCode,
      this.mIMSTeamsAppAccessTockenURL,
      this.mIMSTeamsUserAceessTockenURL,
      this.mIMSTeamsMeetingScheduleURL,
      this.mIMSTeamsAdminUsername,
      this.mIMSTeamsAdminPassword,
      this.mIMSTeamsScope,
      this.mIMSTeamsGrantType,
      this.mI80GRegNo,
      this.mISMSCountAlert,
      this.mISMSAlertToemailids,
      this.mIGSTNO,
      this.mICINNo,
      this.mIWhatsAppAudioUrl,
      this.mIWhatsAppImageUrl,
      this.mIWhatsAppPdfUrl,
      this.mIWhatsAppTextUrl,
      this.mIWhatsAppVideoUrl,
      this.mIEntityId,
      this.mICreatedBy,
      this.mIUpdatedBy,
      this.mIFilePath,
      this.mIPGRegisteredEmailId,
      this.mIMNMobileNo,
      this.mIPNPhoneNo,
      this.mIEEmailId,
      this.iVRMGCWebiste});

  InstituteDetailsValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    mIId = json['MI_Id'];
    mOId = json['MO_Id'];
    mIName = json['MI_Name'];
    mIType = json['MI_Type'];
    mIAddress1 = json['MI_Address1'];
    mIAddress2 = json['MI_Address2'];
    mIAddress3 = json['MI_Address3'];
    mIAddressArea = json['MI_AddressArea'];
    iVRMMCTName = json['IVRMMCT_Name'];
    iVRMMSId = json['IVRMMS_Id'];
    iVRMMCId = json['IVRMMC_Id'];
    mIPincode = json['MI_Pincode'];
    mIFaxNo = json['MI_FaxNo'];
    mIBackgroundImage = json['MI_BackgroundImage'];
    mIFormColor = json['MI_FormColor'];
    mIFontColor = json['MI_FontColor'];
    mIFontSize = json['MI_FontSize'];
    mIWeekStartDay = json['MI_WeekStartDay'];
    mIDateFormat = json['MI_DateFormat'];
    mIDateSeparator = json['MI_DateSeparator'];
    mILogo = json['MI_Logo'];
    mIPrecision = json['MI_Precision'];
    mIGradingSystem = json['MI_GradingSystem'];
    mIPasswordFlag = json['MI_PasswordFlag'];
    mIActiveFlag = json['MI_ActiveFlag'];
    mIAffiliation = json['MI_Affiliation'];
    mISubdomain = json['MI_Subdomain'];
    mIFranchiseFlag = json['MI_FranchiseFlag'];
    mIAboutInstitute = json['MI_AboutInstitute'];
    mIContactDetails = json['MI_ContactDetails'];
    mIHelpFile = json['MI_HelpFile'];
    mISchoolCollegeFlag = json['MI_SchoolCollegeFlag'];
    mIPAN = json['MI_PAN'];
    mITAN = json['MI_TAN'];
    mIGPSUserName = json['MI_GPSUserName'];
    mIIVRSVirtualNo = json['MI_IVRSVirtualNo'];
    mIIVRSOutboundNo = json['MI_IVRSOutboundNo'];
    mINAACInstitutionTypeFlg = json['MI_NAAC_InstitutionTypeFlg'];
    mIPGDisplayName = json['MI_PGDisplayName'];
    mIPGDisplayLogo = json['MI_PGDisplayLogo'];
    mINAACSubInstitutionTypeFlg = json['MI_NAAC_SubInstitutionTypeFlg'];
    mIPaymentReminderAPI = json['MI_PaymentReminderAPI'];
    mIVCStudentFlag = json['MI_VCStudentFlag'];
    mIVCOthersFlag = json['MI_VCOthersFlag'];
    mICode = json['MI_Code'];
    mIMSTeamsClientId = json['MI_MSTeamsClientId'];
    mIMSTeamsTenentId = json['MI_MSTeamsTenentId'];
    mIMSTemasClinetSecretCode = json['MI_MSTemasClinetSecretCode'];
    mIMSTeamsAppAccessTockenURL = json['MI_MSTeamsAppAccessTockenURL'];
    mIMSTeamsUserAceessTockenURL = json['MI_MSTeamsUserAceessTockenURL'];
    mIMSTeamsMeetingScheduleURL = json['MI_MSTeamsMeetingScheduleURL'];
    mIMSTeamsAdminUsername = json['MI_MSTeamsAdminUsername'];
    mIMSTeamsAdminPassword = json['MI_MSTeamsAdminPassword'];
    mIMSTeamsScope = json['MI_MSTeamsScope'];
    mIMSTeamsGrantType = json['MI_MSTeamsGrantType'];
    mI80GRegNo = json['MI_80GRegNo'];
    mISMSCountAlert = json['MI_SMSCountAlert'];
    mISMSAlertToemailids = json['MI_SMSAlertToemailids'];
    mIGSTNO = json['MI_GSTNO'];
    mICINNo = json['MI_CINNo'];
    mIWhatsAppAudioUrl = json['MI_WhatsAppAudioUrl'];
    mIWhatsAppImageUrl = json['MI_WhatsAppImageUrl'];
    mIWhatsAppPdfUrl = json['MI_WhatsAppPdfUrl'];
    mIWhatsAppTextUrl = json['MI_WhatsAppTextUrl'];
    mIWhatsAppVideoUrl = json['MI_WhatsAppVideoUrl'];
    mIEntityId = json['MI_EntityId'];
    mICreatedBy = json['MI_CreatedBy'];
    mIUpdatedBy = json['MI_UpdatedBy'];
    mIFilePath = json['MI_FilePath'];
    mIPGRegisteredEmailId = json['MI_PGRegisteredEmailId'];
    mIMNMobileNo = json['MIMN_MobileNo'];
    mIPNPhoneNo = json['MIPN_PhoneNo'];
    mIEEmailId = json['MIE_EmailId'];
    iVRMGCWebiste = json['IVRMGC_Webiste'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['MI_Id'] = mIId;
    data['MO_Id'] = mOId;
    data['MI_Name'] = mIName;
    data['MI_Type'] = mIType;
    data['MI_Address1'] = mIAddress1;
    data['MI_Address2'] = mIAddress2;
    data['MI_Address3'] = mIAddress3;
    data['MI_AddressArea'] = mIAddressArea;
    data['IVRMMCT_Name'] = iVRMMCTName;
    data['IVRMMS_Id'] = iVRMMSId;
    data['IVRMMC_Id'] = iVRMMCId;
    data['MI_Pincode'] = mIPincode;
    data['MI_FaxNo'] = mIFaxNo;
    data['MI_BackgroundImage'] = mIBackgroundImage;
    data['MI_FormColor'] = mIFormColor;
    data['MI_FontColor'] = mIFontColor;
    data['MI_FontSize'] = mIFontSize;
    data['MI_WeekStartDay'] = mIWeekStartDay;
    data['MI_DateFormat'] = mIDateFormat;
    data['MI_DateSeparator'] = mIDateSeparator;
    data['MI_Logo'] = mILogo;
    data['MI_Precision'] = mIPrecision;
    data['MI_GradingSystem'] = mIGradingSystem;
    data['MI_PasswordFlag'] = mIPasswordFlag;
    data['MI_ActiveFlag'] = mIActiveFlag;
    data['MI_Affiliation'] = mIAffiliation;
    data['MI_Subdomain'] = mISubdomain;
    data['MI_FranchiseFlag'] = mIFranchiseFlag;
    data['MI_AboutInstitute'] = mIAboutInstitute;
    data['MI_ContactDetails'] = mIContactDetails;
    data['MI_HelpFile'] = mIHelpFile;
    data['MI_SchoolCollegeFlag'] = mISchoolCollegeFlag;
    data['MI_PAN'] = mIPAN;
    data['MI_TAN'] = mITAN;
    data['MI_GPSUserName'] = mIGPSUserName;
    data['MI_IVRSVirtualNo'] = mIIVRSVirtualNo;
    data['MI_IVRSOutboundNo'] = mIIVRSOutboundNo;
    data['MI_NAAC_InstitutionTypeFlg'] = mINAACInstitutionTypeFlg;
    data['MI_PGDisplayName'] = mIPGDisplayName;
    data['MI_PGDisplayLogo'] = mIPGDisplayLogo;
    data['MI_NAAC_SubInstitutionTypeFlg'] = mINAACSubInstitutionTypeFlg;
    data['MI_PaymentReminderAPI'] = mIPaymentReminderAPI;
    data['MI_VCStudentFlag'] = mIVCStudentFlag;
    data['MI_VCOthersFlag'] = mIVCOthersFlag;
    data['MI_Code'] = mICode;
    data['MI_MSTeamsClientId'] = mIMSTeamsClientId;
    data['MI_MSTeamsTenentId'] = mIMSTeamsTenentId;
    data['MI_MSTemasClinetSecretCode'] = mIMSTemasClinetSecretCode;
    data['MI_MSTeamsAppAccessTockenURL'] = mIMSTeamsAppAccessTockenURL;
    data['MI_MSTeamsUserAceessTockenURL'] = mIMSTeamsUserAceessTockenURL;
    data['MI_MSTeamsMeetingScheduleURL'] = mIMSTeamsMeetingScheduleURL;
    data['MI_MSTeamsAdminUsername'] = mIMSTeamsAdminUsername;
    data['MI_MSTeamsAdminPassword'] = mIMSTeamsAdminPassword;
    data['MI_MSTeamsScope'] = mIMSTeamsScope;
    data['MI_MSTeamsGrantType'] = mIMSTeamsGrantType;
    data['MI_80GRegNo'] = mI80GRegNo;
    data['MI_SMSCountAlert'] = mISMSCountAlert;
    data['MI_SMSAlertToemailids'] = mISMSAlertToemailids;
    data['MI_GSTNO'] = mIGSTNO;
    data['MI_CINNo'] = mICINNo;
    data['MI_WhatsAppAudioUrl'] = mIWhatsAppAudioUrl;
    data['MI_WhatsAppImageUrl'] = mIWhatsAppImageUrl;
    data['MI_WhatsAppPdfUrl'] = mIWhatsAppPdfUrl;
    data['MI_WhatsAppTextUrl'] = mIWhatsAppTextUrl;
    data['MI_WhatsAppVideoUrl'] = mIWhatsAppVideoUrl;
    data['MI_EntityId'] = mIEntityId;
    data['MI_CreatedBy'] = mICreatedBy;
    data['MI_UpdatedBy'] = mIUpdatedBy;
    data['MI_FilePath'] = mIFilePath;
    data['MI_PGRegisteredEmailId'] = mIPGRegisteredEmailId;
    data['MIMN_MobileNo'] = mIMNMobileNo;
    data['MIPN_PhoneNo'] = mIPNPhoneNo;
    data['MIE_EmailId'] = mIEEmailId;
    return data;
  }
}

class CounterNameModel {
  String? type;
  List<CounterNameModelValues>? values;

  CounterNameModel({this.type, this.values});

  CounterNameModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <CounterNameModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(CounterNameModelValues.fromJson(v));
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

class CounterNameModelValues {
  String? type;
  int? cMMCOId;
  String? cMMCOCounterName;

  CounterNameModelValues({this.type, this.cMMCOId, this.cMMCOCounterName});

  CounterNameModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    cMMCOId = json['CMMCO_Id'];
    cMMCOCounterName = json['CMMCO_CounterName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['CMMCO_Id'] = cMMCOId;
    data['CMMCO_CounterName'] = cMMCOCounterName;
    return data;
  }
}
