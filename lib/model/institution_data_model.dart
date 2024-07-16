import 'dart:convert';

import 'category_model.dart';


class InstitutionalCodeModel {
  final int pageid;
  final int rcredit;
  final int paymentNootificationGeneral;
  final int smscreditalert;
  final int pageId;
  final int roleId;
  final int ivrMMOId;
  final String prestartdate;
  final String presenddate;
  final int ivrMMIId;
  final bool ivrmrPAddFlag;
  final bool smsalrtflag;
  final bool ivrmrPUpdateFlag;
  final bool ivrmrPDeleteFlag;
  final bool ivrmrPProcessFlag;
  final bool ivrmrPReportFlag;
  final int asmaYId;
  final int asmcLId;
  final int pamsTId;
  final int pasrapSID;
  final int role;
  final int userId;
  final int count;
  final int amCId;
  final int smsmobileno;
  final int acayearid;
  final int acaclsid;
  final int miId;
  final int virtualid;
  final int amstId;
  final bool payment;
  final bool registration;
  final bool smscheck;
  final bool emailcheck;
  final bool defaultsmsemail;
  final int institutionid;
  final int apIID;
  final CategoriesApiArrayModel apiarray;
  final String institutecode;
  final String institutioNNAME;
  final String institutioNLOGO;
  final bool noint;
  final int amcOId;
  final int pacAId;
  InstitutionalCodeModel({
    required this.pageid,
    required this.rcredit,
    required this.paymentNootificationGeneral,
    required this.smscreditalert,
    required this.pageId,
    required this.roleId,
    required this.ivrMMOId,
    required this.prestartdate,
    required this.presenddate,
    required this.ivrMMIId,
    required this.ivrmrPAddFlag,
    required this.smsalrtflag,
    required this.ivrmrPUpdateFlag,
    required this.ivrmrPDeleteFlag,
    required this.ivrmrPProcessFlag,
    required this.ivrmrPReportFlag,
    required this.asmaYId,
    required this.asmcLId,
    required this.pamsTId,
    required this.pasrapSID,
    required this.role,
    required this.userId,
    required this.count,
    required this.amCId,
    required this.smsmobileno,
    required this.acayearid,
    required this.acaclsid,
    required this.miId,
    required this.virtualid,
    required this.amstId,
    required this.payment,
    required this.registration,
    required this.smscheck,
    required this.emailcheck,
    required this.defaultsmsemail,
    required this.institutionid,
    required this.apIID,
    required this.apiarray,
    required this.institutecode,
    required this.institutioNNAME,
    required this.institutioNLOGO,
    required this.noint,
    required this.amcOId,
    required this.pacAId,
  });

