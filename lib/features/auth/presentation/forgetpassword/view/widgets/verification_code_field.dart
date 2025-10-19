import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import '../../../../../../../core/theme/app_colors.dart';

class VerificationCodeField extends StatefulWidget {
  const VerificationCodeField({super.key});

  @override
  State<VerificationCodeField> createState() => _VerificationCodeFieldState();
}

class _VerificationCodeFieldState extends State<VerificationCodeField> {
  String otpCode = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OtpTextField(
          numberOfFields: 4,
          fieldWidth: 57,
          fieldHeight: 60,
          borderRadius: BorderRadius.circular(8),
          borderColor: Colors.white.withOpacity(0.6),
          focusedBorderColor: AppColors.main,
          showFieldAsBox: true,
          filled: true,
          fillColor: Colors.white.withOpacity(0.06),
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          onCodeChanged: (code) => setState(() => otpCode = code),
          onSubmit: (code) => setState(() => otpCode = code),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
