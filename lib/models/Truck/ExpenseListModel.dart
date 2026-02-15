class ExpenseListModel {
  final String id;
  final String expenseType;
  final String amount;
  final String place;
  final String remark;
  final String status;
  final String createdDate;

  ExpenseListModel({
    required this.id,
    required this.expenseType,
    required this.amount,
    required this.place,
    required this.remark,
    required this.status,
    required this.createdDate,
  });

  factory ExpenseListModel.fromJson(Map<String, dynamic> json) {
    return ExpenseListModel(
      id: json["id"].toString(),
      expenseType: json["expense_type"] ?? "",
      amount: json["amount"].toString(),
      place: json["place"] ?? "",
      remark: json["remark"] ?? "",
      status: json["status"] ?? "",
      createdDate: json["created_date"] ?? "",
    );
  }
}