  InstitutionalCodeModel copyWith({
    int? pageid,
    int? rcredit,
    int? paymentNootificationGeneral,
    int? smscreditalert,
    int? pageId,
    int? roleId,
    int? ivrMMOId,
    String? prestartdate,
    String? presenddate,
    int? ivrMMIId,
    bool? ivrmrPAddFlag,
    bool? smsalrtflag,
    bool? ivrmrPUpdateFlag,
    bool? ivrmrPDeleteFlag,
    bool? ivrmrPProcessFlag,
    bool? ivrmrPReportFlag,
    int? asmaYId,
    int? asmcLId,
    int? pamsTId,
    int? pasrapSID,
    int? role,
    int? userId,
    int? count,
    int? amCId,
    int? smsmobileno,
    int? acayearid,
    int? acaclsid,
    int? miId,
    int? virtualid,
    int? amstId,
    bool? payment,
    bool? registration,
    bool? smscheck,
    bool? emailcheck,
    bool? defaultsmsemail,
    int? institutionid,
    int? apIID,
    CategoriesApiArrayModel? apiarray,
    String? institutecode,
    String? institutioNNAME,
    String? institutioNLOGO,
    bool? noint,
    int? amcOId,
    int? pacAId,
  }) {
    return InstitutionalCodeModel(
      pageid: pageid ?? this.pageid,
      rcredit: rcredit ?? this.rcredit,
      paymentNootificationGeneral:
      paymentNootificationGeneral ?? this.paymentNootificationGeneral,
      smscreditalert: smscreditalert ?? this.smscreditalert,
      pageId: pageId ?? this.pageId,
      roleId: roleId ?? this.roleId,
      ivrMMOId: ivrMMOId ?? this.ivrMMOId,
      prestartdate: prestartdate ?? this.prestartdate,
      presenddate: presenddate ?? this.presenddate,
      ivrMMIId: ivrMMIId ?? this.ivrMMIId,
      ivrmrPAddFlag: ivrmrPAddFlag ?? this.ivrmrPAddFlag,
      smsalrtflag: smsalrtflag ?? this.smsalrtflag,
      ivrmrPUpdateFlag: ivrmrPUpdateFlag ?? this.ivrmrPUpdateFlag,
      ivrmrPDeleteFlag: ivrmrPDeleteFlag ?? this.ivrmrPDeleteFlag,
      ivrmrPProcessFlag: ivrmrPProcessFlag ?? this.ivrmrPProcessFlag,
      ivrmrPReportFlag: ivrmrPReportFlag ?? this.ivrmrPReportFlag,
      asmaYId: asmaYId ?? this.asmaYId,
      asmcLId: asmcLId ?? this.asmcLId,
      pamsTId: pamsTId ?? this.pamsTId,
      pasrapSID: pasrapSID ?? this.pasrapSID,
      role: role ?? this.role,
      userId: userId ?? this.userId,
      count: count ?? this.count,
      amCId: amCId ?? this.amCId,
      smsmobileno: smsmobileno ?? this.smsmobileno,
      acayearid: acayearid ?? this.acayearid,
      acaclsid: acaclsid ?? this.acaclsid,
      miId: miId ?? this.miId,
      virtualid: virtualid ?? this.virtualid,
      amstId: amstId ?? this.amstId,
      payment: payment ?? this.payment,
      registration: registration ?? this.registration,
      smscheck: smscheck ?? this.smscheck,
      emailcheck: emailcheck ?? this.emailcheck,
      defaultsmsemail: defaultsmsemail ?? this.defaultsmsemail,
      institutionid: institutionid ?? this.institutionid,
      apIID: apIID ?? this.apIID,
      apiarray: apiarray ?? this.apiarray,
      institutecode: institutecode ?? this.institutecode,
      institutioNNAME: institutioNNAME ?? this.institutioNNAME,
      institutioNLOGO: institutioNLOGO ?? this.institutioNLOGO,
      noint: noint ?? this.noint,
      amcOId: amcOId ?? this.amcOId,
      pacAId: pacAId ?? this.pacAId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pageid': pageid,
      'rcredit': rcredit,
      'paymentNootificationGeneral': paymentNootificationGeneral,
      'smscreditalert': smscreditalert,
      'pageId': pageId,
      'roleId': roleId,
      'ivrMMOId': ivrMMOId,
      'prestartdate': prestartdate,
      'presenddate': presenddate,
      'ivrMMIId': ivrMMIId,
      'ivrmrPAddFlag': ivrmrPAddFlag,
      'smsalrtflag': smsalrtflag,
      'ivrmrPUpdateFlag': ivrmrPUpdateFlag,
      'ivrmrPDeleteFlag': ivrmrPDeleteFlag,
      'ivrmrPProcessFlag': ivrmrPProcessFlag,
      'ivrmrPReportFlag': ivrmrPReportFlag,
      'asmaYId': asmaYId,
      'asmcLId': asmcLId,
      'pamsTId': pamsTId,
      'pasrapSID': pasrapSID,
      'role': role,
      'userId': userId,
      'count': count,
      'amCId': amCId,
      'smsmobileno': smsmobileno,
      'acayearid': acayearid,
      'acaclsid': acaclsid,
      'miId': miId,
      'virtualid': virtualid,
      'amstId': amstId,
      'payment': payment,
      'registration': registration,
      'smscheck': smscheck,
      'emailcheck': emailcheck,
      'defaultsmsemail': defaultsmsemail,
      'institutionid': institutionid,
      'apIID': apIID,
      'apiarray': apiarray.toMap(),
      'institutecode': institutecode,
      'institutioNNAME': institutioNNAME,
      'institutioNLOGO': institutioNLOGO,
      'noint': noint,
      'amcOId': amcOId,
      'pacAId': pacAId,
    };
  }

