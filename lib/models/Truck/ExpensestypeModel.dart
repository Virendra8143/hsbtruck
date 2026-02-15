class ExpenseTypeModel {
  final String id;
  final String title;

  ExpenseTypeModel({
    required this.id,
    required this.title,
  });

  factory ExpenseTypeModel.fromJson(Map<String, dynamic> json) {
    return ExpenseTypeModel(
      id: json["id"].toString(),
      title: json["title"] ?? "",
    );
  }
}
