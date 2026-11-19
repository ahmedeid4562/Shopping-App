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
    return '$count صور';
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
    return '$count ألوان';
  }

  @override
  String get addAvailableColorsDescription =>
      'أضف الألوان المتاحة للمنتج والصور الخاصة بكل لون';

  @override
  String get addAnotherColor => 'إضافة لون آخر';

  @override
  String get saveChanges => 'حفظ التعديلات';
}
