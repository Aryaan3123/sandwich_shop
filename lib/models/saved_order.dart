import 'package:json_annotation/json_annotation.dart';

// This part directive links to the generated file
part 'saved_order.g.dart';

// Tell the generator to create serialization logic for this class
@JsonSerializable()
class SavedOrder {
  final int id;
  final String orderId;
  final double totalAmount;
  final int itemCount;
  @JsonKey(name: 'orderDate')
  final DateTime orderDate;

  SavedOrder({
    required this.id,
    required this.orderId,
    required this.totalAmount,
    required this.itemCount,
    required this.orderDate,
  });
  // Generated code for deserialization
  factory SavedOrder.fromJson(Map<String, dynamic> json) =>
      _$SavedOrderFromJson(json);

  // Generated code for serialization
  Map<String, dynamic> toJson() => _$SavedOrderToJson(this);
}
