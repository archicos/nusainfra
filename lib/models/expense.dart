class Expense {
  final int id;
  final String name;
  final int categoryId;
  final double amount;
  final DateTime time;

  Expense(
      {required this.id,
      required this.name,
      required this.categoryId,
      required this.amount,
      required this.time});

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      name: json['name'],
      categoryId: json['category_id'],
      amount: double.parse(json['amount']),
      time: DateTime.parse(json['time']),
    );
  }
}
