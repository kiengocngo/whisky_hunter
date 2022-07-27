import 'package:flutter/material.dart';

enum TMLanguage { en, vi }

class GlobalManager {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  var uId = '';
}
