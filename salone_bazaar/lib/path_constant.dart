part of 'router.dart';

abstract final class _PathConstants {
  const _PathConstants._();

  static const _productIdPathParameter = 'productId';

  static String get productListPath => '/product-list';

  static String productDetailsPath([String? productId]) =>
      '$productListPath/${productId ?? ":$_productIdPathParameter"}';

  static String get signInPath => '/sign-in';
  static String get signUpPath => '/sign-up';
  static String get registerRetailerPath => '/register-retailer';

  static String get cartPath => '/cart';

  static String get ordersPath => '/orders';

  static String get userProfilePath => '/user-profile';
}
