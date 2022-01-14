class ExtTrainingList {
  final int order;
  final List<ExtTraining> superset;

  ExtTrainingList({
    required this.order,
    required this.superset,
  });

  ExtTrainingList copyWith({
    int? order,
    List<ExtTraining>? superset,
  }) {
    return ExtTrainingList(
      order: order ?? this.order,
      superset: superset ?? this.superset,
    );
  }

  @override
  String toString() => 'ExtTrainingList(order: $order, superset: $superset)';
}

class ExtTraining {
  final int id;
  final String orderPrefix;

  ExtTraining({
    required this.id,
    required this.orderPrefix,
  });

  ExtTraining copyWith({
    int? id,
    String? orderPrefix,
  }) {
    return ExtTraining(
      id: id ?? this.id,
      orderPrefix: orderPrefix ?? this.orderPrefix,
    );
  }

  @override
  String toString() => 'ExtTraining(id: $id, orderPrefix: $orderPrefix)';
}
