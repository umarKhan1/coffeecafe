import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.label,
    this.hint,
    this.prefixIcon,
    this.controller,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.obscureText = false,
    this.isRequired = true,
    this.errorText,
  });

  final String label;
  final String? hint;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final bool isRequired;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final bg = Theme.of(context).scaffoldBackgroundColor;
    final hasError = errorText != null && errorText!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Border + field
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: hasError ? const Color(0xFFFF4D4D) : Colors.white.withOpacity(0.32),
                    width: 1.2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                  child: Row(
                    children: [
                      if (prefixIcon != null)
                        Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: Icon(
                            prefixIcon,
                            size: 22,
                            color: Colors.white,
                          ),
                        ),
                      Expanded(
                        child: TextFormField(
                          controller: controller,
                          validator: validator,
                          onChanged: onChanged,
                          keyboardType: keyboardType,
                          inputFormatters: inputFormatters,
                          obscureText: obscureText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: hint,
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.55),
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Label sitting on the border
              Positioned(
                left: 20,
                top: -10,
                child: Container(
                  color: bg,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    children: [
                      Text(
                        label.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      if (isRequired) ...[
                        const SizedBox(width: 3),
                        const Text(
                          '*',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Error text
          if (hasError)
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 6),
              child: Text(
                errorText!,
                style: const TextStyle(
                  color: Color(0xFFFF4D4D),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
