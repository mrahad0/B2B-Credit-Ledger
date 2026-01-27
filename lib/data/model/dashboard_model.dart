class DashboardModel {
  bool? success;
  String? message;
  DashboardData? data;

  DashboardModel({this.success, this.message, this.data});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? DashboardData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DashboardData {
  String? totalOutstanding;
  int? totalRetailers;
  int? activeRetailers;
  String? totalDue;
  String? totalPaid;
  int? retailersWithDue;
  int? retailersWithPaid;

  DashboardData({
    this.totalOutstanding,
    this.totalRetailers,
    this.activeRetailers,
    this.totalDue,
    this.totalPaid,
    this.retailersWithDue,
    this.retailersWithPaid,
  });

  DashboardData.fromJson(Map<String, dynamic> json) {
    totalOutstanding = json['total_outstanding'];
    totalRetailers = json['total_retailers'];
    activeRetailers = json['active_retailers'];
    totalDue = json['total_due'];
    totalPaid = json['total_paid'];
    retailersWithDue = json['retailers_with_due'];
    retailersWithPaid = json['retailers_with_paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_outstanding'] = totalOutstanding;
    data['total_retailers'] = totalRetailers;
    data['active_retailers'] = activeRetailers;
    data['total_due'] = totalDue;
    data['total_paid'] = totalPaid;
    data['retailers_with_due'] = retailersWithDue;
    data['retailers_with_paid'] = retailersWithPaid;
    return data;
  }

  // Helper method to format amount for display
  String get formattedTotalOutstanding => _formatAmount(totalOutstanding);
  String get formattedTotalDue => _formatAmount(totalDue);
  String get formattedTotalPaid => _formatAmount(totalPaid);

  String _formatAmount(String? amount) {
    if (amount == null || amount.isEmpty) return "0";
    // Parse and format the amount
    try {
      double value = double.parse(amount);
      if (value == value.roundToDouble()) {
        return value.toInt().toString().replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},');
      }
      return value.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},');
    } catch (e) {
      return amount;
    }
  }
}
