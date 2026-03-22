class ExpenseModel {
  String? id;
  final String date;
  final double Price;
  final String Description;

  ExpenseModel({
    this.id,
    required this.date,
    required this.Price,
    required this.Description,
  });

  factory ExpenseModel.fromJson(Map<String, dynamic> Json) {
    return ExpenseModel(
      id: Json['id'],
      date: Json['date'],
      Price: (Json['Price']).toDouble(),
      Description: Json['Description'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'id': id, 'date': date, 'Price': Price, 'Description': Description};
  }
}
