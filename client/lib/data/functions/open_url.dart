import 'package:url_launcher/url_launcher.dart' show launchUrl;

///Function to open urls
Future<void> openUrl(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}
