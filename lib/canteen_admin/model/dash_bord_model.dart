class DashBordModel {
  String? type;
  List<DashBordModelValues>? values;

  DashBordModel({this.type, this.values});

  DashBordModel.fromJson(Map<String, dynamic> json) {
    type = json['\$type'];
    if (json['\$values'] != null) {
      values = <DashBordModelValues>[];
      json['\$values'].forEach((v) {
        values!.add(DashBordModelValues.fromJson(v));
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

class DashBordModelValues {
  String? type;
  int? totalQtySold;
  double? totalAmount;
  int? todayTotalQtySold;
  double? todayTotalAmount;
  int? vegTotalQtySold;
  double? vegTotalAmount;
  int? nonVegTotalQtySold;
  double? nonVegTotalAmount;
  int? monthTotalQtySold;
  double? monthTotalAmount;

  DashBordModelValues(
      {this.type,
        this.totalQtySold,
        this.totalAmount,
        this.todayTotalQtySold,
        this.todayTotalAmount,
        this.vegTotalQtySold,
        this.vegTotalAmount,
        this.nonVegTotalQtySold,
        this.nonVegTotalAmount,
        this.monthTotalQtySold,
        this.monthTotalAmount});

  DashBordModelValues.fromJson(Map<String, dynamic> json) {
    type = json['$type'];
    totalQtySold = json['Total_QtySold']??0;
    totalAmount = json['Total_Amount']??0.0;
    todayTotalQtySold = json['Today_Total_QtySold']??0;
    todayTotalAmount = json['Today_Total_Amount']??0.0;
    vegTotalQtySold = json['Veg_Total_QtySold']??0;
    vegTotalAmount = json['Veg_Total_Amount']??0.0;
    nonVegTotalQtySold = json['NonVeg_Total_QtySold']??0;
    nonVegTotalAmount = json['NonVeg_Total_Amount']??0.0;
    monthTotalQtySold = json['Month_Total_QtySold']??0;
    monthTotalAmount = json['Month_Total_Amount']??0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['$type'] = type;
    data['Total_QtySold'] = totalQtySold;
    data['Total_Amount'] = totalAmount;
    data['Today_Total_QtySold'] = todayTotalQtySold;
    data['Today_Total_Amount'] = todayTotalAmount;
    data['Veg_Total_QtySold'] = vegTotalQtySold;
    data['Veg_Total_Amount'] = vegTotalAmount;
    data['NonVeg_Total_QtySold'] = nonVegTotalQtySold;
    data['NonVeg_Total_Amount'] = nonVegTotalAmount;
    data['Month_Total_QtySold'] = monthTotalQtySold;
    data['Month_Total_Amount'] = monthTotalAmount;
    return data;
  }
}
