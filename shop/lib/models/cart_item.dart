class CartItem {
  final String id;
  final String productId;
  final String name;
  int quantity;
  final num price;
  CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  Map<String, Object> get itemToJson {
    return {
      'id': id,
      'productId': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}
