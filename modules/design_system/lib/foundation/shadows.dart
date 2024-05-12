
import 'package:flutter/material.dart';

class DistroShadows {
  static final shadow_200 = BoxShadow(
    color: const Color(0xff18274B).withOpacity(.08),
    offset: const Offset(0, 8),
    blurRadius: 16,
    spreadRadius: -6
  );

  static final shadow_300 = BoxShadow(
    color: const Color(0xff18274B).withOpacity(.16),
    offset: const Offset(0, 6),
    blurRadius: 8,
    spreadRadius: -6
  );
}