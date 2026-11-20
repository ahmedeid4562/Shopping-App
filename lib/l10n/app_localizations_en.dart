// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Shopping App';

  @override
  String get appVersion => 'Version 1.0.0';

  @override
  String get user => 'User';

  @override
  String get noEmailAvailable => 'No email available';

  @override
  String get myProfile => 'My Profile';

  @override
  String get myAccount => 'My Account';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get updatePersonalInfo => 'Update your personal information';

  @override
  String get changePassword => 'Change Password';

  @override
  String get updateAccountPassword => 'Update your account password';

  @override
  String get myOrders => 'My Orders';

  @override
  String get viewOrderHistory => 'View your order history';

  @override
  String get myAddresses => 'My Addresses';

  @override
  String get manageAddresses => 'Manage your delivery addresses';

  @override
  String get paymentMethods => 'Payment Methods';

  @override
  String get managePaymentOptions => 'Manage your payment options';

  @override
  String get preferences => 'Preferences';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get darkAppearanceEnabled => 'Dark appearance enabled';

  @override
  String get lightAppearanceEnabled => 'Light appearance enabled';

  @override
  String get language => 'Language';

  @override
  String get arabic => 'Arabic';

  @override
  String get english => 'English';

  @override
  String get notifications => 'Notifications';

  @override
  String get manageNotifications => 'Manage your notifications';

  @override
  String get support => 'Support';

  @override
  String get helpSupport => 'Help & Support';

  @override
  String get getHelpAccount => 'Get help with your account';

  @override
  String get aboutApp => 'About App';

  @override
  String get learnAboutApp => 'Learn more about our app';

  @override
  String get logout => 'Logout';

  @override
  String get shoppingMember => 'Shopping Member';

  @override
  String get pleaseLoginAgain => 'Please login again';

  @override
  String get accountNoEmailPassword =>
      'Your account does not have an email and password';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get cancel => 'Cancel';

  @override
  String get fillAllFields => 'Please fill in all fields';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get newPasswordDifferent =>
      'New password must be different from current password';

  @override
  String get passwordChangedSuccessfully => 'Password changed successfully';

  @override
  String get incorrectCurrentPassword => 'Current password is incorrect';

  @override
  String get chooseStrongerPassword => 'Please choose a stronger password';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get logoutConfirmation => 'Are you sure you want to logout?';

  @override
  String get logoutFailed => 'Logout failed';

  @override
  String get adminDashboard => 'Admin Dashboard';

  @override
  String get manageStoreOrders => 'Manage store orders';

  @override
  String get changeAdminPassword => 'Change Admin Password';

  @override
  String get failedToChangePassword => 'Failed to change password';

  @override
  String get orderInformationMissing => 'Order information is missing';

  @override
  String get orderStatusUpdatedTo => 'Order status updated to';

  @override
  String get failedToUpdateOrder => 'Failed to update order';

  @override
  String get failedToVerifyAdminAccess => 'Failed to verify admin access';

  @override
  String get accessDenied => 'Access Denied';

  @override
  String get adminPrivilegesRequired => 'Admin privileges are required';

  @override
  String get manageProducts => 'Manage Products';

  @override
  String get manageProductsSubtitle => 'Add, edit and delete products';

  @override
  String get productAddedSuccessfully => 'Product added successfully';

  @override
  String get productUpdatedSuccessfully => 'Product updated successfully';

  @override
  String get cannotDeleteProduct => 'Cannot delete this product';

  @override
  String get deleteProductTitle => 'Delete Product';

  @override
  String deleteProductConfirmation(String productName) {
    return 'Are you sure you want to delete \"$productName\"?';
  }

  @override
  String get productDeletedSuccessfully => 'Product deleted successfully';

  @override
  String get failedToDeleteProduct => 'Failed to delete product';

  @override
  String get failedToLoadProducts => 'Failed to load products';

  @override
  String get noProductsYet => 'No Products Yet';

  @override
  String get startAddingProducts => 'Start adding products to your store.';

  @override
  String get addYourFirstProduct => 'Add Your First Product';

  @override
  String get storeProducts => 'Store Products';

  @override
  String productsCount(int count) {
    return '$count Products';
  }

  @override
  String get manageCoupons => 'Manage Coupons';

  @override
  String get manageCouponsSubtitle => 'Create and manage discount codes';

  @override
  String get createCoupon => 'Create Coupon';

  @override
  String get couponCode => 'Coupon Code';

  @override
  String get enterAtLeast3Characters => 'Enter at least 3 characters';

  @override
  String get discountType => 'Discount Type';

  @override
  String get percentage => 'Percentage (%)';

  @override
  String get fixedAmount => 'Fixed Amount';

  @override
  String get discountPercentage => 'Discount Percentage';

  @override
  String get discountAmount => 'Discount Amount';

  @override
  String get enterValidDiscount => 'Enter a valid discount';

  @override
  String get maximumPercentageIs100 => 'Maximum percentage is 100';

  @override
  String get minimumOrderAmount => 'Minimum Order Amount';

  @override
  String get enterValidAmount => 'Enter a valid amount';

  @override
  String get chooseExpirationDate => 'Choose Expiration Date';

  @override
  String get chooseExpirationDateFirst => 'Please choose an expiration date';

  @override
  String get create => 'Create';

  @override
  String get couponCreatedSuccessfully => 'Coupon created successfully';

  @override
  String get failedToCreateCoupon => 'Failed to create coupon';

  @override
  String get couponDeleted => 'Coupon deleted';

  @override
  String get failedToDeleteCoupon => 'Failed to delete coupon';

  @override
  String get couponDeactivated => 'Coupon deactivated';

  @override
  String get couponActivated => 'Coupon activated';

  @override
  String get failedToUpdateCoupon => 'Failed to update coupon';

  @override
  String get failedToLoadCoupons => 'Failed to load coupons';

  @override
  String get noCouponsCreatedYet => 'No coupons created yet';

  @override
  String get addCoupon => 'Add Coupon';

  @override
  String get off => 'OFF';

  @override
  String get minimumOrder => 'Minimum order';

  @override
  String get expires => 'Expires';

  @override
  String get status => 'Status';

  @override
  String get active => 'Active';

  @override
  String get inactive => 'Inactive';

  @override
  String get deactivate => 'Deactivate';

  @override
  String get activate => 'Activate';

  @override
  String get failedSelectImages => 'Failed to select images';

  @override
  String enterColorName(int number) {
    return 'Enter color name number $number';
  }

  @override
  String invalidHexColor(String colorName) {
    return 'Invalid hex color code for $colorName';
  }

  @override
  String addAtLeastOneImage(String colorName) {
    return 'Add at least one image for $colorName';
  }

  @override
  String noValidImages(String colorName) {
    return 'No valid images found for $colorName';
  }

  @override
  String get addAtLeastOneColor => 'Add at least one color';

  @override
  String get enterAllColorNames => 'Please enter all color names';

  @override
  String get uniqueColorNames => 'Color names must be unique';

  @override
  String get addProductImages => 'Please add product images';

  @override
  String get productIdMissing => 'Product ID is missing';

  @override
  String get failedSaveProduct => 'Failed to save product';

  @override
  String pleaseEnterField(String label) {
    return 'Please enter $label';
  }

  @override
  String colorVariant(int number) {
    return 'Color Variant $number';
  }

  @override
  String get removeColor => 'Remove Color';

  @override
  String get colorName => 'Color Name';

  @override
  String get colorNameExample => 'Example: Red, Black, Blue';

  @override
  String get colorHex => 'Color Hex Code';

  @override
  String get colorImages => 'Color Images';

  @override
  String imagesCount(int count) {
    return '$count images';
  }

  @override
  String get noImagesAdded => 'No images added';

  @override
  String get openingGallery => 'Opening gallery...';

  @override
  String get addImagesFromDevice => 'Add Images From Device';

  @override
  String get editProduct => 'Edit Product';

  @override
  String get addProduct => 'Add Product';

  @override
  String get productInformation => 'Product Information';

  @override
  String get productName => 'Product Name';

  @override
  String get price => 'Price';

  @override
  String get validPrice => 'Please enter a valid price greater than zero';

  @override
  String get category => 'Category';

  @override
  String get categoryExample => 'Example: Clothes, Shoes, Accessories';

  @override
  String get description => 'Description';

  @override
  String get productColorsImages => 'Product Colors & Images';

  @override
  String colorsCount(int count) {
    return '$count colors';
  }

  @override
  String get addAvailableColorsDescription =>
      'Add available product colors and their images';

  @override
  String get addAnotherColor => 'Add Another Color';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get editAction => 'Edit';

  @override
  String get deleteAction => 'Delete';

  @override
  String get orderLabel => 'Order';

  @override
  String get updateOrderStatus => 'Update order status';

  @override
  String get unknownCustomer => 'Unknown Customer';

  @override
  String get productsLabel => 'Products';

  @override
  String get unknownProduct => 'Unknown Product';

  @override
  String get totalAmount => 'Total Amount';

  @override
  String get pendingStatus => 'Pending';

  @override
  String get processingStatus => 'Processing';

  @override
  String get shippedStatus => 'Shipped';

  @override
  String get deliveredStatus => 'Delivered';

  @override
  String get cancelledStatus => 'Cancelled';

  @override
  String get failedToLoadOrders => 'Failed to load orders';

  @override
  String get overview => 'Overview';

  @override
  String get totalOrders => 'Total Orders';

  @override
  String get allOrders => 'All Orders';

  @override
  String ordersCount(int count) {
    return '$count Orders';
  }

  @override
  String get noOrdersYet => 'No Orders Yet';

  @override
  String get ordersWillAppearHere => 'Your orders will appear here';

  @override
  String get welcomeTo => 'Welcome to';

  @override
  String get welcomeDescription =>
      'Discover the latest men\'s fashion and find your perfect style.';

  @override
  String get aboutFavoritesDescription =>
      'Save your favorite products and access them easily anytime';

  @override
  String get aboutSecureExperience => 'Secure Shopping Experience';

  @override
  String get aboutSecureExperienceDescription =>
      'We provide a safe and reliable shopping experience to protect your data';

  @override
  String get madeWithFlutter => 'Made with Flutter';

  @override
  String get copyrightNotice => 'All Rights Reserved © 2026';

  @override
  String get myCart => 'My Cart';

  @override
  String get clearCart => 'Clear Cart';

  @override
  String get yourCartIsEmpty => 'Your Cart Is Empty';

  @override
  String get emptyCartDescription =>
      'You haven\'t added any products to your shopping cart yet';

  @override
  String get proceedToCheckout => 'Proceed to Checkout';

  @override
  String get categoryTops => 'Tops';

  @override
  String get categoryShoes => 'Shoes';

  @override
  String get categoryWatches => 'Watches';

  @override
  String get categoryBags => 'Bags';

  @override
  String get categoryJewelry => 'Jewelry';

  @override
  String get categoryDresses => 'Dresses';

  @override
  String get categoryElectronics => 'Electronics';

  @override
  String get categoriesTitle => 'Categories';

  @override
  String get couldNotLoadCategories => 'Could not load categories';

  @override
  String get tryAgain => 'Try Again';

  @override
  String get noCategoriesAvailable => 'No categories available';

  @override
  String get couldNotLoadProducts => 'Could not load products';

  @override
  String get failedToLoadStoreProducts => 'Failed to load store products';

  @override
  String get noProductsFoundInCategory => 'No products found in this category';

  @override
  String get noProductsFound => 'No products found';

  @override
  String get exploreProducts => 'Explore Products';

  @override
  String categoryItemsCount(int count) {
    return '$count products';
  }

  @override
  String get aboutVersion => 'Version 1.0.0';

  @override
  String get aboutUs => 'About Us';

  @override
  String get aboutAppDescription =>
      'We offer a convenient shopping experience where you can discover and purchase your favorite products easily.';

  @override
  String get aboutEasyShopping => 'Easy Shopping';

  @override
  String get aboutEasyShoppingDescription =>
      'Browse products and shop easily from anywhere.';

  @override
  String get aboutFavorites => 'Your Favorites';

  @override
  String get checkoutTitle => 'Checkout';

  @override
  String get deliveryInformation => 'Delivery Information';

  @override
  String get checkoutFullName => 'Full Name';

  @override
  String get checkoutPhoneNumber => 'Phone Number';

  @override
  String get checkoutDeliveryAddress => 'Delivery Address';

  @override
  String get paymentMethodTitle => 'Payment Method';

  @override
  String get cashOnDelivery => 'Cash on Delivery';

  @override
  String get promoCode => 'Promo Code';

  @override
  String get enterPromoCode => 'Enter promo code';

  @override
  String get applyCoupon => 'Apply';

  @override
  String get enterCouponCode => 'Please enter a coupon code';

  @override
  String get couponAppliedSuccessfully => 'Coupon applied successfully';

  @override
  String get removeCoupon => 'Remove';

  @override
  String get subtotal => 'Subtotal';

  @override
  String get discount => 'Discount';

  @override
  String get placeOrder => 'Place Order';

  @override
  String get orderPlacedSuccessfully => 'Order Placed Successfully';

  @override
  String get orderSavedSuccessfully =>
      'Your order has been saved successfully.';

  @override
  String get continueShopping => 'Continue Shopping';

  @override
  String get failedToPlaceOrder => 'Failed to place order';

  @override
  String get validPhoneNumber => 'Please enter a valid phone number';

  @override
  String pleaseEnterCheckoutField(String field) {
    return 'Please enter $field';
  }

  @override
  String get fullName => 'Full Name';

  @override
  String get enterYourName => 'Enter your name';

  @override
  String get enterFullName => 'Enter your full name';

  @override
  String get pleaseEnterYourName => 'Please enter your name';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get enterYourEmail => 'Enter your email';

  @override
  String get pleaseEnterYourEmail => 'Please enter your email';

  @override
  String get validEmailAddress => 'Please enter a valid email address';

  @override
  String get emailVerificationRequired =>
      'Email verification is required when changing your email address.';

  @override
  String get pleaseLoginFirst => 'Please login first';

  @override
  String get verificationEmailSent =>
      'A verification email has been sent to your new email address.';

  @override
  String get profileUpdatedSuccessfully => 'Profile updated successfully';

  @override
  String get myFavorites => 'My Favorites';

  @override
  String get failedToLoadFavorites => 'Failed to load favorites';

  @override
  String get noFavoritesYet => 'No Favorites Yet';

  @override
  String get addProductsToFavorites =>
      'Add products to your favorites to find them here.';

  @override
  String get howCanWeHelp => 'How Can We Help You?';

  @override
  String get helpDescription =>
      'Find answers to common questions and get the support you need.';

  @override
  String get frequentlyAskedQuestions => 'Frequently Asked Questions';

  @override
  String get faqTrackOrderQuestion => 'How can I track my order?';

  @override
  String get faqTrackOrderAnswer =>
      'You can view your orders and their status from the My Orders section in your profile.';

  @override
  String get faqCancelOrderQuestion => 'Can I cancel my order?';

  @override
  String get faqCancelOrderAnswer =>
      'Please contact support as soon as possible to ask about cancelling your order.';

  @override
  String get faqAddFavoriteQuestion =>
      'How can I add a product to my favorites?';

  @override
  String get faqAddFavoriteAnswer =>
      'Tap the heart icon on a product to add it to your favorites.';

  @override
  String get faqChangePersonalInfoQuestion =>
      'How can I change my personal information?';

  @override
  String get faqChangePersonalInfoAnswer =>
      'Open your profile, select Edit Profile, update your information, and save your changes.';

  @override
  String get faqChangePasswordQuestion => 'How can I change my password?';

  @override
  String get faqChangePasswordAnswer =>
      'Open the Change Password section from your account settings and follow the instructions.';

  @override
  String get faqPaymentMethodsQuestion => 'What payment methods are available?';

  @override
  String get faqPaymentMethodsAnswer =>
      'Currently, you can pay for your order using Cash on Delivery.';

  @override
  String get stillNeedHelp => 'Still Need Help?';

  @override
  String get contactSupportDescription =>
      'Contact our support team if you need further assistance.';

  @override
  String get contactSupport => 'Contact Support';

  @override
  String get supportDetailsComingSoon =>
      'Support contact details will be available soon.';

  @override
  String get supportDialogOk => 'OK';

  @override
  String get loginWelcomeBack => 'Welcome Back';

  @override
  String get loginSubtitle => 'Sign in to continue shopping';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginForgotPassword => 'Forgot Password?';

  @override
  String get loginButton => 'Login';

  @override
  String get loginOr => 'OR';

  @override
  String get loginContinueWithGoogle => 'Continue with Google';

  @override
  String get loginNoAccount => 'Don\'t have an account? ';

  @override
  String get loginSignUp => 'Sign Up';

  @override
  String get loginEnterEmailAndPassword =>
      'Please enter your email and password';

  @override
  String get loginUnableToSignIn => 'Unable to sign in. Please try again.';

  @override
  String get loginInvalidEmail => 'The email address is invalid';

  @override
  String get loginIncorrectEmailOrPassword => 'Incorrect email or password';

  @override
  String get loginAccountDisabled => 'This account has been disabled';

  @override
  String get loginTooManyAttempts =>
      'Too many attempts. Please try again later.';

  @override
  String get loginCheckInternetConnection =>
      'Please check your internet connection';

  @override
  String get loginFailedTryAgain => 'Login failed. Please try again.';

  @override
  String get loginEmailNotVerified => 'Email Not Verified';

  @override
  String loginEmailNotVerifiedMessage(String email) {
    return 'Your email address $email has not been verified. Would you like us to send another verification email?';
  }

  @override
  String get loginResendEmail => 'Resend Email';

  @override
  String get loginVerificationEmailSent =>
      'Verification email sent successfully';

  @override
  String get loginEmailAlreadyVerified => 'Your email is already verified';

  @override
  String get loginWaitBeforeRequestingEmail =>
      'Please wait before requesting another email';

  @override
  String get loginCouldNotSendVerificationEmail =>
      'Could not send verification email';

  @override
  String get loginGoogleFailed => 'Google sign-in failed. Please try again.';

  @override
  String get loginEnterEmailFirst => 'Please enter your email address first';

  @override
  String get loginPasswordResetEmailSent =>
      'Password reset email sent successfully';

  @override
  String get loginCouldNotSendPasswordResetEmail =>
      'Could not send password reset email';

  @override
  String get signup => 'Sign Up';

  @override
  String get login => 'Login';

  @override
  String get homeAddress => 'Home';

  @override
  String get defaultAddress => 'Default';

  @override
  String get setAsDefaultAddress => 'Set as default address';

  @override
  String get addAddress => 'Add Address';

  @override
  String get deleteAddressTitle => 'Delete Address';

  @override
  String get deleteAddressConfirmation =>
      'Are you sure you want to delete this address?';

  @override
  String get noAddressesYet => 'No Addresses Yet';

  @override
  String get addAddressDescription =>
      'Add a delivery address to make checkout easier.';

  @override
  String get editAddress => 'Edit Address';

  @override
  String get streetAddress => 'Street Address';

  @override
  String get city => 'City';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get addressFieldRequired => 'This field is required';

  @override
  String get addNewAddress => 'Add New Address';

  @override
  String get addressName => 'Address Name';

  @override
  String get addressNameHint => 'Example: Home, Work';

  @override
  String get onboardingTitle => 'Find Everything You Love';

  @override
  String get onboardingDescription =>
      'Discover amazing products and enjoy a simple shopping experience.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get chooseNotifications =>
      'Choose which notifications you want to receive';

  @override
  String get general => 'General';

  @override
  String get orderUpdates => 'Order Updates';

  @override
  String get orderUpdatesDescription => 'Receive updates about your orders';

  @override
  String get promotionsOffers => 'Promotions & Offers';

  @override
  String get promotionsDescription =>
      'Get notified about discounts and special offers';

  @override
  String get recommendations => 'Recommendations';

  @override
  String get recommendationsDescription => 'Discover products picked for you';

  @override
  String get notificationChannels => 'Notification Channels';

  @override
  String get pushNotifications => 'Push Notifications';

  @override
  String get pushNotificationsDescription =>
      'Receive notifications on your device';

  @override
  String get emailNotifications => 'Email Notifications';

  @override
  String get emailNotificationsDescription => 'Receive notifications by email';

  @override
  String get notificationSettingsInfo =>
      'You can change these preferences at any time.';

  @override
  String get pending => 'Pending';

  @override
  String get processing => 'Processing';

  @override
  String get shipped => 'Shipped';

  @override
  String get delivered => 'Delivered';

  @override
  String get cancelled => 'Cancelled';

  @override
  String get completed => 'Completed';

  @override
  String get cancelOrder => 'Cancel Order';

  @override
  String get cancelOrderConfirmation =>
      'Are you sure you want to cancel this order?';

  @override
  String get no => 'No';

  @override
  String get yesCancel => 'Yes, Cancel';

  @override
  String get orderCancelledSuccessfully => 'Order cancelled successfully';

  @override
  String get failedToCancelOrder => 'Failed to cancel order';

  @override
  String get deleteOrder => 'Delete Order';

  @override
  String get deleteOrderConfirmation =>
      'Are you sure you want to delete this order?';

  @override
  String get yesDelete => 'Yes, Delete';

  @override
  String get orderDeletedSuccessfully => 'Order deleted successfully';

  @override
  String get failedToDeleteOrder => 'Failed to delete order';

  @override
  String get dateUnavailable => 'Date unavailable';

  @override
  String get orderDetails => 'Order Details';

  @override
  String get orderId => 'Order ID';

  @override
  String get date => 'Date';

  @override
  String get editPaymentMethod => 'Edit Payment Method';

  @override
  String get addPaymentMethod => 'Add Payment Method';

  @override
  String get cardholderName => 'Cardholder Name';

  @override
  String get enterCardholderName => 'Enter cardholder name';

  @override
  String get lastFourDigits => 'Last Four Digits';

  @override
  String get enterExactlyFourDigits => 'Enter exactly 4 digits';

  @override
  String get expiryDate => 'Expiry Date';

  @override
  String get useMmYyFormat => 'Use MM/YY format';

  @override
  String get setAsDefault => 'Set as default';

  @override
  String get addCard => 'Add Card';

  @override
  String get deleteCard => 'Delete Card';

  @override
  String get deletePaymentConfirmation =>
      'Are you sure you want to delete this payment method?';

  @override
  String get noPaymentMethods => 'No Payment Methods';

  @override
  String get addPaymentDescription =>
      'Add a payment method to make checkout easier.';

  @override
  String get edit => 'Edit';

  @override
  String get productDetails => 'Product Details';

  @override
  String get reviews => 'Reviews';

  @override
  String productAddedToCart(String product) {
    return '$product added to cart';
  }

  @override
  String get addToCart => 'Add to Cart';

  @override
  String get searchProducts => 'Search Products';

  @override
  String get searchForProducts => 'Search for products';

  @override
  String get findFavoriteProducts => 'Find Your Favorite Products';

  @override
  String get searchByProductName => 'Search by product name';

  @override
  String get searchResults => 'Search Results';

  @override
  String get items => 'items';

  @override
  String get failedToLoadSearchResults => 'Failed to load search results';

  @override
  String get trySearchingAnotherName => 'Try searching for another name';

  @override
  String get shopper => 'Shopper';

  @override
  String helloShopper(String name) {
    return 'Hello, $name';
  }

  @override
  String get findYourStyle => 'Find Your Style';

  @override
  String get searchProductsHint => 'Search products...';

  @override
  String get newCollection => 'NEW COLLECTION';

  @override
  String get discoverYourStyle => 'Discover Your Style';

  @override
  String get exploreLatestFashion => 'Explore the latest fashion trends';

  @override
  String get shopNow => 'Shop Now';

  @override
  String get categories => 'Categories';

  @override
  String get all => 'All';

  @override
  String get featuredProducts => 'Featured Products';

  @override
  String itemCount(int count) {
    return '$count items';
  }

  @override
  String get pleaseFillAllFields => 'Please fill in all fields';

  @override
  String get enterValidEmail => 'Please enter a valid email address';

  @override
  String get verifyYourEmail => 'Verify Your Email';

  @override
  String verificationEmailInstructions(String email) {
    return 'We have sent a verification email to $email. Please check your inbox.';
  }

  @override
  String get gotIt => 'Got It';

  @override
  String get joinShoppingApp => 'Join Shopping App';

  @override
  String get createAccountDescription =>
      'Create an account to start your shopping journey';

  @override
  String get password => 'Password';

  @override
  String get createPassword => 'Create a password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get confirmYourPassword => 'Confirm your password';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get home => 'Home';

  @override
  String get favorites => 'Favorites';

  @override
  String get cart => 'Cart';

  @override
  String get profile => 'Profile';

  @override
  String get addedToFavorites => 'Added to favorites';

  @override
  String get removedFromFavorites => 'Removed from favorites';

  @override
  String get addToFavorites => 'Add to favorites';

  @override
  String get removeFromFavorites => 'Remove from favorites';

  @override
  String get filter => 'Filter';

  @override
  String get categoryClothing => 'Clothing';

  @override
  String get categoryClothingSubtitle =>
      'Explore men\'s, women\'s and kids\' clothing';

  @override
  String get categoryAccessories => 'Accessories';

  @override
  String get categoryAccessoriesSubtitle =>
      'Complete your look with accessories';

  @override
  String get categoryMen => 'Men';

  @override
  String get categoryWomen => 'Women';

  @override
  String get categoryKids => 'Kids';

  @override
  String get categorySunglasses => 'Sunglasses';

  @override
  String get categoryBelts => 'Belts';

  @override
  String get categoryWallets => 'Wallets';
}
