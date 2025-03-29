import 'dart:io';

class HttpProxy extends HttpOverrides {
  final String host;
  final String port;

  HttpProxy({required this.host, required this.port});

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    var http = super.createHttpClient(context);
    http.findProxy = (uri) {
      return 'PROXY $host:$port';
    };
    http.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return http;
  }
}
