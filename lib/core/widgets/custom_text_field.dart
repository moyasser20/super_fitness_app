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
  final Color? borderColor;
  final Color? hintColor;
  final Color? textColor;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;

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
    this.borderColor,
    this.hintColor,
    this.textColor,
    this.fillColor,
    this.contentPadding,
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
    final borderClr = widget.borderColor ?? AppColors.white;
    final hintClr = widget.hintColor ?? AppColors.white.withValues(alpha: 0.5);
    final textClr = widget.textColor ?? AppColors.white;
    final fillClr = widget.fillColor ?? Colors.transparent;
    final padding =
        widget.contentPadding ??
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12);

    return TextFormField(
      autofocus: true,
      controller: _controller,
      enabled: widget.enabled,
      readOnly: widget.readonly,
      onTap: widget.readonly ? (widget.onPressed) : null,
      enableInteractiveSelection: widget.readonly ? false : true,
      contextMenuBuilder:
          widget.readonly
              ? (context, editableTextState) => const SizedBox.shrink()
              : null,
      obscureText: isTextObscured,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      onChanged: widget.onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: TextStyle(
        color: textClr,
        fontWeight: FontWeight.w400,
        fontSize: 15,
      ),
      cursorColor: AppColors.main,
      decoration: InputDecoration(
        filled: true,
        fillColor: fillClr,
        contentPadding: padding,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: borderClr, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: borderClr, width: 1.5),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderClr.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(30),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        hintText: widget.hint,
        hintStyle: TextStyle(color: hintClr),
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
                    style: const TextStyle(
                      color: Color(0xffD9D9D9),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                )
                : null,
        errorMaxLines: 2,
        errorStyle: const TextStyle(color: Colors.red, fontSize: 12),
      ),
    );
  }
}
