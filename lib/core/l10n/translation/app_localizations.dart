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
/// import 'translation/app_localizations.dart';
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

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Super Fitness!'**
  String get welcome;

  /// No description provided for @step_title_gender.
  ///
  /// In en, this message translates to:
  /// **'TELL US ABOUT YOURSELF!'**
  String get step_title_gender;

  /// No description provided for @step_title_age.
  ///
  /// In en, this message translates to:
  /// **'HOW OLD ARE YOU?'**
  String get step_title_age;

  /// No description provided for @step_title_weight.
  ///
  /// In en, this message translates to:
  /// **'WHAT IS YOUR WEIGHT?'**
  String get step_title_weight;

  /// No description provided for @step_title_height.
  ///
  /// In en, this message translates to:
  /// **'WHAT IS YOUR HEIGHT?'**
  String get step_title_height;

  /// No description provided for @step_title_goal.
  ///
  /// In en, this message translates to:
  /// **'WHAT IS YOUR GOAL?'**
  String get step_title_goal;

  /// No description provided for @step_title_activity.
  ///
  /// In en, this message translates to:
  /// **'Your Regular Physical Activity Level?'**
  String get step_title_activity;

  /// No description provided for @step_subtitle_gender.
  ///
  /// In en, this message translates to:
  /// **'We Need To Know Your Gender'**
  String get step_subtitle_gender;

  /// No description provided for @step_subtitle_age.
  ///
  /// In en, this message translates to:
  /// **'This Helps Us Create Your Personalized Plan'**
  String get step_subtitle_age;

  /// No description provided for @step_subtitle_weight.
  ///
  /// In en, this message translates to:
  /// **'This Helps Us Create Your Personalized Plan'**
  String get step_subtitle_weight;

  /// No description provided for @step_subtitle_height.
  ///
  /// In en, this message translates to:
  /// **'Select your height in cm'**
  String get step_subtitle_height;

  /// No description provided for @step_subtitle_goal.
  ///
  /// In en, this message translates to:
  /// **'This Helps Us Create Your Personalized Workout Plan'**
  String get step_subtitle_goal;

  /// No description provided for @goal_gain_weight.
  ///
  /// In en, this message translates to:
  /// **'Gain Weight'**
  String get goal_gain_weight;

  /// No description provided for @goal_lose_weight.
  ///
  /// In en, this message translates to:
  /// **'Lose Weight'**
  String get goal_lose_weight;

  /// No description provided for @goal_get_fitter.
  ///
  /// In en, this message translates to:
  /// **'Get Fitter'**
  String get goal_get_fitter;

  /// No description provided for @goal_gain_flexible.
  ///
  /// In en, this message translates to:
  /// **'Gain More Flexible'**
  String get goal_gain_flexible;

  /// No description provided for @goal_learn_basic.
  ///
  /// In en, this message translates to:
  /// **'Learn The Basic'**
  String get goal_learn_basic;

  /// No description provided for @activity_rookie.
  ///
  /// In en, this message translates to:
  /// **'Rookie'**
  String get activity_rookie;

  /// No description provided for @activity_beginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get activity_beginner;

  /// No description provided for @activity_intermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get activity_intermediate;

  /// No description provided for @activity_advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get activity_advanced;

  /// No description provided for @activity_expert.
  ///
  /// In en, this message translates to:
  /// **'Expert'**
  String get activity_expert;

  /// No description provided for @activity_true_beast.
  ///
  /// In en, this message translates to:
  /// **'True Beast'**
  String get activity_true_beast;

  /// No description provided for @gender_male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get gender_male;

  /// No description provided for @gender_female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get gender_female;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'years'**
  String get years;

  /// No description provided for @kg.
  ///
  /// In en, this message translates to:
  /// **'Kg'**
  String get kg;

  /// No description provided for @kg_unit.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get kg_unit;

  /// No description provided for @cm.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get cm;

  /// No description provided for @completed_success.
  ///
  /// In en, this message translates to:
  /// **'Registration completed successfully'**
  String get completed_success;

  /// No description provided for @hey_there.
  ///
  /// In en, this message translates to:
  /// **'Hey There'**
  String get hey_there;

  /// No description provided for @create_account.
  ///
  /// In en, this message translates to:
  /// **'CREATE AN ACCOUNT'**
  String get create_account;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get title;

  /// No description provided for @hint_first_name.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get hint_first_name;

  /// No description provided for @error_first_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter your first name'**
  String get error_first_name;

  /// No description provided for @hint_last_name.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get hint_last_name;

  /// No description provided for @error_last_name.
  ///
  /// In en, this message translates to:
  /// **'Please enter your last name'**
  String get error_last_name;

  /// No description provided for @hint_email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get hint_email;

  /// No description provided for @error_email.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get error_email;

  /// No description provided for @error_email_invalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get error_email_invalid;

  /// No description provided for @hint_password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get hint_password;

  /// No description provided for @error_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get error_password;

  /// No description provided for @error_password_short.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get error_password_short;

  /// No description provided for @error_password_invalid.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter and one special character'**
  String get error_password_invalid;

  /// No description provided for @hint_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get hint_confirm_password;

  /// No description provided for @error_confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get error_confirm_password;

  /// No description provided for @error_passwords_not_match.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get error_passwords_not_match;

  /// No description provided for @btn_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get btn_continue;

  /// No description provided for @already_have_account.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get already_have_account;

  /// No description provided for @btn_login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get btn_login;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailHintText.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHintText;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHintText.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHintText;

  /// No description provided for @emailIsEmptyErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailIsEmptyErrorMessage;

  /// No description provided for @emailValidationErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'This email is not valid'**
  String get emailValidationErrorMsg;

  /// No description provided for @passwordRequiredErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequiredErrorMsg;

  /// No description provided for @passwordValidationErrorMsg.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters and include M#12m'**
  String get passwordValidationErrorMsg;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgetPasswordTextButton.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgetPasswordTextButton;

  /// No description provided for @continueAsGuestButton.
  ///
  /// In en, this message translates to:
  /// **'Continue as guest'**
  String get continueAsGuestButton;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAnAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign up'**
  String get signUp;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'WELCOME BACK'**
  String get welcomeBack;
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
