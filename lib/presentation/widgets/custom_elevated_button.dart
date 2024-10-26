import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const CustomElevatedButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: BorderSide(
          width: 2.5,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style:
            TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
    );
  }
}
