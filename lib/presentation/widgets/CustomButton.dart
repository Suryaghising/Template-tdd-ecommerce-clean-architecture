import 'package:flutter/material.dart';
import 'package:template/presentation/widgets/responsive_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onPressed, required this.text});

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor:
        MaterialStateProperty.all<Color>(Colors.redAccent),
        padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(vertical: 12)),
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4))),
      ),
      child: ResponsiveText(
        text,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        textColor: Colors.white,
      ),
    );
  }
}
