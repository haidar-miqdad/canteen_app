import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core.dart';

class AppTitle extends StatelessWidget {
  final String text;
  const AppTitle({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: GoogleFonts.righteous(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: AppColors.black.withOpacity(0.7),
        ));
  }
}