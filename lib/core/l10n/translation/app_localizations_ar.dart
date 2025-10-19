// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get hello => 'مرحبا';

  @override
  String get welcome => 'مرحبًا بك في سوبر فيتنس!';

  @override
  String get enterYourEmail => 'أدخل بريدك الإلكتروني';

  @override
  String get forgetPassword => 'نسيت كلمة المرور';

  @override
  String get emailHint => 'البريد الإلكتروني';

  @override
  String get sendOtp => 'إرسال رمز التحقق';

  @override
  String get emailValidation => 'يرجى إدخال بريدك الإلكتروني';

  @override
  String get otpCode => 'رمز التحقق';

  @override
  String get enterOtpMessage => 'أدخل رمز التحقق، تحقق من بريدك الإلكتروني';

  @override
  String get confirm => 'تأكيد';

  @override
  String get didntReceiveCode => 'لم تستلم رمز التحقق؟';

  @override
  String get resendCode => 'إعادة إرسال الرمز؟';

  @override
  String get passwordRequirement => 'تأكد من أن كلمة المرور تحتوي على 8 أحرف أو أكثر';

  @override
  String get createNewPassword => 'إنشاء كلمة مرور جديدة';

  @override
  String get newPasswordHint => 'كلمة المرور الجديدة';

  @override
  String get confirmPasswordHint => 'تأكيد كلمة المرور';

  @override
  String get passwordRequiredError => 'يرجى إدخال كلمة المرور';

  @override
  String get done => 'تم';

  @override
  String get passwordInvalidError => 'يجب أن تحتوي كلمة المرور على 8 أحرف على الأقل، بما في ذلك أحرف وأرقام ورمز خاص';

  @override
  String get passwordMismatchError => 'كلمتا المرور غير متطابقتين';
}
