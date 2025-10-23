// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello';

  @override
  String get welcome => 'Welcome to Super Fitness!';

  @override
  String get enterYourEmail => 'Enter Your Email';

  @override
  String get forgetPassword => 'Forget Password';

  @override
  String get emailHint => 'Email';

  @override
  String get sendOtp => 'Send OTP';

  @override
  String get otpSent => 'OTP sent to your email';

  @override
  String get emailValidation => 'Please enter your email';

  @override
  String get otpCode => 'OTP Code';

  @override
  String get enterOtpMessage => 'Enter Your OTP Check Your Email';

  @override
  String get confirm => 'Confirm';

  @override
  String get didntReceiveCode => 'Didn\'t receive verification code?';

  @override
  String get resendCode => 'Resend Code?';

  @override
  String get passwordRequirement => 'Make sure it’s 8 characters or more';

  @override
  String get createNewPassword => 'Create New Password';

  @override
  String get newPasswordHint => 'New Password';

  @override
  String get confirmPasswordHint => 'Confirm Password';

  @override
  String get passwordRequiredError => 'Please enter your password';

  @override
  String get done => 'Done';

  @override
  String get passwordInvalidError => 'Password must contain at least 8 characters, including letters, numbers, and a special symbol';

  @override
  String get passwordMismatchError => 'Passwords do not match';

  @override
  String get codeLengthError => 'should be more that 6';

  @override
  String get codeResent => 'Verification code has been resent';

  @override
  String get passwordResetSuccess => 'Password has been reset successfully';

  @override
  String get error => 'Error';

  @override
  String get codeReceiveMsgError => 'Didn\'t receive code?';

  @override
  String get success => 'Success!';
}
