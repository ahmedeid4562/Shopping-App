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