  factory InstitutionalCodeModel.fromMap(Map<String, dynamic> json) {
    return InstitutionalCodeModel(
      pageid: json['pageid'],
      rcredit: json['rcredit'],
      paymentNootificationGeneral: json['paymentNootificationGeneral'],
      smscreditalert: json['smscreditalert'],
      pageId: json['pageId'],
      roleId: json['roleId'],
      ivrMMOId: json['ivrM_MO_Id'],
      prestartdate: json['prestartdate'],
      presenddate: json['presenddate'],
      ivrMMIId: json['ivrM_MI_Id'],
      ivrmrPAddFlag: json['ivrmrP_AddFlag'],
      smsalrtflag: json['smsalrtflag'],
      ivrmrPUpdateFlag: json['ivrmrP_UpdateFlag'],
      ivrmrPDeleteFlag: json['ivrmrP_DeleteFlag'],
      ivrmrPProcessFlag: json['ivrmrP_ProcessFlag'],
      ivrmrPReportFlag: json['ivrmrP_ReportFlag'],
      asmaYId: json['asmaY_Id'],
      asmcLId: json['asmcL_Id'],
      pamsTId: json['pamsT_Id'],
      pasrapSID: json['pasrapS_ID'],
      role: json['role'],
      userId: json['userId'],
      count: json['count'],
      amCId: json['amC_Id'],
      smsmobileno: json['smsmobileno'],
      acayearid: json['acayearid'],
      acaclsid: json['acaclsid'],
      miId: json['mi_id'],
      virtualid: json['virtualid'],
      amstId: json['amst_id'],
      payment: json['payment'],
      registration: json['registration'],
      smscheck: json['smscheck'],
      emailcheck: json['emailcheck'],
      defaultsmsemail: json['defaultsmsemail'],
      institutionid: json['institutionid'],
      apIID: json['apI_ID'],
      apiarray: CategoriesApiArrayModel.fromMap(
        json['apiarray'] as Map<String, dynamic>,
      ),
      institutecode: json['institutecode'],
      institutioNNAME: json['institutioN_NAME'],
      institutioNLOGO: json['institutioN_LOGO'],
      noint: json['noint'],
      amcOId: json['amcO_Id'],
      pacAId: json['pacA_Id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory InstitutionalCodeModel.fromJson(String source) =>
      InstitutionalCodeModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InstitutionalCodeModel(pageid: $pageid, rcredit: $rcredit, paymentNootificationGeneral: $paymentNootificationGeneral, smscreditalert: $smscreditalert, pageId: $pageId, roleId: $roleId, ivrMMOId: $ivrMMOId, prestartdate: $prestartdate, presenddate: $presenddate, ivrMMIId: $ivrMMIId, ivrmrPAddFlag: $ivrmrPAddFlag, smsalrtflag: $smsalrtflag, ivrmrPUpdateFlag: $ivrmrPUpdateFlag, ivrmrPDeleteFlag: $ivrmrPDeleteFlag, ivrmrPProcessFlag: $ivrmrPProcessFlag, ivrmrPReportFlag: $ivrmrPReportFlag, asmaYId: $asmaYId, asmcLId: $asmcLId, pamsTId: $pamsTId, pasrapSID: $pasrapSID, role: $role, userId: $userId, count: $count, amCId: $amCId, smsmobileno: $smsmobileno, acayearid: $acayearid, acaclsid: $acaclsid, miId: $miId, virtualid: $virtualid, amstId: $amstId, payment: $payment, registration: $registration, smscheck: $smscheck, emailcheck: $emailcheck, defaultsmsemail: $defaultsmsemail, institutionid: $institutionid, apIID: $apIID, apiarray: $apiarray, institutecode: $institutecode, institutioNNAME: $institutioNNAME, institutioNLOGO: $institutioNLOGO, noint: $noint, amcOId: $amcOId, pacAId: $pacAId)';
  }

  @override
  bool operator ==(covariant InstitutionalCodeModel other) {
    if (identical(this, other)) return true;

    return other.pageid == pageid &&
        other.rcredit == rcredit &&
        other.paymentNootificationGeneral == paymentNootificationGeneral &&
        other.smscreditalert == smscreditalert &&
        other.pageId == pageId &&
        other.roleId == roleId &&
        other.ivrMMOId == ivrMMOId &&
        other.prestartdate == prestartdate &&
        other.presenddate == presenddate &&
        other.ivrMMIId == ivrMMIId &&
        other.ivrmrPAddFlag == ivrmrPAddFlag &&
        other.smsalrtflag == smsalrtflag &&
        other.ivrmrPUpdateFlag == ivrmrPUpdateFlag &&
        other.ivrmrPDeleteFlag == ivrmrPDeleteFlag &&
        other.ivrmrPProcessFlag == ivrmrPProcessFlag &&
        other.ivrmrPReportFlag == ivrmrPReportFlag &&
        other.asmaYId == asmaYId &&
        other.asmcLId == asmcLId &&
        other.pamsTId == pamsTId &&
        other.pasrapSID == pasrapSID &&
        other.role == role &&
        other.userId == userId &&
        other.count == count &&
        other.amCId == amCId &&
        other.smsmobileno == smsmobileno &&
        other.acayearid == acayearid &&
        other.acaclsid == acaclsid &&
        other.miId == miId &&
        other.virtualid == virtualid &&
        other.amstId == amstId &&
        other.payment == payment &&
        other.registration == registration &&
        other.smscheck == smscheck &&
        other.emailcheck == emailcheck &&
        other.defaultsmsemail == defaultsmsemail &&
        other.institutionid == institutionid &&
        other.apIID == apIID &&
        other.apiarray == apiarray &&
        other.institutecode == institutecode &&
        other.institutioNNAME == institutioNNAME &&
        other.institutioNLOGO == institutioNLOGO &&
        other.noint == noint &&
        other.amcOId == amcOId &&
        other.pacAId == pacAId;
  }

  @override
  int get hashCode {
    return pageid.hashCode ^
    rcredit.hashCode ^
    paymentNootificationGeneral.hashCode ^
    smscreditalert.hashCode ^
    pageId.hashCode ^
    roleId.hashCode ^
    ivrMMOId.hashCode ^
    prestartdate.hashCode ^
    presenddate.hashCode ^
    ivrMMIId.hashCode ^
    ivrmrPAddFlag.hashCode ^
    smsalrtflag.hashCode ^
    ivrmrPUpdateFlag.hashCode ^
    ivrmrPDeleteFlag.hashCode ^
    ivrmrPProcessFlag.hashCode ^
    ivrmrPReportFlag.hashCode ^
    asmaYId.hashCode ^
    asmcLId.hashCode ^
    pamsTId.hashCode ^
    pasrapSID.hashCode ^
    role.hashCode ^
    userId.hashCode ^
    count.hashCode ^
    amCId.hashCode ^
    smsmobileno.hashCode ^
    acayearid.hashCode ^
    acaclsid.hashCode ^
    miId.hashCode ^
    virtualid.hashCode ^
    amstId.hashCode ^
    payment.hashCode ^
    registration.hashCode ^
    smscheck.hashCode ^
    emailcheck.hashCode ^
    defaultsmsemail.hashCode ^
    institutionid.hashCode ^
    apIID.hashCode ^
    apiarray.hashCode ^
    institutecode.hashCode ^
    institutioNNAME.hashCode ^
    institutioNLOGO.hashCode ^
    noint.hashCode ^
    amcOId.hashCode ^
    pacAId.hashCode;
  }
}
