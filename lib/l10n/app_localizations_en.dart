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
}
