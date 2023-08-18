import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;

class Environment {
  static String apiUrl = kIsWeb
      ? 'http://localhost:3000/api' // for Web
      : Platform.isAndroid
          ? 'http://10.0.2.2:3000/api' // for Android
          : 'http://localhost:3000/api'; // for Others

  static String socketUrl = kIsWeb
      ? 'http://localhost:3000' // for Web
      : Platform.isAndroid
          ? 'http://10.0.2.2:3000' // for Android
          : 'http://localhost:3000'; // for Others
}
