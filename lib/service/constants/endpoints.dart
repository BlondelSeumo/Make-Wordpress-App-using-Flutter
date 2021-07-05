import 'package:cirilla/constants/app.dart';

class Endpoints {
  Endpoints._();

  // base url
  static const String restUrl = String.fromEnvironment('BASE_URL', defaultValue: "$URL$REST_PREFIX");
  static const String consumer_key = String.fromEnvironment('CONSUMER_KEY', defaultValue: CONSUMER_KEY);
  static const String consumer_secret = String.fromEnvironment('CONSUMER_SECRET', defaultValue: CONSUMER_SECRET);

  // receiveTimeout
  static const int receiveTimeout = 9999;

  // connectTimeout
  static const int connectionTimeout = 9999;

  // Woocommerce API: ==================================================================================================

  // orders endpoints
  static const String getOrders = "/wc/v3/orders";

  // products endpoints
  static const String getProducts = "/wc/v3/products";

  // product categories endpoints
  static const String getProductCategories = "/wc/v3/products/categories";

  // attributes endpoints
  static const String getAttributes = "/wc/v3/products/attributes";

  // Min - max price in category
  static const String getMinMaxPrices = "/wc/v3/min-max-prices";

  // Get Term Product Count
  static const String getTermProductCount = "/wc/v3/term-product-counts";

  // App Builder API: ==================================================================================================

  // categories endpoints
  static const String getCategories = "/app-builder/v1/categories";

  // Settings endpoints
  static const String getSettings = "/app-builder/v1/settings";

  static const String getTemplates = "/app-builder/v1/template-mobile";

  // Login with Email and Username
  static const String login = "/app-builder/v1/login";

  // Login with Facebook
  static const String loginFacebook = "/app-builder/v1/facebook";

  // Login with Google
  static const String loginGoogle = "/app-builder/v1/google";

  // Login with Apple
  static const String loginApple = "/app-builder/v1/apple";

  // Login with Facebook
  static const String loginWidthFacebook = "/app-builder/v1/facebook";

  // Login with Google
  static const String loginWithGoogle = "/app-builder/v1/google";

  // Login with Apple
  static const String loginWithApple = "/app-builder/v1/apple";

  // Login with OTP
  static const String loginWithOtp = "/app-builder/v1/login-otp";

  // Register
  static const String register = "/app-builder/v1/register";

  // Change Email
  static const String changeEmail = "/app-builder/v1/change-email";

  // Forgot password
  static const String forgotPassword = "/app-builder/v1/lost-password";

  // Change password
  static const String changePassword = "/app-builder/v1/change-password";

  // Variable endpoints
  static const String getProductVariable = "/app-builder/v1/product-variations";

  // Cart endpoints
  static const String current = "/app-builder/v1/current";

  // archives post
  static const String archives = "/app-builder/v1/archives";

  // Wordpress API: ====================================================================================================

  // Search
  static const String search = "/wp/v2/search";

  // Get posts
  static const String getPosts = "/wp/v2/posts";

  // Get post comments
  static const String getPostComments = "/wp/v2/comments";

  // Get post categories
  static const String getPostCategories = "/wp/v2/categories";

  // Get post categories
  static const String getPostAuthor = "/wp/v2/users";

  // Get post tags
  static const String getPostTags = "/wp/v2/tags";

  // Dokan API: ========================================================================================================

  static const String getDokanVendor = "/dokan/v1/stores";

  // Cart API: =========================================================================================================

  // Get cart list
  static const String getCart = "/wc/store/cart";

  // Add to cart
  static const String addToCart = "/wc/store/cart/add-item";

  // Apply coupon
  static const String applyCoupon = "/wc/store/cart/apply-coupon";

  // List coupon
  static const String coupons = "/wc/store/cart/coupons";

  // Remove coupon
  static const String removeCoupon = "/wc/store/cart/remove-coupon";

  // Remove cart
  static const String removeCart = "/wc/store/cart/remove-item";

  // Update cart
  static const String updateCart = "/wc/store/cart/update-item";

  // Contact API: ======================================================================================================

  // orders endpoints
  static const String contactForm7 = "/contact-form-7/v1/contact-forms";

  // country
  static const String getCountries = "/wc/v3/data/countries";

  // update address
  static const String postAddress = "/wc/v3/customers";

  // update address
  static const String getAddress = "/wc/v3/customers";

  // Review API: =======================================================================================================

  // write review
  static const String writeReview = "/app-builder/v1/reviews";

  // get reviews
  static const String getReviews = "/wc/v3/products/reviews";

  // get rating count
  static const String ratingCount = "/app-builder/v1/rating-count";
}
