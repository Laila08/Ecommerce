class CartModel {
  final String cartId;
  final String productId;
  final String productImage;
  final String productName;
  final int productPrice;
  final int quantity;
  final int productDiscount;
  final String size;
  final String color;

  CartModel({
    required this.productId,
    required this.productImage,
    required this.productName,
    required this.productPrice,
    this.quantity = 1,
    this.productDiscount = 0,
    required this.size,
    this.color = "Black",
    required this.cartId,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'cartId': cartId,
      'productImage': productImage,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'productDiscount': productDiscount,
      'size': size,
      'color': color,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map, String documentid) {
    return CartModel(
      productId: documentid,
      productImage: map['productImage'] as String,
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as int,
      quantity: map['quantity'] as int,
      productDiscount: map['productDiscount'] as int,
      size: map['size'] as String,
      color: map['color'] as String,
      cartId: map['cartId'] as String,
    );
  }

  CartModel copyWith({
    String? cartId,
    String? productId,
    String? productImage,
    String? productName,
    int? productPrice,
    int? quantity,
    int? productDiscount,
    String? size,
    String? color,
  }) {
    return CartModel(
      cartId: cartId ?? this.cartId,
      productId: productId ?? this.productId,
      productImage: productImage ?? this.productImage,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      quantity: quantity ?? this.quantity,
      productDiscount: productDiscount ?? this.productDiscount,
      size: size ?? this.size,
      color: color ?? this.color,
    );
  }
}
