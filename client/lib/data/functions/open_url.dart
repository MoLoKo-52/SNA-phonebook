import 'package:url_launcher/url_launcher.dart' show canLaunchUrl, launchUrl;

///Function to open urls
Future<void> openUrl(String string, String surname) async {
  if (string[0] != '@') {
    openMail(string, surname);
    return;
  }
  final Uri url = Uri.parse('https://t.me/${string.substring(1)}');
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

///Function to open mail

Future<void> openMail(String email, String surname) async {
  final message = '''
Dear Professor $surname,

I am ... .
I have a question about ...

Best regards,
<your name>
''';
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: email,
    query: Uri.encodeFull('subject=Question&body=$message'),
  );

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    print('Could not launch email app');
  }
}

//
