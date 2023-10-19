import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
      {super.key, this.onPressed, required this.leading, required this.label});

  final void Function()? onPressed;
  final Widget leading;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white, foregroundColor: Colors.black),
        child: Row(
          children: [
            const SizedBox(
              width: 12,
            ),
            leading,
            const SizedBox(
              width: 8,
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
