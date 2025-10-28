import 'package:get/get.dart';

class Dimensions {
  static double fontSizeExtraSmall = 14;
  static double fontSizeSmall = 14;
  static double fontSizeDefault = 14;
  static double fontSizeLarge = 16;
  static double fontSizeExtraLarge = 18;
  static double fontSizeOverLarge = 24;

  static double paddingSmall = 8;
  static double paddingDefault = 16;
  static double paddingLarge = 24;

  static void init() {
    final context = Get.context;
    if (context != null) {
      paddingSmall = context.width >= 1300 ? 16 : 8;
      paddingDefault = context.width >= 1300 ? 16 : 16;
      paddingLarge = context.width >= 1300 ? 24 : 24;
      fontSizeExtraSmall = context.width >= 1300 ? 16 : 14;
      fontSizeSmall = context.width >= 1300 ? 16 : 14;
      fontSizeDefault = context.width >= 1300 ? 16 : 14;
      fontSizeLarge = context.width >= 1300 ? 18 : 16;
      fontSizeExtraLarge = context.width >= 1300 ? 20 : 18;
      fontSizeOverLarge = context.width >= 1300 ? 26 : 24;
    }
  }
}
