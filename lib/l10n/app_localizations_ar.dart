// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تطبيق التسوق';

  @override
  String get user => 'مستخدم';

  @override
  String get noEmailAvailable => 'لا يوجد بريد إلكتروني';

  @override
  String get myProfile => 'ملفي الشخصي';

  @override
  String get myAccount => 'حسابي';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get updatePersonalInfo => 'تحديث معلوماتك الشخصية';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get updateAccountPassword => 'تحديث كلمة مرور حسابك';

  @override
  String get myOrders => 'طلباتي';

  @override
  String get viewOrderHistory => 'عرض سجل طلباتك';

  @override
  String get myAddresses => 'عناويني';

  @override
  String get manageAddresses => 'إدارة عناوين التوصيل';

  @override
  String get paymentMethods => 'طرق الدفع';

  @override
  String get managePaymentOptions => 'إدارة خيارات الدفع';

  @override
  String get preferences => 'التفضيلات';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get darkAppearanceEnabled => 'تم تفعيل المظهر الداكن';

  @override
  String get lightAppearanceEnabled => 'تم تفعيل المظهر الفاتح';

  @override
  String get language => 'اللغة';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'الإنجليزية';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get manageNotifications => 'إدارة الإشعارات';

  @override
  String get support => 'الدعم';

  @override
  String get helpSupport => 'المساعدة والدعم';

  @override
  String get getHelpAccount => 'احصل على المساعدة بشأن حسابك';

  @override
  String get aboutApp => 'حول التطبيق';

  @override
  String get learnAboutApp => 'تعرف على المزيد حول تطبيقنا';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get shoppingMember => 'عضو في تطبيق التسوق';

  @override
  String get pleaseLoginAgain => 'يرجى تسجيل الدخول مرة أخرى';

  @override
  String get accountNoEmailPassword =>
      'حسابك لا يحتوي على بريد إلكتروني وكلمة مرور';

  @override
  String get currentPassword => 'كلمة المرور الحالية';

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get confirmNewPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get fillAllFields => 'يرجى ملء جميع الحقول';

  @override
  String get passwordMinLength =>
      'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';

  @override
  String get passwordsDoNotMatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get newPasswordDifferent =>
      'يجب أن تختلف كلمة المرور الجديدة عن الحالية';

  @override
  String get passwordChangedSuccessfully => 'تم تغيير كلمة المرور بنجاح';

  @override
  String get incorrectCurrentPassword => 'كلمة المرور الحالية غير صحيحة';

  @override
  String get chooseStrongerPassword => 'يرجى اختيار كلمة مرور أقوى';

  @override
  String get somethingWentWrong => 'حدث خطأ ما';

  @override
  String get logoutConfirmation => 'هل أنت متأكد أنك تريد تسجيل الخروج؟';

  @override
  String get logoutFailed => 'فشل تسجيل الخروج';

  @override
  String get adminDashboard => 'لوحة تحكم المسؤول';

  @override
  String get manageStoreOrders => 'إدارة طلبات المتجر';

  @override
  String get changeAdminPassword => 'تغيير كلمة مرور الأدمن';

  @override
  String get failedToChangePassword => 'فشل تغيير كلمة المرور';

  @override
  String get orderInformationMissing => 'بيانات الطلب غير مكتملة';

  @override
  String get orderStatusUpdatedTo => 'تم تحديث حالة الطلب إلى';

  @override
  String get failedToUpdateOrder => 'فشل تحديث الطلب';

  @override
  String get failedToVerifyAdminAccess => 'فشل التحقق من صلاحيات الأدمن';

  @override
  String get accessDenied => 'تم رفض الوصول';

  @override
  String get adminPrivilegesRequired => 'يلزم توفر صلاحيات الأدمن';

  @override
  String get manageProducts => 'إدارة المنتجات';

  @override
  String get manageProductsSubtitle => 'إضافة المنتجات وتعديلها وحذفها';

  @override
  String get productAddedSuccessfully => 'تمت إضافة المنتج بنجاح';

  @override
  String get productUpdatedSuccessfully => 'تم تحديث المنتج بنجاح';

  @override
  String get cannotDeleteProduct => 'لا يمكن حذف هذا المنتج';

  @override
  String get deleteProductTitle => 'حذف المنتج';

  @override
  String deleteProductConfirmation(String productName) {
    return 'هل أنت متأكد أنك تريد حذف \"$productName\"؟';
  }

  @override
  String get productDeletedSuccessfully => 'تم حذف المنتج بنجاح';

  @override
  String get failedToDeleteProduct => 'فشل حذف المنتج';

  @override
  String get failedToLoadProducts => 'فشل تحميل المنتجات';

  @override
  String get noProductsYet => 'لا توجد منتجات حتى الآن';

  @override
  String get startAddingProducts => 'ابدأ بإضافة المنتجات إلى متجرك';

  @override
  String get addYourFirstProduct => 'أضف أول منتج لك';

  @override
  String get storeProducts => 'منتجات المتجر';

  @override
  String productsCount(int count) {
    return 'عدد المنتجات: $count';
  }

  @override
  String get manageCoupons => 'إدارة الكوبونات';

  @override
  String get manageCouponsSubtitle => 'إنشاء وإدارة أكواد الخصم';

  @override
  String get createCoupon => 'إنشاء كوبون';

  @override
  String get couponCode => 'كود الكوبون';

  @override
  String get enterAtLeast3Characters => 'أدخل 3 أحرف على الأقل';

  @override
  String get discountType => 'نوع الخصم';

  @override
  String get percentage => 'نسبة مئوية (%)';

  @override
  String get fixedAmount => 'مبلغ ثابت';

  @override
  String get discountPercentage => 'نسبة الخصم';

  @override
  String get discountAmount => 'قيمة الخصم';

  @override
  String get enterValidDiscount => 'أدخل قيمة خصم صحيحة';

  @override
  String get maximumPercentageIs100 => 'الحد الأقصى لنسبة الخصم هو 100%';

  @override
  String get minimumOrderAmount => 'الحد الأدنى لقيمة الطلب';

  @override
  String get enterValidAmount => 'أدخل مبلغًا صحيحًا';

  @override
  String get chooseExpirationDate => 'اختر تاريخ انتهاء الصلاحية';

  @override
  String get chooseExpirationDateFirst => 'من فضلك اختر تاريخ انتهاء الصلاحية';

  @override
  String get create => 'إنشاء';

  @override
  String get couponCreatedSuccessfully => 'تم إنشاء الكوبون بنجاح';

  @override
  String get failedToCreateCoupon => 'فشل إنشاء الكوبون';

  @override
  String get couponDeleted => 'تم حذف الكوبون';

  @override
  String get failedToDeleteCoupon => 'فشل حذف الكوبون';

  @override
  String get couponDeactivated => 'تم إلغاء تفعيل الكوبون';

  @override
  String get couponActivated => 'تم تفعيل الكوبون';

  @override
  String get failedToUpdateCoupon => 'فشل تحديث الكوبون';

  @override
  String get failedToLoadCoupons => 'فشل تحميل الكوبونات';

  @override
  String get noCouponsCreatedYet => 'لم يتم إنشاء أي كوبونات حتى الآن';

  @override
  String get addCoupon => 'إضافة كوبون';

  @override
  String get off => 'خصم';

  @override
  String get minimumOrder => 'الحد الأدنى للطلب';

  @override
  String get expires => 'تاريخ الانتهاء';

  @override
  String get status => 'الحالة';

  @override
  String get active => 'نشط';

  @override
  String get inactive => 'غير نشط';

  @override
  String get deactivate => 'إلغاء التفعيل';

  @override
  String get activate => 'تفعيل';

  @override
  String get failedSelectImages => 'فشل في اختيار الصور';

  @override
  String enterColorName(int number) {
    return 'أدخل اسم اللون رقم $number';
  }

  @override
  String invalidHexColor(String colorName) {
    return 'كود اللون غير صحيح للون $colorName';
  }

  @override
  String addAtLeastOneImage(String colorName) {
    return 'أضف صورة واحدة على الأقل للون $colorName';
  }

  @override
  String noValidImages(String colorName) {
    return 'لا توجد صور صالحة للون $colorName';
  }

  @override
  String get addAtLeastOneColor => 'أضف لونًا واحدًا على الأقل';

  @override
  String get enterAllColorNames => 'يرجى إدخال أسماء جميع الألوان';

  @override
  String get uniqueColorNames => 'يجب أن تكون أسماء الألوان مختلفة';

  @override
  String get addProductImages => 'يرجى إضافة صور للمنتج';

  @override
  String get productIdMissing => 'معرف المنتج غير موجود';

  @override
  String get failedSaveProduct => 'فشل حفظ المنتج';

  @override
  String pleaseEnterField(String label) {
    return 'يرجى إدخال $label';
  }

  @override
  String colorVariant(int number) {
    return 'اللون رقم $number';
  }

  @override
  String get removeColor => 'حذف اللون';

  @override
  String get colorName => 'اسم اللون';

  @override
  String get colorNameExample => 'مثال: أحمر، أسود، أزرق';

  @override
  String get colorHex => 'كود اللون';

  @override
  String get colorImages => 'صور اللون';

  @override
  String imagesCount(int count) {
    return 'عدد الصور: $count';
  }

  @override
  String get noImagesAdded => 'لم تتم إضافة صور';

  @override
  String get openingGallery => 'جاري فتح المعرض...';

  @override
  String get addImagesFromDevice => 'إضافة صور من الجهاز';

  @override
  String get editProduct => 'تعديل المنتج';

  @override
  String get addProduct => 'إضافة منتج';

  @override
  String get productInformation => 'معلومات المنتج';

  @override
  String get productName => 'اسم المنتج';

  @override
  String get price => 'السعر';

  @override
  String get validPrice => 'يرجى إدخال سعر صحيح أكبر من صفر';

  @override
  String get category => 'التصنيف';

  @override
  String get categoryExample => 'مثال: ملابس، أحذية، إكسسوارات';

  @override
  String get description => 'الوصف';

  @override
  String get productColorsImages => 'ألوان وصور المنتج';

  @override
  String colorsCount(int count) {
    return 'عدد الألوان: $count';
  }

  @override
  String get addAvailableColorsDescription =>
      'أضف الألوان المتاحة للمنتج والصور الخاصة بكل لون';

  @override
  String get addAnotherColor => 'إضافة لون آخر';

  @override
  String get saveChanges => 'حفظ التعديلات';

  @override
  String get editAction => 'تعديل';

  @override
  String get deleteAction => 'حذف';

  @override
  String get orderLabel => 'طلب';

  @override
  String get updateOrderStatus => 'تحديث حالة الطلب';

  @override
  String get unknownCustomer => 'عميل غير معروف';

  @override
  String get productsLabel => 'المنتجات';

  @override
  String get unknownProduct => 'منتج غير معروف';

  @override
  String get totalAmount => 'الإجمالي';

  @override
  String get pendingStatus => 'قيد الانتظار';

  @override
  String get processingStatus => 'جاري التجهيز';

  @override
  String get shippedStatus => 'تم الشحن';

  @override
  String get deliveredStatus => 'تم التوصيل';

  @override
  String get cancelledStatus => 'تم الإلغاء';

  @override
  String get failedToLoadOrders => 'فشل تحميل الطلبات';

  @override
  String get overview => 'نظرة عامة';

  @override
  String get totalOrders => 'إجمالي الطلبات';

  @override
  String get allOrders => 'جميع الطلبات';

  @override
  String ordersCount(int count) {
    return 'عدد الطلبات: $count';
  }

  @override
  String get noOrdersYet => 'لا توجد طلبات حتى الآن';
}
