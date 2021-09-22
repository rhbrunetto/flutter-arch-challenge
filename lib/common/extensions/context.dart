import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

extension ContextOperations on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  Size get mediaSize => MediaQuery.of(this).size;
}
