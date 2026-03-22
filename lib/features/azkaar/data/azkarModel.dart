class Azkarmodel {
  final int id;
  final String category;
  final List<azkarItem> items;

  Azkarmodel({required this.id, required this.category, required this.items});

  factory Azkarmodel.fromjson(Map<String, dynamic> json) {
    return Azkarmodel(
      id: json['id'],
      category: json['category'],
      // items: json['items'],
      items:
          (json['array'] as List)
              .map((item) => azkarItem.fromjson(item))
              .toList(),
    );
  }

  operator [](int other) {}
}

class azkarItem {
  final int id;
  final String text;
  final int count;
  azkarItem({required this.id, required this.text, required this.count});

  factory azkarItem.fromjson(Map<String, dynamic> json) {
    return azkarItem(id: json['id'], text: json['text'], count: json['count']);
  }
}
