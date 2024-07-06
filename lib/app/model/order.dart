class Order {
  int? _id;
  int? _count;

  Order({int? id, int? count}) {
    _id = id;
    _count = count;
  }

  int? get id => _id;

  set id(int? value) {
    _id = value;
  }

  int? get count => _count;

  set count(int? value) {
    _count = value;
  }

  @override
  String toString() {
    return 'Order{id: $_id, count: $_count}';
  }

  Map<String, dynamic> toMap() {
    return {
      'productID': id,
      'count': count,
    };
  }

}
