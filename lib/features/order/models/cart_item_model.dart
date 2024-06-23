class CartItemModel {
  String productId;
  String productName;
  double price;
  int quantity;
  bool isTester;

  /// Constructor
  CartItemModel({
    required this.productId,
    required this.quantity,
    required this.isTester,
    this.price = 0.0,
    this.productName = ''
  });

  /// Empty Cart
  static CartItemModel empty() => CartItemModel(productId: '', quantity: 0, isTester: false);

  /// Convert a CartItem to a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'price': price,
      'quantity': quantity,
      'isTester': isTester,
    };
  }

  /// Create a CartItem from a JSON Map
  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      productId: json['productId'],
      productName: json['productName'],
      price: json['price']?.toDouble(),
      quantity: json['quantity'],
      isTester: json['isTester'],
    );
  }
}
