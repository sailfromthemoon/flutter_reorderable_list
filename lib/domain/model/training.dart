class Training {
  final int id;
  final int order;
  final String orderPrefix;
  final bool isSuperset;

  Training({
    required this.id,
    required this.order,
    required this.orderPrefix,
    required this.isSuperset,
  });

  @override
  String toString() {
    return 'Training(id: $id, order: $order, orderPrefix: $orderPrefix, isSuperset: $isSuperset)';
  }

  Training copyWith({
    int? id,
    int? order,
    String? orderPrefix,
    bool? isSuperset,
  }) {
    return Training(
      id: id ?? this.id,
      order: order ?? this.order,
      orderPrefix: orderPrefix ?? this.orderPrefix,
      isSuperset: isSuperset ?? this.isSuperset,
    );
  }
}
