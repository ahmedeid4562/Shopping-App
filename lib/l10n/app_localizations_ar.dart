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
  String get appVersion => 'الإصدار 1.0.0';

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

  @override
  String get ordersWillAppearHere => 'ستظهر طلباتك هنا';

  @override
  String get welcomeTo => 'مرحباً بك في';

  @override
  String get welcomeDescription =>
      'اكتشف أحدث صيحات الموضة الرجالية واعثر على أسلوبك المثالي.';

  @override
  String get aboutFavoritesDescription =>
      'احفظ منتجاتك المفضلة للوصول إليها بسهولة في أي وقت';

  @override
  String get aboutSecureExperience => 'تجربة تسوق آمنة';

  @override
  String get aboutSecureExperienceDescription =>
      'نوفر لك تجربة تسوق آمنة وموثوقة لحماية بياناتك';

  @override
  String get madeWithFlutter => 'تم التطوير باستخدام Flutter';

  @override
  String get copyrightNotice => 'جميع الحقوق محفوظة © 2026';

  @override
  String get myCart => 'سلة التسوق';

  @override
  String get clearCart => 'إفراغ السلة';

  @override
  String get yourCartIsEmpty => 'سلة التسوق فارغة';

  @override
  String get emptyCartDescription =>
      'لم تقم بإضافة أي منتجات إلى سلة التسوق حتى الآن';

  @override
  String get proceedToCheckout => 'إتمام الشراء';

  @override
  String get categoryTops => 'القمصان والبلوزات';

  @override
  String get categoryShoes => 'الأحذية';

  @override
  String get categoryWatches => 'الساعات';

  @override
  String get categoryBags => 'الحقائب';

  @override
  String get categoryJewelry => 'المجوهرات';

  @override
  String get categoryDresses => 'الفساتين';

  @override
  String get categoryElectronics => 'الإلكترونيات';

  @override
  String get categoriesTitle => 'التصنيفات';

  @override
  String get couldNotLoadCategories => 'تعذر تحميل التصنيفات';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get noCategoriesAvailable => 'لا توجد تصنيفات متاحة';

  @override
  String get couldNotLoadProducts => 'تعذر تحميل المنتجات';

  @override
  String get failedToLoadStoreProducts => 'فشل تحميل منتجات المتجر';

  @override
  String get noProductsFoundInCategory => 'لا توجد منتجات في هذا التصنيف';

  @override
  String get noProductsFound => 'لم يتم العثور على منتجات';

  @override
  String get exploreProducts => 'استكشف المنتجات';

  @override
  String categoryItemsCount(int count) {
    return '$count منتجات';
  }

  @override
  String get aboutVersion => 'الإصدار 1.0.0';

  @override
  String get aboutUs => 'من نحن';

  @override
  String get aboutAppDescription =>
      'نوفر لك تجربة تسوق سهلة ومريحة تتيح لك اكتشاف وشراء منتجاتك المفضلة بكل سهولة.';

  @override
  String get aboutEasyShopping => 'تسوق بسهولة';

  @override
  String get aboutEasyShoppingDescription =>
      'تصفح المنتجات وتسوق بسهولة من أي مكان.';

  @override
  String get aboutFavorites => 'منتجاتك المفضلة';

  @override
  String get checkoutTitle => 'إتمام الشراء';

  @override
  String get deliveryInformation => 'معلومات التوصيل';

  @override
  String get checkoutFullName => 'الاسم بالكامل';

  @override
  String get checkoutPhoneNumber => 'رقم الهاتف';

  @override
  String get checkoutDeliveryAddress => 'عنوان التوصيل';

  @override
  String get paymentMethodTitle => 'طريقة الدفع';

  @override
  String get cashOnDelivery => 'الدفع عند الاستلام';

  @override
  String get promoCode => 'كود الخصم';

  @override
  String get enterPromoCode => 'أدخل كود الخصم';

  @override
  String get applyCoupon => 'تطبيق';

  @override
  String get enterCouponCode => 'يرجى إدخال كود الخصم';

  @override
  String get couponAppliedSuccessfully => 'تم تطبيق الكوبون بنجاح';

  @override
  String get removeCoupon => 'إزالة';

  @override
  String get subtotal => 'المبلغ الفرعي';

  @override
  String get discount => 'الخصم';

  @override
  String get placeOrder => 'تأكيد الطلب';

  @override
  String get orderPlacedSuccessfully => 'تم تأكيد الطلب بنجاح';

  @override
  String get orderSavedSuccessfully => 'تم حفظ طلبك بنجاح.';

  @override
  String get continueShopping => 'متابعة التسوق';

  @override
  String get failedToPlaceOrder => 'فشل في تأكيد الطلب';

  @override
  String get validPhoneNumber => 'يرجى إدخال رقم هاتف صحيح';

  @override
  String pleaseEnterCheckoutField(String field) {
    return 'يرجى إدخال $field';
  }

  @override
  String get fullName => 'الاسم بالكامل';

  @override
  String get enterYourName => 'أدخل اسمك';

  @override
  String get enterFullName => 'أدخل اسمك بالكامل';

  @override
  String get pleaseEnterYourName => 'يرجى إدخال اسمك';

  @override
  String get emailAddress => 'البريد الإلكتروني';

  @override
  String get enterYourEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get pleaseEnterYourEmail => 'يرجى إدخال بريدك الإلكتروني';

  @override
  String get validEmailAddress => 'يرجى إدخال بريد إلكتروني صحيح';

  @override
  String get emailVerificationRequired =>
      'يجب تأكيد البريد الإلكتروني عند تغييره.';

  @override
  String get pleaseLoginFirst => 'يرجى تسجيل الدخول أولاً';

  @override
  String get verificationEmailSent =>
      'تم إرسال رسالة تأكيد إلى بريدك الإلكتروني الجديد.';

  @override
  String get profileUpdatedSuccessfully => 'تم تحديث الملف الشخصي بنجاح';

  @override
  String get myFavorites => 'المفضلة';

  @override
  String get failedToLoadFavorites => 'فشل تحميل المنتجات المفضلة';

  @override
  String get noFavoritesYet => 'لا توجد منتجات مفضلة حتى الآن';

  @override
  String get addProductsToFavorites => 'أضف المنتجات إلى المفضلة لتجدها هنا.';

  @override
  String get howCanWeHelp => 'كيف يمكننا مساعدتك؟';

  @override
  String get helpDescription =>
      'اعثر على إجابات للأسئلة الشائعة واحصل على الدعم الذي تحتاجه.';

  @override
  String get frequentlyAskedQuestions => 'الأسئلة الشائعة';

  @override
  String get faqTrackOrderQuestion => 'كيف يمكنني تتبع طلبي؟';

  @override
  String get faqTrackOrderAnswer =>
      'يمكنك عرض طلباتك وحالتها من قسم طلباتي في ملفك الشخصي.';

  @override
  String get faqCancelOrderQuestion => 'هل يمكنني إلغاء طلبي؟';

  @override
  String get faqCancelOrderAnswer =>
      'يرجى التواصل مع الدعم في أقرب وقت ممكن للاستفسار عن إمكانية إلغاء طلبك.';

  @override
  String get faqAddFavoriteQuestion => 'كيف أضيف منتجًا إلى المفضلة؟';

  @override
  String get faqAddFavoriteAnswer =>
      'اضغط على أيقونة القلب الموجودة على المنتج لإضافته إلى المفضلة.';

  @override
  String get faqChangePersonalInfoQuestion =>
      'كيف يمكنني تغيير معلوماتي الشخصية؟';

  @override
  String get faqChangePersonalInfoAnswer =>
      'افتح ملفك الشخصي، واختر تعديل الملف الشخصي، ثم حدّث معلوماتك واحفظ التغييرات.';

  @override
  String get faqChangePasswordQuestion => 'كيف يمكنني تغيير كلمة المرور؟';

  @override
  String get faqChangePasswordAnswer =>
      'افتح قسم تغيير كلمة المرور من إعدادات حسابك واتبع التعليمات.';

  @override
  String get faqPaymentMethodsQuestion => 'ما طرق الدفع المتاحة؟';

  @override
  String get faqPaymentMethodsAnswer =>
      'يمكنك حاليًا دفع قيمة طلبك عند الاستلام.';

  @override
  String get stillNeedHelp => 'هل ما زلت بحاجة إلى مساعدة؟';

  @override
  String get contactSupportDescription =>
      'تواصل مع فريق الدعم إذا كنت بحاجة إلى مزيد من المساعدة.';

  @override
  String get contactSupport => 'تواصل مع الدعم';

  @override
  String get supportDetailsComingSoon =>
      'ستتوفر بيانات التواصل مع الدعم قريبًا.';

  @override
  String get supportDialogOk => 'حسنًا';

  @override
  String get loginWelcomeBack => 'مرحبًا بعودتك';

  @override
  String get loginSubtitle => 'سجل الدخول لمتابعة التسوق';

  @override
  String get loginEmailLabel => 'البريد الإلكتروني';

  @override
  String get loginPasswordLabel => 'كلمة المرور';

  @override
  String get loginForgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get loginOr => 'أو';

  @override
  String get loginContinueWithGoogle => 'المتابعة باستخدام Google';

  @override
  String get loginNoAccount => 'ليس لديك حساب؟ ';

  @override
  String get loginSignUp => 'إنشاء حساب';

  @override
  String get loginEnterEmailAndPassword =>
      'يرجى إدخال البريد الإلكتروني وكلمة المرور';

  @override
  String get loginUnableToSignIn =>
      'تعذر تسجيل الدخول. يرجى المحاولة مرة أخرى.';

  @override
  String get loginInvalidEmail => 'عنوان البريد الإلكتروني غير صالح';

  @override
  String get loginIncorrectEmailOrPassword =>
      'البريد الإلكتروني أو كلمة المرور غير صحيحة';

  @override
  String get loginAccountDisabled => 'تم تعطيل هذا الحساب';

  @override
  String get loginTooManyAttempts =>
      'عدد المحاولات كبير جدًا. يرجى المحاولة لاحقًا.';

  @override
  String get loginCheckInternetConnection => 'يرجى التحقق من اتصالك بالإنترنت';

  @override
  String get loginFailedTryAgain => 'فشل تسجيل الدخول. يرجى المحاولة مرة أخرى.';

  @override
  String get loginEmailNotVerified => 'البريد الإلكتروني غير مؤكد';

  @override
  String loginEmailNotVerifiedMessage(String email) {
    return 'لم يتم تأكيد عنوان بريدك الإلكتروني $email. هل تريد إرسال رسالة تأكيد أخرى؟';
  }

  @override
  String get loginResendEmail => 'إعادة إرسال الرسالة';

  @override
  String get loginVerificationEmailSent => 'تم إرسال رسالة التأكيد بنجاح';

  @override
  String get loginEmailAlreadyVerified => 'تم تأكيد بريدك الإلكتروني بالفعل';

  @override
  String get loginWaitBeforeRequestingEmail =>
      'يرجى الانتظار قبل طلب رسالة أخرى';

  @override
  String get loginCouldNotSendVerificationEmail => 'تعذر إرسال رسالة التأكيد';

  @override
  String get loginGoogleFailed =>
      'فشل تسجيل الدخول باستخدام Google. يرجى المحاولة مرة أخرى.';

  @override
  String get loginEnterEmailFirst => 'يرجى إدخال بريدك الإلكتروني أولاً';

  @override
  String get loginPasswordResetEmailSent =>
      'تم إرسال رسالة إعادة تعيين كلمة المرور بنجاح';

  @override
  String get loginCouldNotSendPasswordResetEmail =>
      'تعذر إرسال رسالة إعادة تعيين كلمة المرور';

  @override
  String get signup => 'إنشاء حساب';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get homeAddress => 'المنزل';

  @override
  String get defaultAddress => 'افتراضي';

  @override
  String get setAsDefaultAddress => 'تعيين كعنوان افتراضي';

  @override
  String get addAddress => 'إضافة عنوان';

  @override
  String get deleteAddressTitle => 'حذف العنوان';

  @override
  String get deleteAddressConfirmation =>
      'هل أنت متأكد أنك تريد حذف هذا العنوان؟';

  @override
  String get noAddressesYet => 'لا توجد عناوين حتى الآن';

  @override
  String get addAddressDescription => 'أضف عنوان توصيل لتسهيل إتمام طلباتك.';

  @override
  String get editAddress => 'تعديل العنوان';

  @override
  String get streetAddress => 'عنوان الشارع';

  @override
  String get city => 'المدينة';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get addressFieldRequired => 'هذا الحقل مطلوب';

  @override
  String get addNewAddress => 'إضافة عنوان جديد';

  @override
  String get addressName => 'اسم العنوان';

  @override
  String get addressNameHint => 'مثال: المنزل، العمل';

  @override
  String get onboardingTitle => 'اعثر على كل ما تحب';

  @override
  String get onboardingDescription =>
      'اكتشف منتجات رائعة واستمتع بتجربة تسوق سهلة.';

  @override
  String get getStarted => 'ابدأ الآن';

  @override
  String get chooseNotifications => 'اختر الإشعارات التي تريد استقبالها';

  @override
  String get general => 'عام';

  @override
  String get orderUpdates => 'تحديثات الطلبات';

  @override
  String get orderUpdatesDescription => 'استقبل تحديثات حول طلباتك';

  @override
  String get promotionsOffers => 'العروض والتخفيضات';

  @override
  String get promotionsDescription =>
      'احصل على إشعارات بالخصومات والعروض الخاصة';

  @override
  String get recommendations => 'الاقتراحات';

  @override
  String get recommendationsDescription => 'اكتشف المنتجات المختارة لك';

  @override
  String get notificationChannels => 'قنوات الإشعارات';

  @override
  String get pushNotifications => 'إشعارات التطبيق';

  @override
  String get pushNotificationsDescription => 'استقبل الإشعارات على جهازك';

  @override
  String get emailNotifications => 'إشعارات البريد الإلكتروني';

  @override
  String get emailNotificationsDescription =>
      'استقبل الإشعارات عبر البريد الإلكتروني';

  @override
  String get notificationSettingsInfo => 'يمكنك تغيير هذه التفضيلات في أي وقت.';

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get processing => 'قيد التجهيز';

  @override
  String get shipped => 'تم الشحن';

  @override
  String get delivered => 'تم التوصيل';

  @override
  String get cancelled => 'تم الإلغاء';

  @override
  String get completed => 'مكتمل';

  @override
  String get cancelOrder => 'إلغاء الطلب';

  @override
  String get cancelOrderConfirmation =>
      'هل أنت متأكد أنك تريد إلغاء هذا الطلب؟';

  @override
  String get no => 'لا';

  @override
  String get yesCancel => 'نعم، إلغاء';

  @override
  String get orderCancelledSuccessfully => 'تم إلغاء الطلب بنجاح';

  @override
  String get failedToCancelOrder => 'فشل إلغاء الطلب';

  @override
  String get deleteOrder => 'حذف الطلب';

  @override
  String get deleteOrderConfirmation => 'هل أنت متأكد أنك تريد حذف هذا الطلب؟';

  @override
  String get yesDelete => 'نعم، احذف';

  @override
  String get orderDeletedSuccessfully => 'تم حذف الطلب بنجاح';

  @override
  String get failedToDeleteOrder => 'فشل حذف الطلب';

  @override
  String get dateUnavailable => 'التاريخ غير متاح';

  @override
  String get orderDetails => 'تفاصيل الطلب';

  @override
  String get orderId => 'رقم الطلب';

  @override
  String get date => 'التاريخ';

  @override
  String get editPaymentMethod => 'تعديل طريقة الدفع';

  @override
  String get addPaymentMethod => 'إضافة طريقة دفع';

  @override
  String get cardholderName => 'اسم حامل البطاقة';

  @override
  String get enterCardholderName => 'أدخل اسم حامل البطاقة';

  @override
  String get lastFourDigits => 'آخر أربعة أرقام';

  @override
  String get enterExactlyFourDigits => 'أدخل 4 أرقام بالضبط';

  @override
  String get expiryDate => 'تاريخ الانتهاء';

  @override
  String get useMmYyFormat => 'استخدم تنسيق MM/YY';

  @override
  String get setAsDefault => 'تعيين كافتراضي';

  @override
  String get addCard => 'إضافة بطاقة';

  @override
  String get deleteCard => 'حذف البطاقة';

  @override
  String get deletePaymentConfirmation =>
      'هل أنت متأكد أنك تريد حذف طريقة الدفع هذه؟';

  @override
  String get noPaymentMethods => 'لا توجد طرق دفع';

  @override
  String get addPaymentDescription => 'أضف طريقة دفع لتسهيل إتمام طلباتك.';

  @override
  String get edit => 'تعديل';

  @override
  String get productDetails => 'تفاصيل المنتج';

  @override
  String get reviews => 'التقييمات';

  @override
  String productAddedToCart(String product) {
    return 'تمت إضافة $product إلى السلة';
  }

  @override
  String get addToCart => 'أضف إلى السلة';

  @override
  String get searchProducts => 'البحث عن المنتجات';

  @override
  String get searchForProducts => 'ابحث عن المنتجات';

  @override
  String get findFavoriteProducts => 'اعثر على منتجاتك المفضلة';

  @override
  String get searchByProductName => 'ابحث باستخدام اسم المنتج';

  @override
  String get searchResults => 'نتائج البحث';

  @override
  String get items => 'منتجات';

  @override
  String get failedToLoadSearchResults => 'فشل تحميل نتائج البحث';

  @override
  String get trySearchingAnotherName => 'حاول البحث باستخدام اسم آخر';

  @override
  String get shopper => 'متسوق';

  @override
  String helloShopper(String name) {
    return 'مرحبًا، $name';
  }

  @override
  String get findYourStyle => 'اكتشف أسلوبك';

  @override
  String get searchProductsHint => 'ابحث عن المنتجات...';

  @override
  String get newCollection => 'مجموعة جديدة';

  @override
  String get discoverYourStyle => 'اكتشف أسلوبك الخاص';

  @override
  String get exploreLatestFashion => 'اكتشف أحدث صيحات الموضة';

  @override
  String get shopNow => 'تسوق الآن';

  @override
  String get categories => 'التصنيفات';

  @override
  String get all => 'الكل';

  @override
  String get featuredProducts => 'المنتجات المميزة';

  @override
  String itemCount(int count) {
    return '$count منتجات';
  }

  @override
  String get pleaseFillAllFields => 'يرجى ملء جميع الحقول';

  @override
  String get enterValidEmail => 'يرجى إدخال بريد إلكتروني صحيح';

  @override
  String get verifyYourEmail => 'تأكيد البريد الإلكتروني';

  @override
  String verificationEmailInstructions(String email) {
    return 'لقد أرسلنا رسالة تأكيد إلى $email. يرجى التحقق من صندوق الوارد.';
  }

  @override
  String get gotIt => 'حسنًا';

  @override
  String get joinShoppingApp => 'انضم إلى تطبيق التسوق';

  @override
  String get createAccountDescription =>
      'أنشئ حسابًا لبدء تجربة التسوق الخاصة بك';

  @override
  String get password => 'كلمة المرور';

  @override
  String get createPassword => 'أنشئ كلمة مرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get confirmYourPassword => 'أعد إدخال كلمة المرور';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get home => 'الرئيسية';

  @override
  String get favorites => 'المفضلة';

  @override
  String get cart => 'السلة';

  @override
  String get profile => 'حسابي';

  @override
  String get addedToFavorites => 'تمت الإضافة إلى المفضلة';

  @override
  String get removedFromFavorites => 'تمت الإزالة من المفضلة';

  @override
  String get addToFavorites => 'إضافة إلى المفضلة';

  @override
  String get removeFromFavorites => 'إزالة من المفضلة';

  @override
  String get filter => 'تصفية';

  @override
  String get categoryClothing => 'الملابس';

  @override
  String get categoryClothingSubtitle => 'تسوق ملابس الرجال والنساء والأطفال';

  @override
  String get categoryAccessories => 'الإكسسوارات';

  @override
  String get categoryAccessoriesSubtitle => 'أكمل إطلالتك بأجمل الإكسسوارات';

  @override
  String get categoryMen => 'رجالي';

  @override
  String get categoryWomen => 'حريمي';

  @override
  String get categoryKids => 'أطفال';

  @override
  String get categorySunglasses => 'نظارات شمسية';

  @override
  String get categoryBelts => 'أحزمة';

  @override
  String get categoryWallets => 'محافظ';
}
