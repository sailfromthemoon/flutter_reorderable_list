class ApiTraining {
  final int id;
  final int order;
  final String orderPrefix;

  ApiTraining({
    required this.id,
    required this.order,
    required this.orderPrefix,
  });

  ApiTraining.fromApi(Map<String, dynamic> map)
      : id = map['id'],
        order = map['order'],
        orderPrefix = map['order_prefix'];

  @override
  String toString() =>
      'ApiTraining(id: $id, order: $order, orderPrefix: $orderPrefix)';
}
