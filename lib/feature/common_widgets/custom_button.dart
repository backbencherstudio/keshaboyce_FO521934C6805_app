import 'package:flutter/material.dart';

class CustomButtonPrimary {
  static Widget build({
    required String text,
    required VoidCallback onPressed,
    double? width,
    double height = 50,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF092549),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class CustomButtonSecondary {
  static Widget build({
    required String text,
    required VoidCallback onPressed,
    double? width,
    double height = 50,
  }) {
    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF092549),
          side: const BorderSide(color: Color(0xFFE0E0E0), width: 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

/// Use this Row to place both buttons side by side
class ButtonRow extends StatelessWidget {
  const ButtonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButtonPrimary.build(
            text: "Primary",
            onPressed: () {},
            width: 120,
          ),
          const SizedBox(width: 11), // space between buttons
          CustomButtonSecondary.build(
            text: "Secondary",
            onPressed: () {},
            width: 120,
          ),
        ],
      ),
    );
  }
}
