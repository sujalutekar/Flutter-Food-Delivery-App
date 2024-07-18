import 'package:flutter/material.dart';
import 'package:foodie/theme/app_pallete.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  const AuthField({
    super.key,
    required this.controller,
    required this.title,
    required this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please enter ${hintText.toLowerCase()}';
            }
            return null;
          },
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),

            // border
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            // focused border
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppPallete.primaryColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            // error border
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.red.shade400,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
