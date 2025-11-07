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

  /// No description provided for @enterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Email'**
  String get enterYourEmail;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password'**
  String get forgetPassword;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailHint;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtp;

  /// No description provided for @otpSent.
  ///
  /// In en, this message translates to:
  /// **'OTP sent to your email'**
  String get otpSent;

  /// No description provided for @emailValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailValidation;

  /// No description provided for @otpCode.
  ///
  /// In en, this message translates to:
  /// **'OTP Code'**
  String get otpCode;

  /// No description provided for @enterOtpMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter Your OTP Check Your Email'**
  String get enterOtpMessage;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @didntReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive verification code?'**
  String get didntReceiveCode;

  /// No description provided for @resendCode.
  ///
  /// In en, this message translates to:
  /// **'Resend Code?'**
  String get resendCode;

  /// No description provided for @passwordRequirement.
  ///
  /// In en, this message translates to:
  /// **'Make sure it’s 8 characters or more'**
  String get passwordRequirement;

  /// No description provided for @createNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get createNewPassword;

  /// No description provided for @oldPassword.
  ///
  /// In en, this message translates to:
  /// **'Old Password'**
  String get oldPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @newPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPasswordHint;

  /// No description provided for @confirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordHint;

  /// No description provided for @passwordRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passwordRequiredError;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @passwordInvalidError.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 8 characters, including letters, numbers, and a special symbol'**
  String get passwordInvalidError;

  /// No description provided for @passwordMismatchError.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordMismatchError;

  /// No description provided for @codeLengthError.
  ///
  /// In en, this message translates to:
  /// **'should be more that 6'**
  String get codeLengthError;

  /// No description provided for @codeResent.
  ///
  /// In en, this message translates to:
  /// **'Verification code has been resent'**
  String get codeResent;

  /// No description provided for @passwordResetSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password has been reset successfully'**
  String get passwordResetSuccess;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @codeReceiveMsgError.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive code?'**
  String get codeReceiveMsgError;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success!'**
  String get success;

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

  /// No description provided for @greeting.
  ///
  /// In en, this message translates to:
  /// **'Hey There'**
  String get greeting;

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
  /// **'Password'**
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
  /// **'Don\'t have an account yet?'**
  String get dontHaveAnAccount;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get signUp;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'WELCOME BACK'**
  String get welcomeBack;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordInvalid.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters, include letters, numbers, and special characters.'**
  String get passwordInvalid;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Confirmation is required'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get emailInvalid;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @upcomingWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Workouts'**
  String get upcomingWorkouts;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See all'**
  String get seeAll;

  /// No description provided for @failedToLoadWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Failed to load workouts'**
  String get failedToLoadWorkouts;

  /// No description provided for @noWorkoutsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No workouts available'**
  String get noWorkoutsAvailable;

  /// No description provided for @recommendationForYou.
  ///
  /// In en, this message translates to:
  /// **'Recommendation for you'**
  String get recommendationForYou;

  /// No description provided for @hiOmar.
  ///
  /// In en, this message translates to:
  /// **'Hi Omar'**
  String get hiOmar;

  /// No description provided for @letUsStartYourDay.
  ///
  /// In en, this message translates to:
  /// **'Let\\\'s start your day'**
  String get letUsStartYourDay;

  /// No description provided for @workouts.
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get workouts;

  /// No description provided for @noMuscleCategoriesAvailable.
  ///
  /// In en, this message translates to:
  /// **'No muscle categories available'**
  String get noMuscleCategoriesAvailable;

  /// No description provided for @ingredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredients;

  /// No description provided for @recommendation.
  ///
  /// In en, this message translates to:
  /// **'Recommendation'**
  String get recommendation;

  /// No description provided for @video_opened_successfully.
  ///
  /// In en, this message translates to:
  /// **'Video opened successfully'**
  String get video_opened_successfully;

  /// No description provided for @could_not_open_video_link.
  ///
  /// In en, this message translates to:
  /// **'Could not open the video link'**
  String get could_not_open_video_link;

  /// No description provided for @video_link_not_available.
  ///
  /// In en, this message translates to:
  /// **'Video link not available'**
  String get video_link_not_available;

  /// No description provided for @errorWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorWithMessage(Object message);

  /// No description provided for @unnamedWorkout.
  ///
  /// In en, this message translates to:
  /// **'Unnamed Workout'**
  String get unnamedWorkout;

  /// No description provided for @hiUser.
  ///
  /// In en, this message translates to:
  /// **'Hi {userName},'**
  String hiUser(Object userName);

  /// No description provided for @startYourDay.
  ///
  /// In en, this message translates to:
  /// **'Let\'s start your day'**
  String get startYourDay;

  /// No description provided for @gym.
  ///
  /// In en, this message translates to:
  /// **'Gym'**
  String get gym;

  /// No description provided for @fitness.
  ///
  /// In en, this message translates to:
  /// **'Fitness'**
  String get fitness;

  /// No description provided for @yoga.
  ///
  /// In en, this message translates to:
  /// **'Yoga'**
  String get yoga;

  /// No description provided for @aerobics.
  ///
  /// In en, this message translates to:
  /// **'Aerobics'**
  String get aerobics;

  /// No description provided for @trainer.
  ///
  /// In en, this message translates to:
  /// **'Trainer'**
  String get trainer;

  /// No description provided for @noRecommendationsFound.
  ///
  /// In en, this message translates to:
  /// **'No recommendations found'**
  String get noRecommendationsFound;

  /// No description provided for @failedToLoadRecommendations.
  ///
  /// In en, this message translates to:
  /// **'Failed to load recommendations'**
  String get failedToLoadRecommendations;

  /// No description provided for @popularTraining.
  ///
  /// In en, this message translates to:
  /// **'Popular Training'**
  String get popularTraining;

  /// No description provided for @exerciseStrengthenChest.
  ///
  /// In en, this message translates to:
  /// **'Exercises That Strengthen Your Chest'**
  String get exerciseStrengthenChest;

  /// No description provided for @tasksCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Tasks'**
  String tasksCount(Object count);

  /// No description provided for @difficultyBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get difficultyBeginner;

  /// No description provided for @error_prefix.
  ///
  /// In en, this message translates to:
  /// **'Error: '**
  String get error_prefix;

  /// No description provided for @na.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get na;

  /// No description provided for @salmon_bowl.
  ///
  /// In en, this message translates to:
  /// **'Salmon Bowl'**
  String get salmon_bowl;

  /// No description provided for @tuna_pasta.
  ///
  /// In en, this message translates to:
  /// **'Tuna Pasta'**
  String get tuna_pasta;

  /// No description provided for @grilled_chicken.
  ///
  /// In en, this message translates to:
  /// **'Grilled Chicken'**
  String get grilled_chicken;

  /// No description provided for @avocado_salad.
  ///
  /// In en, this message translates to:
  /// **'Avocado Salad'**
  String get avocado_salad;

  /// No description provided for @beef_steak.
  ///
  /// In en, this message translates to:
  /// **'Beef Steak'**
  String get beef_steak;

  /// No description provided for @veggie_wrap.
  ///
  /// In en, this message translates to:
  /// **'Veggie Wrap'**
  String get veggie_wrap;

  /// No description provided for @loading_failed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load meal details'**
  String get loading_failed;

  /// No description provided for @food_recommendation.
  ///
  /// In en, this message translates to:
  /// **'Food Recommendation'**
  String get food_recommendation;

  /// No description provided for @no_foods_available.
  ///
  /// In en, this message translates to:
  /// **'No foods available in this category.'**
  String get no_foods_available;

  /// No description provided for @unnamed_food.
  ///
  /// In en, this message translates to:
  /// **'Unnamed Food'**
  String get unnamed_food;

  /// No description provided for @exercise_title.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get exercise_title;

  /// No description provided for @exercise_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Explore exercises tailored to your difficulty level.'**
  String get exercise_subtitle;

  /// No description provided for @exercise_duration.
  ///
  /// In en, this message translates to:
  /// **'30 MIN'**
  String get exercise_duration;

  /// No description provided for @exercise_calories.
  ///
  /// In en, this message translates to:
  /// **'130 Cal'**
  String get exercise_calories;

  /// No description provided for @no_exercises_found.
  ///
  /// In en, this message translates to:
  /// **'No exercises found'**
  String get no_exercises_found;

  /// No description provided for @no_description.
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get no_description;

  /// No description provided for @exercise_reps_info.
  ///
  /// In en, this message translates to:
  /// **'3 Groups * 15 Times'**
  String get exercise_reps_info;

  /// No description provided for @recipe_video.
  ///
  /// In en, this message translates to:
  /// **'Recipe Video'**
  String get recipe_video;

  /// No description provided for @exercise_video.
  ///
  /// In en, this message translates to:
  /// **'Exercise Video'**
  String get exercise_video;

  /// No description provided for @recommendation_to_you.
  ///
  /// In en, this message translates to:
  /// **'Recommendation to Day'**
  String get recommendation_to_you;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

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

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @chat.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chat;

  /// No description provided for @explore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get explore;

  /// No description provided for @changed_password_success.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully. Please login again.'**
  String get changed_password_success;

  /// No description provided for @yourWeight.
  ///
  /// In en, this message translates to:
  /// **'Your weight'**
  String get yourWeight;

  /// No description provided for @tapToEdit.
  ///
  /// In en, this message translates to:
  /// **'(tap to edit)'**
  String get tapToEdit;

  /// No description provided for @kilo.
  ///
  /// In en, this message translates to:
  /// **'kilo'**
  String get kilo;

  /// No description provided for @yourGoal.
  ///
  /// In en, this message translates to:
  /// **'Your goal'**
  String get yourGoal;

  /// No description provided for @gainWeight.
  ///
  /// In en, this message translates to:
  /// **'Gain weight'**
  String get gainWeight;

  /// No description provided for @yourActivityLevel.
  ///
  /// In en, this message translates to:
  /// **'Your activity level'**
  String get yourActivityLevel;

  /// No description provided for @rookie.
  ///
  /// In en, this message translates to:
  /// **'Rookie'**
  String get rookie;

  /// No description provided for @uploadPhotoSuccess.
  ///
  /// In en, this message translates to:
  /// **'Photo Uploaded Successfully'**
  String get uploadPhotoSuccess;

  /// No description provided for @profileUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully'**
  String get profileUpdatedSuccess;

  /// No description provided for @logoutConfirmTextCenter.
  ///
  /// In en, this message translates to:
  /// **'Confirm logout!'**
  String get logoutConfirmTextCenter;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @logoutAlertMsg.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutAlertMsg;
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
