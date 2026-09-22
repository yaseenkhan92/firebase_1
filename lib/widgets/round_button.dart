import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final bool loading;
  const RoundedButton({
    super.key,
    required this.title,
    required this.ontap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(
          child: loading
              ? CircularProgressIndicator(strokeWidth: 4, color: Colors.white)
              : Text(title, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
