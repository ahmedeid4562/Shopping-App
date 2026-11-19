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
}
