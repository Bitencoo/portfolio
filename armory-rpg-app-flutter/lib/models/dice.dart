import 'dart:convert';

class DiceItem {
  final int sizeNumber;
  final int modifier;
  int quantity;
  DiceItem(
      {required this.sizeNumber, this.quantity = 1, required this.modifier});

  DiceItem copyWith({
    int? sizeNumber,
    int? quantity,
  }) {
    return DiceItem(
      sizeNumber: sizeNumber ?? this.sizeNumber,
      quantity: quantity ?? this.quantity,
      modifier: modifier ?? this.modifier,
    );
  }

  set sizeNumber(int sizeNumber) {
    this.sizeNumber = sizeNumber;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'sizeNumber': sizeNumber});
    result.addAll({'quantity': quantity});
    result.addAll({'modifier': modifier});

    return result;
  }

  factory DiceItem.fromMap(Map<String, dynamic> map) {
    return DiceItem(
      sizeNumber: map['sizeNumber']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      modifier: map['modifier']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory DiceItem.fromJson(String source) =>
      DiceItem.fromMap(json.decode(source));

  @override
  String toString() =>
      'DiceItem(sizeNumber: $sizeNumber, quantity: $quantity, modifier: $modifier)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DiceItem &&
        other.sizeNumber == sizeNumber &&
        other.modifier == modifier &&
        other.quantity == quantity;
  }

  @override
  int get hashCode =>
      sizeNumber.hashCode ^ modifier.hashCode ^ quantity.hashCode;
}
