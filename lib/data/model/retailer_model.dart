class RetailerModel {
  bool? success;
  String? message;
  RetailerData? data;

  RetailerModel({this.success, this.message, this.data});

  RetailerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? RetailerData.fromJson(json['data']) : null;
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

class RetailerData {
  int? id;
  String? fullName;
  String? shopName;
  String? phoneNumber;
  String? address;
  bool? isActive;
  String? currentBalance;
  String? balanceStatus;
  int? totalCredit;
  int? totalDebit;
  List<LedgerEntry>? ledgerEntries;
  String? createdAt;
  String? updatedAt;

  RetailerData({
    this.id,
    this.fullName,
    this.shopName,
    this.phoneNumber,
    this.address,
    this.isActive,
    this.currentBalance,
    this.balanceStatus,
    this.totalCredit,
    this.totalDebit,
    this.ledgerEntries,
    this.createdAt,
    this.updatedAt,
  });

  RetailerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['full_name'];
    shopName = json['shop_name'];
    phoneNumber = json['phone_number'];
    address = json['address'];
    isActive = json['is_active'];
    currentBalance = json['current_balance'];
    balanceStatus = json['balance_status'];
    totalCredit = json['total_credit'];
    totalDebit = json['total_debit'];
    if (json['ledger_entries'] != null) {
      ledgerEntries = <LedgerEntry>[];
      json['ledger_entries'].forEach((v) {
        ledgerEntries!.add(LedgerEntry.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['full_name'] = fullName;
    data['shop_name'] = shopName;
    data['phone_number'] = phoneNumber;
    data['address'] = address;
    data['is_active'] = isActive;
    data['current_balance'] = currentBalance;
    data['balance_status'] = balanceStatus;
    data['total_credit'] = totalCredit;
    data['total_debit'] = totalDebit;
    if (ledgerEntries != null) {
      data['ledger_entries'] = ledgerEntries!.map((v) => v.toJson()).toList();
    }
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  // Helper getters
  String get initial => (fullName ?? "R").isNotEmpty ? (fullName ?? "R")[0].toUpperCase() : "R";
  
  String get formattedBalance {
    if (currentBalance == null || currentBalance!.isEmpty) return "0";
    try {
      double value = double.parse(currentBalance!);
      if (value == value.roundToDouble()) {
        return value.toInt().toString().replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},');
      }
      return value.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},');
    } catch (e) {
      return currentBalance!;
    }
  }

  String _formatAmount(int? amount) {
    if (amount == null) return "0";
    return amount.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]},');
  }

  String get formattedTotalCredit => _formatAmount(totalCredit);
  String get formattedTotalDebit => _formatAmount(totalDebit);

  bool get isDue => balanceStatus == 'due';
  bool get isPaid => balanceStatus == 'paid';
  bool get isClear => balanceStatus == 'clear';

  int get totalEntries => ledgerEntries?.length ?? 0;
  int get creditEntries => ledgerEntries?.where((e) => e.entryType == 'credit').length ?? 0;
  int get debitEntries => ledgerEntries?.where((e) => e.entryType == 'debit').length ?? 0;
}

// Ledger Entry model
class LedgerEntry {
  int? id;
  String? entryType;
  String? amount;
  String? description;
  String? note;
  String? createdAt;
  String? updatedAt;

  LedgerEntry({
    this.id,
    this.entryType,
    this.amount,
    this.description,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  LedgerEntry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entryType = json['entry_type'];
    amount = json['amount'];
    description = json['description'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['entry_type'] = entryType;
    data['amount'] = amount;
    data['description'] = description;
    data['note'] = note;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  // Helper getters
  bool get isCredit => entryType == 'credit';
  bool get isDebit => entryType == 'debit';

  String get formattedAmount {
    if (amount == null || amount!.isEmpty) return "0";
    try {
      double value = double.parse(amount!);
      if (value == value.roundToDouble()) {
        return value.toInt().toString().replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},');
      }
      return value.toStringAsFixed(2).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},');
    } catch (e) {
      return amount!;
    }
  }

  String get formattedDate {
    if (createdAt == null) return "";
    try {
      DateTime date = DateTime.parse(createdAt!);
      List<String> months = ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN', 
                             'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC'];
      return "${date.day} ${months[date.month - 1]}";
    } catch (e) {
      return "";
    }
  }
}

// Model for list of retailers
class RetailerListModel {
  bool? success;
  String? message;
  List<RetailerData>? data;

  RetailerListModel({this.success, this.message, this.data});

  RetailerListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RetailerData>[];
      json['data'].forEach((v) {
        data!.add(RetailerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
