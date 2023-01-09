import 'package:flutter/material.dart';
import 'package:tutorial_app/main.dart';

class LanguageProvider with ChangeNotifier {
  bool isEnglish = true;

  Map<String, String> textsEnglish = {
    // Page Get Started
    'started_account_type': 'Account type',
    'text_expert': 'Expert',
    'text_user': 'User',
    'language_text': 'Please choose your language ....',
    'arabic_text': "Arabic",
    'english_text': "English",
    "start": "GET STARTED",
    // Page SignUpUser
    "title_signup_user": "Create Account As User",
    "full_name_signup": 'Full Name',
    "email_signup": 'Email',
    'password_signup': 'Password',
    "confirm_password_singup": "Confirm-Password",
    "signup": "Sign-Up",
    "if_haveaccount": "if you have an account",
    "signin": "Sign-In",
    "phone_number": 'Phone Number',
    "title_signup_expert": 'Create Account As Expert',
    //page login user
    "welcome_back": 'Welcome Back',
    "subtitle": 'We happy to see you again ,Thank you for choosing us.',
    "forgot_pass": "Forgot Password?",
    "noaccont": 'Don\'t have an account',

    //Page login expert
    "title_login_expert": "Go confidently in the direction of your dreams."
  };
  Map<String, String> textsArabic = {
    // Page Get Started
    'started_account_type': 'نوع الحساب',
    'text_expert': 'خبير',
    'text_user': 'مستخدم',
    'language_text': ' .... الرجاء اختيار لغتك ',
    'arabic_text': "العربية",
    'english_text': "الإنجليزية",
    "start": "أبدأ الان",

    // Page SignUpUser
    "title_signup_user": "إنشاء حساب كمستخدم",
    'full_name_signup': 'الاسم الكامل',
    "email_signup": 'البريد إلكتروني',
    'password_signup': 'كلمة المرور',
    "confirm_password_singup": "تأكيد كلمة المرور",
    "signup": "التسجيل",
    "if_haveaccount": "إذا كان لديك حساب",
    "signin": "تسجيل الدخول",
    "phone_number": 'رقم الهاتف',
    "title_signup_expert": 'إنشاء حساب كخبير',
    //Page login user
    "welcome_back": 'مرحبًا بعودتك',
    "subtitle": 'يسعدنا رؤيتك مرة أخرى ، شكرًا لاختيارك لنا.',
    "forgot_pass": "هل نسيت كلمة السر؟",
    "noaccont": 'ليس لديك حساب',
    //Page login expert
    "title_login_expert": "توجه بثقة بإتجاه أحلامك"
  };

  changeLanguage(bool language) {
    isEnglish = language;
    notifyListeners();
  }

  String getText(String txt) {
    logger.d(txt);
    if (isEnglish) {
      return textsEnglish[txt]!;
    } else {
      return textsArabic[txt]!;
    }
  }
}
