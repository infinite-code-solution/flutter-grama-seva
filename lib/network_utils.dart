import 'dart:io';

class NetworkUtils {
  static Future<bool> checkInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  static Future<bool> isVpnActive() async {
    bool isVpnActive = false;
    try {
      List<NetworkInterface> interfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.any,
      );
      for (NetworkInterface interface in interfaces) {
        String name = interface.name.toLowerCase();
        if (name.contains('tun') ||
            name.contains('ppp') ||
            name.contains('tap') ||
            name.contains('ipsec') ||
            name.contains('vpn')) {
          isVpnActive = true;
          break;
        }
      }
    } catch (e) {
      // Ignore error
    }
    return isVpnActive;
  }
}
