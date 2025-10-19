  import 'package:flutter/material.dart';

  abstract class AppColors {
    static const Color red = Color(0xFFCC1010);
    static const Color green = Color(0xFF0CB359);
    //Orange to light Orange
    static const MaterialColor main = MaterialColor(0xFFFF4100, <int, Color>{
      0: Color(0xFFFF4100),
      10: Color(0xFFFF541A),
      20: Color(0xFFFF6733),
      30: Color(0xFFFF7A4D),
      40: Color(0xFFFF8D66),
      50: Color(0xFFFFA080),
      60: Color(0xFFFFB399),
      70: Color(0xFFFFC6B2),
      80: Color(0xFFFFD9CC),
      90: Color(0xFFFFECE5),
    });
    //Orange to Dark Orange
    static const MaterialColor orange = MaterialColor(0xFFFF4100, <int, Color>{
      0: Color(0xFFFF4100),
      10: Color(0xFFE52800),
      20: Color(0xFFCC0E00),
      30: Color(0xFFB20000),
      40: Color(0xFF990000),
      50: Color(0xFF800000),
      60: Color(0xFF660000),
      70: Color(0xFF4D0000),
      80: Color(0xFF330000),
      90: Color(0xFF1A0000),
    });
    static const MaterialColor grey = MaterialColor(0xFF242424, <int, Color>{
      0: Color(0xFF242424),
      10: Color(0xFF3A3A3A),
      20: Color(0xFF505050),
      30: Color(0xFF666666),
      40: Color(0xFF7C7C7C),
      50: Color(0xFF919191),
      60: Color(0xFFA7A7A7),
      70: Color(0xFFBDBDBD),
      80: Color(0xFFD3D3D3),
      90: Color(0xFFE9E9E9),
    });
    static const MaterialColor white = MaterialColor(0xFFF9F9F9, <int, Color>{
      10: Color(0xFFFEFEFE),
      20: Color(0xFFFDFDFD),
      30: Color(0xFFFCFCFC),
      40: Color(0xFFFBFBFB),
      50: Color(0xFFFAFAFA),
      0: Color(0xFFF9F9F9), // BASE
      60: Color(0xFFD0D0D0),
      70: Color(0xFFA6A6A6),
      80: Color(0xFF7D7D7D),
      90: Color(0xFF535353),
      100: Color(0xFF323232),
    });
    static const MaterialColor black = MaterialColor(0xFF0C1015, <int, Color>{
      10: Color(0xFFCECFD0),
      20: Color(0xFFAEAFB1),
      30: Color(0xFF86888A),
      40: Color(0xFF5D6063),
      50: Color(0xFF34383C),
      0: Color(0xFF0C1015), // BASE
      60: Color(0xFF0A0D12),
      70: Color(0xFF080B0E),
      80: Color(0xFF06080B),
      90: Color(0xFF040507),
      100: Color(0xFF020304),
    });
  }
