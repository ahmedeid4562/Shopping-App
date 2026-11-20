import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Shopping App'**
  String get appTitle;

  /// No description provided for @appVersion.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get appVersion;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @noEmailAvailable.
  ///
  /// In en, this message translates to:
  /// **'No email available'**
  String get noEmailAvailable;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @updatePersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Update your personal information'**
  String get updatePersonalInfo;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @updateAccountPassword.
  ///
  /// In en, this message translates to:
  /// **'Update your account password'**
  String get updateAccountPassword;

  /// No description provided for @myOrders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get myOrders;

  /// No description provided for @viewOrderHistory.
  ///
  /// In en, this message translates to:
  /// **'View your order history'**
  String get viewOrderHistory;

  /// No description provided for @myAddresses.
  ///
  /// In en, this message translates to:
  /// **'My Addresses'**
  String get myAddresses;

  /// No description provided for @manageAddresses.
  ///
  /// In en, this message translates to:
  /// **'Manage your delivery addresses'**
  String get manageAddresses;

  /// No description provided for @paymentMethods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get paymentMethods;

  /// No description provided for @managePaymentOptions.
  ///
  /// In en, this message translates to:
  /// **'Manage your payment options'**
  String get managePaymentOptions;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @darkAppearanceEnabled.
  ///
  /// In en, this message translates to:
  /// **'Dark appearance enabled'**
  String get darkAppearanceEnabled;

  /// No description provided for @lightAppearanceEnabled.
  ///
  /// In en, this message translates to:
  /// **'Light appearance enabled'**
  String get lightAppearanceEnabled;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @manageNotifications.
  ///
  /// In en, this message translates to:
  /// **'Manage your notifications'**
  String get manageNotifications;

  /// No description provided for @support.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get support;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @getHelpAccount.
  ///
  /// In en, this message translates to:
  /// **'Get help with your account'**
  String get getHelpAccount;

  /// No description provided for @aboutApp.
  ///
  /// In en, this message translates to:
  /// **'About App'**
  String get aboutApp;

  /// No description provided for @learnAboutApp.
  ///
  /// In en, this message translates to:
  /// **'Learn more about our app'**
  String get learnAboutApp;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @shoppingMember.
  ///
  /// In en, this message translates to:
  /// **'Shopping Member'**
  String get shoppingMember;

  /// No description provided for @pleaseLoginAgain.
  ///
  /// In en, this message translates to:
  /// **'Please login again'**
  String get pleaseLoginAgain;

  /// No description provided for @accountNoEmailPassword.
  ///
  /// In en, this message translates to:
  /// **'Your account does not have an email and password'**
  String get accountNoEmailPassword;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @fillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields'**
  String get fillAllFields;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordMinLength;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @newPasswordDifferent.
  ///
  /// In en, this message translates to:
  /// **'New password must be different from current password'**
  String get newPasswordDifferent;

  /// No description provided for @passwordChangedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get passwordChangedSuccessfully;

  /// No description provided for @incorrectCurrentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password is incorrect'**
  String get incorrectCurrentPassword;

  /// No description provided for @chooseStrongerPassword.
  ///
  /// In en, this message translates to:
  /// **'Please choose a stronger password'**
  String get chooseStrongerPassword;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @logoutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmation;

  /// No description provided for @logoutFailed.
  ///
  /// In en, this message translates to:
  /// **'Logout failed'**
  String get logoutFailed;

  /// No description provided for @adminDashboard.
  ///
  /// In en, this message translates to:
  /// **'Admin Dashboard'**
  String get adminDashboard;

  /// No description provided for @manageStoreOrders.
  ///
  /// In en, this message translates to:
  /// **'Manage store orders'**
  String get manageStoreOrders;

  /// No description provided for @changeAdminPassword.
  ///
  /// In en, this message translates to:
  /// **'Change Admin Password'**
  String get changeAdminPassword;

  /// No description provided for @failedToChangePassword.
  ///
  /// In en, this message translates to:
  /// **'Failed to change password'**
  String get failedToChangePassword;

  /// No description provided for @orderInformationMissing.
  ///
  /// In en, this message translates to:
  /// **'Order information is missing'**
  String get orderInformationMissing;

  /// No description provided for @orderStatusUpdatedTo.
  ///
  /// In en, this message translates to:
  /// **'Order status updated to'**
  String get orderStatusUpdatedTo;

  /// No description provided for @failedToUpdateOrder.
  ///
  /// In en, this message translates to:
  /// **'Failed to update order'**
  String get failedToUpdateOrder;

  /// No description provided for @failedToVerifyAdminAccess.
  ///
  /// In en, this message translates to:
  /// **'Failed to verify admin access'**
  String get failedToVerifyAdminAccess;

  /// No description provided for @accessDenied.
  ///
  /// In en, this message translates to:
  /// **'Access Denied'**
  String get accessDenied;

  /// No description provided for @adminPrivilegesRequired.
  ///
  /// In en, this message translates to:
  /// **'Admin privileges are required'**
  String get adminPrivilegesRequired;

  /// No description provided for @manageProducts.
  ///
  /// In en, this message translates to:
  /// **'Manage Products'**
  String get manageProducts;

  /// No description provided for @manageProductsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add, edit and delete products'**
  String get manageProductsSubtitle;

  /// No description provided for @productAddedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Product added successfully'**
  String get productAddedSuccessfully;

  /// No description provided for @productUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Product updated successfully'**
  String get productUpdatedSuccessfully;

  /// No description provided for @cannotDeleteProduct.
  ///
  /// In en, this message translates to:
  /// **'Cannot delete this product'**
  String get cannotDeleteProduct;

  /// No description provided for @deleteProductTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Product'**
  String get deleteProductTitle;

  /// No description provided for @deleteProductConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{productName}\"?'**
  String deleteProductConfirmation(String productName);

  /// No description provided for @productDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Product deleted successfully'**
  String get productDeletedSuccessfully;

  /// No description provided for @failedToDeleteProduct.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete product'**
  String get failedToDeleteProduct;

  /// No description provided for @failedToLoadProducts.
  ///
  /// In en, this message translates to:
  /// **'Failed to load products'**
  String get failedToLoadProducts;

  /// No description provided for @noProductsYet.
  ///
  /// In en, this message translates to:
  /// **'No Products Yet'**
  String get noProductsYet;

  /// No description provided for @startAddingProducts.
  ///
  /// In en, this message translates to:
  /// **'Start adding products to your store.'**
  String get startAddingProducts;

  /// No description provided for @addYourFirstProduct.
  ///
  /// In en, this message translates to:
  /// **'Add Your First Product'**
  String get addYourFirstProduct;

  /// No description provided for @storeProducts.
  ///
  /// In en, this message translates to:
  /// **'Store Products'**
  String get storeProducts;

  /// No description provided for @productsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Products'**
  String productsCount(int count);

  /// No description provided for @manageCoupons.
  ///
  /// In en, this message translates to:
  /// **'Manage Coupons'**
  String get manageCoupons;

  /// No description provided for @manageCouponsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create and manage discount codes'**
  String get manageCouponsSubtitle;

  /// No description provided for @createCoupon.
  ///
  /// In en, this message translates to:
  /// **'Create Coupon'**
  String get createCoupon;

  /// No description provided for @couponCode.
  ///
  /// In en, this message translates to:
  /// **'Coupon Code'**
  String get couponCode;

  /// No description provided for @enterAtLeast3Characters.
  ///
  /// In en, this message translates to:
  /// **'Enter at least 3 characters'**
  String get enterAtLeast3Characters;

  /// No description provided for @discountType.
  ///
  /// In en, this message translates to:
  /// **'Discount Type'**
  String get discountType;

  /// No description provided for @percentage.
  ///
  /// In en, this message translates to:
  /// **'Percentage (%)'**
  String get percentage;

  /// No description provided for @fixedAmount.
  ///
  /// In en, this message translates to:
  /// **'Fixed Amount'**
  String get fixedAmount;

  /// No description provided for @discountPercentage.
  ///
  /// In en, this message translates to:
  /// **'Discount Percentage'**
  String get discountPercentage;

  /// No description provided for @discountAmount.
  ///
  /// In en, this message translates to:
  /// **'Discount Amount'**
  String get discountAmount;

  /// No description provided for @enterValidDiscount.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid discount'**
  String get enterValidDiscount;

  /// No description provided for @maximumPercentageIs100.
  ///
  /// In en, this message translates to:
  /// **'Maximum percentage is 100'**
  String get maximumPercentageIs100;

  /// No description provided for @minimumOrderAmount.
  ///
  /// In en, this message translates to:
  /// **'Minimum Order Amount'**
  String get minimumOrderAmount;

  /// No description provided for @enterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid amount'**
  String get enterValidAmount;

  /// No description provided for @chooseExpirationDate.
  ///
  /// In en, this message translates to:
  /// **'Choose Expiration Date'**
  String get chooseExpirationDate;

  /// No description provided for @chooseExpirationDateFirst.
  ///
  /// In en, this message translates to:
  /// **'Please choose an expiration date'**
  String get chooseExpirationDateFirst;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @couponCreatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Coupon created successfully'**
  String get couponCreatedSuccessfully;

  /// No description provided for @failedToCreateCoupon.
  ///
  /// In en, this message translates to:
  /// **'Failed to create coupon'**
  String get failedToCreateCoupon;

  /// No description provided for @couponDeleted.
  ///
  /// In en, this message translates to:
  /// **'Coupon deleted'**
  String get couponDeleted;

  /// No description provided for @failedToDeleteCoupon.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete coupon'**
  String get failedToDeleteCoupon;

  /// No description provided for @couponDeactivated.
  ///
  /// In en, this message translates to:
  /// **'Coupon deactivated'**
  String get couponDeactivated;

  /// No description provided for @couponActivated.
  ///
  /// In en, this message translates to:
  /// **'Coupon activated'**
  String get couponActivated;

  /// No description provided for @failedToUpdateCoupon.
  ///
  /// In en, this message translates to:
  /// **'Failed to update coupon'**
  String get failedToUpdateCoupon;

  /// No description provided for @failedToLoadCoupons.
  ///
  /// In en, this message translates to:
  /// **'Failed to load coupons'**
  String get failedToLoadCoupons;

  /// No description provided for @noCouponsCreatedYet.
  ///
  /// In en, this message translates to:
  /// **'No coupons created yet'**
  String get noCouponsCreatedYet;

  /// No description provided for @addCoupon.
  ///
  /// In en, this message translates to:
  /// **'Add Coupon'**
  String get addCoupon;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'OFF'**
  String get off;

  /// No description provided for @minimumOrder.
  ///
  /// In en, this message translates to:
  /// **'Minimum order'**
  String get minimumOrder;

  /// No description provided for @expires.
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get expires;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @inactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get inactive;

  /// No description provided for @deactivate.
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get deactivate;

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activate;

  /// No description provided for @failedSelectImages.
  ///
  /// In en, this message translates to:
  /// **'Failed to select images'**
  String get failedSelectImages;

  /// No description provided for @enterColorName.
  ///
  /// In en, this message translates to:
  /// **'Enter color name number {number}'**
  String enterColorName(int number);

  /// No description provided for @invalidHexColor.
  ///
  /// In en, this message translates to:
  /// **'Invalid hex color code for {colorName}'**
  String invalidHexColor(String colorName);

  /// No description provided for @addAtLeastOneImage.
  ///
  /// In en, this message translates to:
  /// **'Add at least one image for {colorName}'**
  String addAtLeastOneImage(String colorName);

  /// No description provided for @noValidImages.
  ///
  /// In en, this message translates to:
  /// **'No valid images found for {colorName}'**
  String noValidImages(String colorName);

  /// No description provided for @addAtLeastOneColor.
  ///
  /// In en, this message translates to:
  /// **'Add at least one color'**
  String get addAtLeastOneColor;

  /// No description provided for @enterAllColorNames.
  ///
  /// In en, this message translates to:
  /// **'Please enter all color names'**
  String get enterAllColorNames;

  /// No description provided for @uniqueColorNames.
  ///
  /// In en, this message translates to:
  /// **'Color names must be unique'**
  String get uniqueColorNames;

  /// No description provided for @addProductImages.
  ///
  /// In en, this message translates to:
  /// **'Please add product images'**
  String get addProductImages;

  /// No description provided for @productIdMissing.
  ///
  /// In en, this message translates to:
  /// **'Product ID is missing'**
  String get productIdMissing;

  /// No description provided for @failedSaveProduct.
  ///
  /// In en, this message translates to:
  /// **'Failed to save product'**
  String get failedSaveProduct;

  /// No description provided for @pleaseEnterField.
  ///
  /// In en, this message translates to:
  /// **'Please enter {label}'**
  String pleaseEnterField(String label);

  /// No description provided for @colorVariant.
  ///
  /// In en, this message translates to:
  /// **'Color Variant {number}'**
  String colorVariant(int number);

  /// No description provided for @removeColor.
  ///
  /// In en, this message translates to:
  /// **'Remove Color'**
  String get removeColor;

  /// No description provided for @colorName.
  ///
  /// In en, this message translates to:
  /// **'Color Name'**
  String get colorName;

  /// No description provided for @colorNameExample.
  ///
  /// In en, this message translates to:
  /// **'Example: Red, Black, Blue'**
  String get colorNameExample;

  /// No description provided for @colorHex.
  ///
  /// In en, this message translates to:
  /// **'Color Hex Code'**
  String get colorHex;

  /// No description provided for @colorImages.
  ///
  /// In en, this message translates to:
  /// **'Color Images'**
  String get colorImages;

  /// No description provided for @imagesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} images'**
  String imagesCount(int count);

  /// No description provided for @noImagesAdded.
  ///
  /// In en, this message translates to:
  /// **'No images added'**
  String get noImagesAdded;

  /// No description provided for @openingGallery.
  ///
  /// In en, this message translates to:
  /// **'Opening gallery...'**
  String get openingGallery;

  /// No description provided for @addImagesFromDevice.
  ///
  /// In en, this message translates to:
  /// **'Add Images From Device'**
  String get addImagesFromDevice;

  /// No description provided for @editProduct.
  ///
  /// In en, this message translates to:
  /// **'Edit Product'**
  String get editProduct;

  /// No description provided for @addProduct.
  ///
  /// In en, this message translates to:
  /// **'Add Product'**
  String get addProduct;

  /// No description provided for @productInformation.
  ///
  /// In en, this message translates to:
  /// **'Product Information'**
  String get productInformation;

  /// No description provided for @productName.
  ///
  /// In en, this message translates to:
  /// **'Product Name'**
  String get productName;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @validPrice.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid price greater than zero'**
  String get validPrice;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @categoryExample.
  ///
  /// In en, this message translates to:
  /// **'Example: Clothes, Shoes, Accessories'**
  String get categoryExample;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @productColorsImages.
  ///
  /// In en, this message translates to:
  /// **'Product Colors & Images'**
  String get productColorsImages;

  /// No description provided for @colorsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} colors'**
  String colorsCount(int count);

  /// No description provided for @addAvailableColorsDescription.
  ///
  /// In en, this message translates to:
  /// **'Add available product colors and their images'**
  String get addAvailableColorsDescription;

  /// No description provided for @addAnotherColor.
  ///
  /// In en, this message translates to:
  /// **'Add Another Color'**
  String get addAnotherColor;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @editAction.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editAction;

  /// No description provided for @deleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAction;

  /// No description provided for @orderLabel.
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get orderLabel;

  /// No description provided for @updateOrderStatus.
  ///
  /// In en, this message translates to:
  /// **'Update order status'**
  String get updateOrderStatus;

  /// No description provided for @unknownCustomer.
  ///
  /// In en, this message translates to:
  /// **'Unknown Customer'**
  String get unknownCustomer;

  /// No description provided for @productsLabel.
  ///
  /// In en, this message translates to:
  /// **'Products'**
  String get productsLabel;

  /// No description provided for @unknownProduct.
  ///
  /// In en, this message translates to:
  /// **'Unknown Product'**
  String get unknownProduct;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @pendingStatus.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pendingStatus;

  /// No description provided for @processingStatus.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processingStatus;

  /// No description provided for @shippedStatus.
  ///
  /// In en, this message translates to:
  /// **'Shipped'**
  String get shippedStatus;

  /// No description provided for @deliveredStatus.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get deliveredStatus;

  /// No description provided for @cancelledStatus.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelledStatus;

  /// No description provided for @failedToLoadOrders.
  ///
  /// In en, this message translates to:
  /// **'Failed to load orders'**
  String get failedToLoadOrders;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @totalOrders.
  ///
  /// In en, this message translates to:
  /// **'Total Orders'**
  String get totalOrders;

  /// No description provided for @allOrders.
  ///
  /// In en, this message translates to:
  /// **'All Orders'**
  String get allOrders;

  /// No description provided for @ordersCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Orders'**
  String ordersCount(int count);

  /// No description provided for @noOrdersYet.
  ///
  /// In en, this message translates to:
  /// **'No Orders Yet'**
  String get noOrdersYet;

  /// No description provided for @ordersWillAppearHere.
  ///
  /// In en, this message translates to:
  /// **'Your orders will appear here'**
  String get ordersWillAppearHere;

  /// No description provided for @welcomeTo.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcomeTo;

  /// No description provided for @welcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover the latest men\'s fashion and find your perfect style.'**
  String get welcomeDescription;

  /// No description provided for @aboutFavoritesDescription.
  ///
  /// In en, this message translates to:
  /// **'Save your favorite products and access them easily anytime'**
  String get aboutFavoritesDescription;

  /// No description provided for @aboutSecureExperience.
  ///
  /// In en, this message translates to:
  /// **'Secure Shopping Experience'**
  String get aboutSecureExperience;

  /// No description provided for @aboutSecureExperienceDescription.
  ///
  /// In en, this message translates to:
  /// **'We provide a safe and reliable shopping experience to protect your data'**
  String get aboutSecureExperienceDescription;

  /// No description provided for @madeWithFlutter.
  ///
  /// In en, this message translates to:
  /// **'Made with Flutter'**
  String get madeWithFlutter;

  /// No description provided for @copyrightNotice.
  ///
  /// In en, this message translates to:
  /// **'All Rights Reserved © 2026'**
  String get copyrightNotice;

  /// No description provided for @myCart.
  ///
  /// In en, this message translates to:
  /// **'My Cart'**
  String get myCart;

  /// No description provided for @clearCart.
  ///
  /// In en, this message translates to:
  /// **'Clear Cart'**
  String get clearCart;

  /// No description provided for @yourCartIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your Cart Is Empty'**
  String get yourCartIsEmpty;

  /// No description provided for @emptyCartDescription.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any products to your shopping cart yet'**
  String get emptyCartDescription;

  /// No description provided for @proceedToCheckout.
  ///
  /// In en, this message translates to:
  /// **'Proceed to Checkout'**
  String get proceedToCheckout;

  /// No description provided for @categoryTops.
  ///
  /// In en, this message translates to:
  /// **'Tops'**
  String get categoryTops;

  /// No description provided for @categoryShoes.
  ///
  /// In en, this message translates to:
  /// **'Shoes'**
  String get categoryShoes;

  /// No description provided for @categoryWatches.
  ///
  /// In en, this message translates to:
  /// **'Watches'**
  String get categoryWatches;

  /// No description provided for @categoryBags.
  ///
  /// In en, this message translates to:
  /// **'Bags'**
  String get categoryBags;

  /// No description provided for @categoryJewelry.
  ///
  /// In en, this message translates to:
  /// **'Jewelry'**
  String get categoryJewelry;

  /// No description provided for @categoryDresses.
  ///
  /// In en, this message translates to:
  /// **'Dresses'**
  String get categoryDresses;

  /// No description provided for @categoryElectronics.
  ///
  /// In en, this message translates to:
  /// **'Electronics'**
  String get categoryElectronics;

  /// No description provided for @categoriesTitle.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categoriesTitle;

  /// No description provided for @couldNotLoadCategories.
  ///
  /// In en, this message translates to:
  /// **'Could not load categories'**
  String get couldNotLoadCategories;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @noCategoriesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No categories available'**
  String get noCategoriesAvailable;

  /// No description provided for @couldNotLoadProducts.
  ///
  /// In en, this message translates to:
  /// **'Could not load products'**
  String get couldNotLoadProducts;

  /// No description provided for @failedToLoadStoreProducts.
  ///
  /// In en, this message translates to:
  /// **'Failed to load store products'**
  String get failedToLoadStoreProducts;

  /// No description provided for @noProductsFoundInCategory.
  ///
  /// In en, this message translates to:
  /// **'No products found in this category'**
  String get noProductsFoundInCategory;

  /// No description provided for @noProductsFound.
  ///
  /// In en, this message translates to:
  /// **'No products found'**
  String get noProductsFound;

  /// No description provided for @exploreProducts.
  ///
  /// In en, this message translates to:
  /// **'Explore Products'**
  String get exploreProducts;

  /// No description provided for @categoryItemsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} products'**
  String categoryItemsCount(int count);

  /// No description provided for @aboutVersion.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get aboutVersion;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @aboutAppDescription.
  ///
  /// In en, this message translates to:
  /// **'We offer a convenient shopping experience where you can discover and purchase your favorite products easily.'**
  String get aboutAppDescription;

  /// No description provided for @aboutEasyShopping.
  ///
  /// In en, this message translates to:
  /// **'Easy Shopping'**
  String get aboutEasyShopping;

  /// No description provided for @aboutEasyShoppingDescription.
  ///
  /// In en, this message translates to:
  /// **'Browse products and shop easily from anywhere.'**
  String get aboutEasyShoppingDescription;

  /// No description provided for @aboutFavorites.
  ///
  /// In en, this message translates to:
  /// **'Your Favorites'**
  String get aboutFavorites;

  /// No description provided for @checkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkoutTitle;

  /// No description provided for @deliveryInformation.
  ///
  /// In en, this message translates to:
  /// **'Delivery Information'**
  String get deliveryInformation;

  /// No description provided for @checkoutFullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get checkoutFullName;

  /// No description provided for @checkoutPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get checkoutPhoneNumber;

  /// No description provided for @checkoutDeliveryAddress.
  ///
  /// In en, this message translates to:
  /// **'Delivery Address'**
  String get checkoutDeliveryAddress;

  /// No description provided for @paymentMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethodTitle;

  /// No description provided for @cashOnDelivery.
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get cashOnDelivery;

  /// No description provided for @promoCode.
  ///
  /// In en, this message translates to:
  /// **'Promo Code'**
  String get promoCode;

  /// No description provided for @enterPromoCode.
  ///
  /// In en, this message translates to:
  /// **'Enter promo code'**
  String get enterPromoCode;

  /// No description provided for @applyCoupon.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get applyCoupon;

  /// No description provided for @enterCouponCode.
  ///
  /// In en, this message translates to:
  /// **'Please enter a coupon code'**
  String get enterCouponCode;

  /// No description provided for @couponAppliedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Coupon applied successfully'**
  String get couponAppliedSuccessfully;

  /// No description provided for @removeCoupon.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removeCoupon;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @placeOrder.
  ///
  /// In en, this message translates to:
  /// **'Place Order'**
  String get placeOrder;

  /// No description provided for @orderPlacedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Order Placed Successfully'**
  String get orderPlacedSuccessfully;

  /// No description provided for @orderSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your order has been saved successfully.'**
  String get orderSavedSuccessfully;

  /// No description provided for @continueShopping.
  ///
  /// In en, this message translates to:
  /// **'Continue Shopping'**
  String get continueShopping;

  /// No description provided for @failedToPlaceOrder.
  ///
  /// In en, this message translates to:
  /// **'Failed to place order'**
  String get failedToPlaceOrder;

  /// No description provided for @validPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid phone number'**
  String get validPhoneNumber;

  /// No description provided for @pleaseEnterCheckoutField.
  ///
  /// In en, this message translates to:
  /// **'Please enter {field}'**
  String pleaseEnterCheckoutField(String field);

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get enterFullName;

  /// No description provided for @pleaseEnterYourName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterYourName;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmail;

  /// No description provided for @pleaseEnterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterYourEmail;

  /// No description provided for @validEmailAddress.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get validEmailAddress;

  /// No description provided for @emailVerificationRequired.
  ///
  /// In en, this message translates to:
  /// **'Email verification is required when changing your email address.'**
  String get emailVerificationRequired;

  /// No description provided for @pleaseLoginFirst.
  ///
  /// In en, this message translates to:
  /// **'Please login first'**
  String get pleaseLoginFirst;

  /// No description provided for @verificationEmailSent.
  ///
  /// In en, this message translates to:
  /// **'A verification email has been sent to your new email address.'**
  String get verificationEmailSent;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @myFavorites.
  ///
  /// In en, this message translates to:
  /// **'My Favorites'**
  String get myFavorites;

  /// No description provided for @failedToLoadFavorites.
  ///
  /// In en, this message translates to:
  /// **'Failed to load favorites'**
  String get failedToLoadFavorites;

  /// No description provided for @noFavoritesYet.
  ///
  /// In en, this message translates to:
  /// **'No Favorites Yet'**
  String get noFavoritesYet;

  /// No description provided for @addProductsToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Add products to your favorites to find them here.'**
  String get addProductsToFavorites;

  /// No description provided for @howCanWeHelp.
  ///
  /// In en, this message translates to:
  /// **'How Can We Help You?'**
  String get howCanWeHelp;

  /// No description provided for @helpDescription.
  ///
  /// In en, this message translates to:
  /// **'Find answers to common questions and get the support you need.'**
  String get helpDescription;

  /// No description provided for @frequentlyAskedQuestions.
  ///
  /// In en, this message translates to:
  /// **'Frequently Asked Questions'**
  String get frequentlyAskedQuestions;

  /// No description provided for @faqTrackOrderQuestion.
  ///
  /// In en, this message translates to:
  /// **'How can I track my order?'**
  String get faqTrackOrderQuestion;

  /// No description provided for @faqTrackOrderAnswer.
  ///
  /// In en, this message translates to:
  /// **'You can view your orders and their status from the My Orders section in your profile.'**
  String get faqTrackOrderAnswer;

  /// No description provided for @faqCancelOrderQuestion.
  ///
  /// In en, this message translates to:
  /// **'Can I cancel my order?'**
  String get faqCancelOrderQuestion;

  /// No description provided for @faqCancelOrderAnswer.
  ///
  /// In en, this message translates to:
  /// **'Please contact support as soon as possible to ask about cancelling your order.'**
  String get faqCancelOrderAnswer;

  /// No description provided for @faqAddFavoriteQuestion.
  ///
  /// In en, this message translates to:
  /// **'How can I add a product to my favorites?'**
  String get faqAddFavoriteQuestion;

  /// No description provided for @faqAddFavoriteAnswer.
  ///
  /// In en, this message translates to:
  /// **'Tap the heart icon on a product to add it to your favorites.'**
  String get faqAddFavoriteAnswer;

  /// No description provided for @faqChangePersonalInfoQuestion.
  ///
  /// In en, this message translates to:
  /// **'How can I change my personal information?'**
  String get faqChangePersonalInfoQuestion;

  /// No description provided for @faqChangePersonalInfoAnswer.
  ///
  /// In en, this message translates to:
  /// **'Open your profile, select Edit Profile, update your information, and save your changes.'**
  String get faqChangePersonalInfoAnswer;

  /// No description provided for @faqChangePasswordQuestion.
  ///
  /// In en, this message translates to:
  /// **'How can I change my password?'**
  String get faqChangePasswordQuestion;

  /// No description provided for @faqChangePasswordAnswer.
  ///
  /// In en, this message translates to:
  /// **'Open the Change Password section from your account settings and follow the instructions.'**
  String get faqChangePasswordAnswer;

  /// No description provided for @faqPaymentMethodsQuestion.
  ///
  /// In en, this message translates to:
  /// **'What payment methods are available?'**
  String get faqPaymentMethodsQuestion;

  /// No description provided for @faqPaymentMethodsAnswer.
  ///
  /// In en, this message translates to:
  /// **'Currently, you can pay for your order using Cash on Delivery.'**
  String get faqPaymentMethodsAnswer;

  /// No description provided for @stillNeedHelp.
  ///
  /// In en, this message translates to:
  /// **'Still Need Help?'**
  String get stillNeedHelp;

  /// No description provided for @contactSupportDescription.
  ///
  /// In en, this message translates to:
  /// **'Contact our support team if you need further assistance.'**
  String get contactSupportDescription;

  /// No description provided for @contactSupport.
  ///
  /// In en, this message translates to:
  /// **'Contact Support'**
  String get contactSupport;

  /// No description provided for @supportDetailsComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Support contact details will be available soon.'**
  String get supportDetailsComingSoon;

  /// No description provided for @supportDialogOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get supportDialogOk;

  /// No description provided for @loginWelcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get loginWelcomeBack;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue shopping'**
  String get loginSubtitle;

  /// No description provided for @loginEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginEmailLabel;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordLabel;

  /// No description provided for @loginForgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get loginForgotPassword;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @loginOr.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get loginOr;

  /// No description provided for @loginContinueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get loginContinueWithGoogle;

  /// No description provided for @loginNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get loginNoAccount;

  /// No description provided for @loginSignUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get loginSignUp;

  /// No description provided for @loginEnterEmailAndPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email and password'**
  String get loginEnterEmailAndPassword;

  /// No description provided for @loginUnableToSignIn.
  ///
  /// In en, this message translates to:
  /// **'Unable to sign in. Please try again.'**
  String get loginUnableToSignIn;

  /// No description provided for @loginInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'The email address is invalid'**
  String get loginInvalidEmail;

  /// No description provided for @loginIncorrectEmailOrPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password'**
  String get loginIncorrectEmailOrPassword;

  /// No description provided for @loginAccountDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled'**
  String get loginAccountDisabled;

  /// No description provided for @loginTooManyAttempts.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again later.'**
  String get loginTooManyAttempts;

  /// No description provided for @loginCheckInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'Please check your internet connection'**
  String get loginCheckInternetConnection;

  /// No description provided for @loginFailedTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please try again.'**
  String get loginFailedTryAgain;

  /// No description provided for @loginEmailNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Email Not Verified'**
  String get loginEmailNotVerified;

  /// No description provided for @loginEmailNotVerifiedMessage.
  ///
  /// In en, this message translates to:
  /// **'Your email address {email} has not been verified. Would you like us to send another verification email?'**
  String loginEmailNotVerifiedMessage(String email);

  /// No description provided for @loginResendEmail.
  ///
  /// In en, this message translates to:
  /// **'Resend Email'**
  String get loginResendEmail;

  /// No description provided for @loginVerificationEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Verification email sent successfully'**
  String get loginVerificationEmailSent;

  /// No description provided for @loginEmailAlreadyVerified.
  ///
  /// In en, this message translates to:
  /// **'Your email is already verified'**
  String get loginEmailAlreadyVerified;

  /// No description provided for @loginWaitBeforeRequestingEmail.
  ///
  /// In en, this message translates to:
  /// **'Please wait before requesting another email'**
  String get loginWaitBeforeRequestingEmail;

  /// No description provided for @loginCouldNotSendVerificationEmail.
  ///
  /// In en, this message translates to:
  /// **'Could not send verification email'**
  String get loginCouldNotSendVerificationEmail;

  /// No description provided for @loginGoogleFailed.
  ///
  /// In en, this message translates to:
  /// **'Google sign-in failed. Please try again.'**
  String get loginGoogleFailed;

  /// No description provided for @loginEnterEmailFirst.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address first'**
  String get loginEnterEmailFirst;

  /// No description provided for @loginPasswordResetEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent successfully'**
  String get loginPasswordResetEmailSent;

  /// No description provided for @loginCouldNotSendPasswordResetEmail.
  ///
  /// In en, this message translates to:
  /// **'Could not send password reset email'**
  String get loginCouldNotSendPasswordResetEmail;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @homeAddress.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeAddress;

  /// No description provided for @defaultAddress.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultAddress;

  /// No description provided for @setAsDefaultAddress.
  ///
  /// In en, this message translates to:
  /// **'Set as default address'**
  String get setAsDefaultAddress;

  /// No description provided for @addAddress.
  ///
  /// In en, this message translates to:
  /// **'Add Address'**
  String get addAddress;

  /// No description provided for @deleteAddressTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Address'**
  String get deleteAddressTitle;

  /// No description provided for @deleteAddressConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this address?'**
  String get deleteAddressConfirmation;

  /// No description provided for @noAddressesYet.
  ///
  /// In en, this message translates to:
  /// **'No Addresses Yet'**
  String get noAddressesYet;

  /// No description provided for @addAddressDescription.
  ///
  /// In en, this message translates to:
  /// **'Add a delivery address to make checkout easier.'**
  String get addAddressDescription;

  /// No description provided for @editAddress.
  ///
  /// In en, this message translates to:
  /// **'Edit Address'**
  String get editAddress;

  /// No description provided for @streetAddress.
  ///
  /// In en, this message translates to:
  /// **'Street Address'**
  String get streetAddress;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @addressFieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get addressFieldRequired;

  /// No description provided for @addNewAddress.
  ///
  /// In en, this message translates to:
  /// **'Add New Address'**
  String get addNewAddress;

  /// No description provided for @addressName.
  ///
  /// In en, this message translates to:
  /// **'Address Name'**
  String get addressName;

  /// No description provided for @addressNameHint.
  ///
  /// In en, this message translates to:
  /// **'Example: Home, Work'**
  String get addressNameHint;

  /// No description provided for @onboardingTitle.
  ///
  /// In en, this message translates to:
  /// **'Find Everything You Love'**
  String get onboardingTitle;

  /// No description provided for @onboardingDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover amazing products and enjoy a simple shopping experience.'**
  String get onboardingDescription;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @chooseNotifications.
  ///
  /// In en, this message translates to:
  /// **'Choose which notifications you want to receive'**
  String get chooseNotifications;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @orderUpdates.
  ///
  /// In en, this message translates to:
  /// **'Order Updates'**
  String get orderUpdates;

  /// No description provided for @orderUpdatesDescription.
  ///
  /// In en, this message translates to:
  /// **'Receive updates about your orders'**
  String get orderUpdatesDescription;

  /// No description provided for @promotionsOffers.
  ///
  /// In en, this message translates to:
  /// **'Promotions & Offers'**
  String get promotionsOffers;

  /// No description provided for @promotionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Get notified about discounts and special offers'**
  String get promotionsDescription;

  /// No description provided for @recommendations.
  ///
  /// In en, this message translates to:
  /// **'Recommendations'**
  String get recommendations;

  /// No description provided for @recommendationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Discover products picked for you'**
  String get recommendationsDescription;

  /// No description provided for @notificationChannels.
  ///
  /// In en, this message translates to:
  /// **'Notification Channels'**
  String get notificationChannels;

  /// No description provided for @pushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Push Notifications'**
  String get pushNotifications;

  /// No description provided for @pushNotificationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Receive notifications on your device'**
  String get pushNotificationsDescription;

  /// No description provided for @emailNotifications.
  ///
  /// In en, this message translates to:
  /// **'Email Notifications'**
  String get emailNotifications;

  /// No description provided for @emailNotificationsDescription.
  ///
  /// In en, this message translates to:
  /// **'Receive notifications by email'**
  String get emailNotificationsDescription;

  /// No description provided for @notificationSettingsInfo.
  ///
  /// In en, this message translates to:
  /// **'You can change these preferences at any time.'**
  String get notificationSettingsInfo;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing'**
  String get processing;

  /// No description provided for @shipped.
  ///
  /// In en, this message translates to:
  /// **'Shipped'**
  String get shipped;

  /// No description provided for @delivered.
  ///
  /// In en, this message translates to:
  /// **'Delivered'**
  String get delivered;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @cancelOrder.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get cancelOrder;

  /// No description provided for @cancelOrderConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this order?'**
  String get cancelOrderConfirmation;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yesCancel.
  ///
  /// In en, this message translates to:
  /// **'Yes, Cancel'**
  String get yesCancel;

  /// No description provided for @orderCancelledSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Order cancelled successfully'**
  String get orderCancelledSuccessfully;

  /// No description provided for @failedToCancelOrder.
  ///
  /// In en, this message translates to:
  /// **'Failed to cancel order'**
  String get failedToCancelOrder;

  /// No description provided for @deleteOrder.
  ///
  /// In en, this message translates to:
  /// **'Delete Order'**
  String get deleteOrder;

  /// No description provided for @deleteOrderConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this order?'**
  String get deleteOrderConfirmation;

  /// No description provided for @yesDelete.
  ///
  /// In en, this message translates to:
  /// **'Yes, Delete'**
  String get yesDelete;

  /// No description provided for @orderDeletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Order deleted successfully'**
  String get orderDeletedSuccessfully;

  /// No description provided for @failedToDeleteOrder.
  ///
  /// In en, this message translates to:
  /// **'Failed to delete order'**
  String get failedToDeleteOrder;

  /// No description provided for @dateUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Date unavailable'**
  String get dateUnavailable;

  /// No description provided for @orderDetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get orderDetails;

  /// No description provided for @orderId.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get orderId;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @editPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Edit Payment Method'**
  String get editPaymentMethod;

  /// No description provided for @addPaymentMethod.
  ///
  /// In en, this message translates to:
  /// **'Add Payment Method'**
  String get addPaymentMethod;

  /// No description provided for @cardholderName.
  ///
  /// In en, this message translates to:
  /// **'Cardholder Name'**
  String get cardholderName;

  /// No description provided for @enterCardholderName.
  ///
  /// In en, this message translates to:
  /// **'Enter cardholder name'**
  String get enterCardholderName;

  /// No description provided for @lastFourDigits.
  ///
  /// In en, this message translates to:
  /// **'Last Four Digits'**
  String get lastFourDigits;

  /// No description provided for @enterExactlyFourDigits.
  ///
  /// In en, this message translates to:
  /// **'Enter exactly 4 digits'**
  String get enterExactlyFourDigits;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate;

  /// No description provided for @useMmYyFormat.
  ///
  /// In en, this message translates to:
  /// **'Use MM/YY format'**
  String get useMmYyFormat;

  /// No description provided for @setAsDefault.
  ///
  /// In en, this message translates to:
  /// **'Set as default'**
  String get setAsDefault;

  /// No description provided for @addCard.
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get addCard;

  /// No description provided for @deleteCard.
  ///
  /// In en, this message translates to:
  /// **'Delete Card'**
  String get deleteCard;

  /// No description provided for @deletePaymentConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this payment method?'**
  String get deletePaymentConfirmation;

  /// No description provided for @noPaymentMethods.
  ///
  /// In en, this message translates to:
  /// **'No Payment Methods'**
  String get noPaymentMethods;

  /// No description provided for @addPaymentDescription.
  ///
  /// In en, this message translates to:
  /// **'Add a payment method to make checkout easier.'**
  String get addPaymentDescription;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @productDetails.
  ///
  /// In en, this message translates to:
  /// **'Product Details'**
  String get productDetails;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// No description provided for @productAddedToCart.
  ///
  /// In en, this message translates to:
  /// **'{product} added to cart'**
  String productAddedToCart(String product);

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to Cart'**
  String get addToCart;

  /// No description provided for @searchProducts.
  ///
  /// In en, this message translates to:
  /// **'Search Products'**
  String get searchProducts;

  /// No description provided for @searchForProducts.
  ///
  /// In en, this message translates to:
  /// **'Search for products'**
  String get searchForProducts;

  /// No description provided for @findFavoriteProducts.
  ///
  /// In en, this message translates to:
  /// **'Find Your Favorite Products'**
  String get findFavoriteProducts;

  /// No description provided for @searchByProductName.
  ///
  /// In en, this message translates to:
  /// **'Search by product name'**
  String get searchByProductName;

  /// No description provided for @searchResults.
  ///
  /// In en, this message translates to:
  /// **'Search Results'**
  String get searchResults;

  /// No description provided for @items.
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get items;

  /// No description provided for @failedToLoadSearchResults.
  ///
  /// In en, this message translates to:
  /// **'Failed to load search results'**
  String get failedToLoadSearchResults;

  /// No description provided for @trySearchingAnotherName.
  ///
  /// In en, this message translates to:
  /// **'Try searching for another name'**
  String get trySearchingAnotherName;

  /// No description provided for @shopper.
  ///
  /// In en, this message translates to:
  /// **'Shopper'**
  String get shopper;

  /// No description provided for @helloShopper.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}'**
  String helloShopper(String name);

  /// No description provided for @findYourStyle.
  ///
  /// In en, this message translates to:
  /// **'Find Your Style'**
  String get findYourStyle;

  /// No description provided for @searchProductsHint.
  ///
  /// In en, this message translates to:
  /// **'Search products...'**
  String get searchProductsHint;

  /// No description provided for @newCollection.
  ///
  /// In en, this message translates to:
  /// **'NEW COLLECTION'**
  String get newCollection;

  /// No description provided for @discoverYourStyle.
  ///
  /// In en, this message translates to:
  /// **'Discover Your Style'**
  String get discoverYourStyle;

  /// No description provided for @exploreLatestFashion.
  ///
  /// In en, this message translates to:
  /// **'Explore the latest fashion trends'**
  String get exploreLatestFashion;

  /// No description provided for @shopNow.
  ///
  /// In en, this message translates to:
  /// **'Shop Now'**
  String get shopNow;

  /// No description provided for @categories.
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get categories;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @featuredProducts.
  ///
  /// In en, this message translates to:
  /// **'Featured Products'**
  String get featuredProducts;

  /// No description provided for @itemCount.
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String itemCount(int count);

  /// No description provided for @pleaseFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all fields'**
  String get pleaseFillAllFields;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get enterValidEmail;

  /// No description provided for @verifyYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Email'**
  String get verifyYourEmail;

  /// No description provided for @verificationEmailInstructions.
  ///
  /// In en, this message translates to:
  /// **'We have sent a verification email to {email}. Please check your inbox.'**
  String verificationEmailInstructions(String email);

  /// No description provided for @gotIt.
  ///
  /// In en, this message translates to:
  /// **'Got It'**
  String get gotIt;

  /// No description provided for @joinShoppingApp.
  ///
  /// In en, this message translates to:
  /// **'Join Shopping App'**
  String get joinShoppingApp;

  /// No description provided for @createAccountDescription.
  ///
  /// In en, this message translates to:
  /// **'Create an account to start your shopping journey'**
  String get createAccountDescription;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @createPassword.
  ///
  /// In en, this message translates to:
  /// **'Create a password'**
  String get createPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @confirmYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmYourPassword;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @favorites.
  ///
  /// In en, this message translates to:
  /// **'Favorites'**
  String get favorites;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @addedToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Added to favorites'**
  String get addedToFavorites;

  /// No description provided for @removedFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Removed from favorites'**
  String get removedFromFavorites;

  /// No description provided for @addToFavorites.
  ///
  /// In en, this message translates to:
  /// **'Add to favorites'**
  String get addToFavorites;

  /// No description provided for @removeFromFavorites.
  ///
  /// In en, this message translates to:
  /// **'Remove from favorites'**
  String get removeFromFavorites;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @categoryClothing.
  ///
  /// In en, this message translates to:
  /// **'Clothing'**
  String get categoryClothing;

  /// No description provided for @categoryClothingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore men\'s, women\'s and kids\' clothing'**
  String get categoryClothingSubtitle;

  /// No description provided for @categoryAccessories.
  ///
  /// In en, this message translates to:
  /// **'Accessories'**
  String get categoryAccessories;

  /// No description provided for @categoryAccessoriesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Complete your look with accessories'**
  String get categoryAccessoriesSubtitle;

  /// No description provided for @categoryMen.
  ///
  /// In en, this message translates to:
  /// **'Men'**
  String get categoryMen;

  /// No description provided for @categoryWomen.
  ///
  /// In en, this message translates to:
  /// **'Women'**
  String get categoryWomen;

  /// No description provided for @categoryKids.
  ///
  /// In en, this message translates to:
  /// **'Kids'**
  String get categoryKids;

  /// No description provided for @categorySunglasses.
  ///
  /// In en, this message translates to:
  /// **'Sunglasses'**
  String get categorySunglasses;

  /// No description provided for @categoryBelts.
  ///
  /// In en, this message translates to:
  /// **'Belts'**
  String get categoryBelts;

  /// No description provided for @categoryWallets.
  ///
  /// In en, this message translates to:
  /// **'Wallets'**
  String get categoryWallets;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
