import 'package:package_info_plus/package_info_plus.dart';

import '../utils/encrypted_shared_preference_utils.dart';

class AppState {
  factory AppState() {
    return _singleton;
  }

  AppState._internal();

  static final AppState _singleton = AppState._internal();

  ///Shared Preference
  EncryptedSharedPreferencesUtils encryptedSharedPreferences = EncryptedSharedPreferencesUtils();

  ///PackageInfo
  PackageInfo? packageInfo;

  ///Data
  bool isLogin = true;

  ///De Bounce
// final deBouncer = Debouncer(delay: const Duration(milliseconds: 1200));
// final deBouncerScroll = Debouncer(delay: const Duration(milliseconds: 1000));

  /// Package Info like version
  Future<void> getVersionInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
  }

  List<String> roles = [
    'Product Designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner',
  ];
}
