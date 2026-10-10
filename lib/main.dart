import 'package:flutter/material.dart';

import 'app.dart';
import 'injection.dart';

void main() {
  setupDependencies();
  runApp(const PatternLabApp());
}
