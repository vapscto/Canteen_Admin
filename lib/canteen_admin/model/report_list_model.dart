class ReportListModel {
  String? type;
  List<ReportListModelValues>? values;

  ReportListModel({this.type, this.values});

  ReportListModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <ReportListModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(ReportListModelValues.fromJson(v));
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

class ReportListModelValues {
  String? type;
  String? mIName;
  String? mILogo;
  String? address;
  String? cMMFIFoodItemName;
  double? totalQuantity;
  double? totalAmount;
  String? orderedDate;
  String? categoryName;
  String? cMMCOCounterName;

  ReportListModelValues(
      {this.type,
        this.mIName,
        this.mILogo,
        this.address,
        this.cMMFIFoodItemName,
        this.totalQuantity,
        this.totalAmount,
        this.orderedDate,
        this.categoryName,
        this.cMMCOCounterName});

  ReportListModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    mIName = json['MI_Name'];
    mILogo = json['MI_Logo'];
    address = json['Address'];
    cMMFIFoodItemName = json['CMMFI_FoodItemName'];
    totalQuantity = json['Total_Quantity'];
    totalAmount = json['Total_Amount'];
    orderedDate = json['Ordered_Date'];
    categoryName = json['Category_Name'];
    cMMCOCounterName = json['CMMCO_CounterName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['MI_Name'] = mIName;
    data['MI_Logo'] = mILogo;
    data['Address'] = address;
    data['CMMFI_FoodItemName'] = cMMFIFoodItemName;
    data['Total_Quantity'] = totalQuantity;
    data['Total_Amount'] = totalAmount;
    data['Ordered_Date'] = orderedDate;
    data['Category_Name'] = categoryName;
    data['CMMCO_CounterName'] = cMMCOCounterName;
    return data;
  }
}
