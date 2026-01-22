class ApiPath {
  static String products() => 'products/';
  static String product(String id) => 'products/$id';
  static String users(String uid) => 'users/$uid';
  static String carts(String uid, String cartId) => 'users/$uid/carts/$cartId';
  static String productsCart(String uid) => 'users/$uid/carts/';
  static String favorites(String uid, String productId) =>
      'users/$uid/favorites/$productId';
  static String favoriteProducts(String uid) => 'users/$uid/favorites/';
  static String deliveryMethods() => 'deliveryMethods/';
  static String newShippingAddress(String uid, String addressId) =>
      'users/$uid/shippingAddress/$addressId';
  static String shippingAddress(String uid) => 'users/$uid/shippingAddress/';
}
