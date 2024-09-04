import 'dart:convert';

class ActionDice {
  final int sizeNumber;
  final int quantity;
  ActionDice({
    required this.sizeNumber,
    required this.quantity,
  });

  ActionDice copyWith({
    int? sizeNumber,
    int? quantity,
  }) {
    return ActionDice(
      sizeNumber: sizeNumber ?? this.sizeNumber,
      quantity: quantity ?? this.quantity,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'sizeNumber': sizeNumber});
    result.addAll({'quantity': quantity});

    return result;
  }

  factory ActionDice.fromMap(Map<String, dynamic> map) {
    return ActionDice(
      sizeNumber: map['sizeNumber']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ActionDice.fromJson(String source) =>
      ActionDice.fromMap(json.decode(source));

  @override
  String toString() =>
      'ActionDice(sizeNumber: $sizeNumber, quantity: $quantity)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ActionDice &&
        other.sizeNumber == sizeNumber &&
        other.quantity == quantity;
  }

  @override
  int get hashCode => sizeNumber.hashCode ^ quantity.hashCode;
}
