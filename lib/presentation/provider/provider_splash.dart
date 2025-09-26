import 'package:package_info_plus/package_info_plus.dart';


class ProviderSplash {
  Future<(String name, String versio,String build)> loadData() async {
    final info = await PackageInfo.fromPlatform();
    return(info.appName,info.version,info.buildNumber);
  }
}