import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final VoidCallback? onPressed;
  final String? label;
  final String? hint;
  final String? suffixText;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool enabled;
  final bool readonly;
  final bool showUploadIcon;
  final String? initialText;
  final Widget? prefixIcon;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.validator,
    this.onChanged,
    this.onPressed,
    this.label,
    this.hint,
    this.suffixText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.readonly = false,
    this.initialText,
    this.showUploadIcon = false,
    this.prefixIcon,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool isTextObscured;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    isTextObscured = widget.obscureText;
    _controller =
        widget.controller ?? TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      enabled: widget.enabled,
      readOnly: widget.readonly,
      onTap: widget.readonly ? (widget.onPressed) : null,
      enableInteractiveSelection: widget.readonly ? false : true,
      contextMenuBuilder:
          widget.readonly
              ? (context, editableTextState) {
                return const SizedBox.shrink();
              }
              : null,
      obscureText: isTextObscured,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onChanged: widget.onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(
        color: AppColors.white,
        fontWeight: FontWeight.w400,
        fontSize: 15,
      ),
      cursorColor: AppColors.main,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.white, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.white, width: 1.5),
        ),
        hintText: widget.hint,
        hintStyle: TextStyle(color: AppColors.white.withValues(alpha: 0.5)),
        prefixIcon: widget.prefixIcon,
        suffixIcon:
            widget.obscureText
                ? IconButton(
                  icon: Icon(
                    isTextObscured ? Icons.visibility_off : Icons.visibility,
                    color: AppColors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isTextObscured = !isTextObscured;
                    });
                  },
                )
                : (widget.onPressed != null && widget.showUploadIcon
                    ? IconButton(
                      icon: Icon(
                        Icons.file_upload_outlined,
                        color: AppColors.main,
                      ),
                      onPressed: widget.onPressed,
                    )
                    : null),
        suffix:
            widget.suffixText != null
                ? GestureDetector(
                  onTap: widget.onPressed ?? () {},
                  child: Text(
                    widget.suffixText!,
                    style: TextStyle(
                      color: Color(0xffD9D9D9),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                )
                : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        errorMaxLines: 2,
        errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }
}
