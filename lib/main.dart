import 'package:flutter/material.dart';
import 'package:my_url_launcher/widgets/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyUrlLauncher());
}

class MyUrlLauncher extends StatelessWidget {
  const MyUrlLauncher({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'url launcher'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomButton(
            onPressed: () {
              openPDF(context);
            },
            title: 'open pdf',
          ),
          CustomButton(
            onPressed: () {
              calling(context);
            },
            title: 'phone calling',
          ),
          CustomButton(
            onPressed: () {
              sms(context);
            },
            title: 'sms',
          ),
          CustomButton(
            onPressed: () {
              whatsapp(context);
            },
            title: 'whatsapp',
          ),
          CustomButton(
            title: 'messanger',
            onPressed: () {
              messanger(context);
            },
          ),
          CustomButton(
            onPressed: () {
              email(context);
            },
            title: 'email',
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> openPDF(context) async {
    // you can launch any url
    Uri url = Uri.parse('https://books-library.net/free-402765885-download');
    await canLaunchMyUrl(url, context);
  }

  Future<void> calling(context) async {
    Uri url = Uri.parse('tel:+201551190267');
    await canLaunchMyUrl(url, context);
  }

  Future<void> whatsapp(context) async {
    String phoneNumber = '+201066505898';
    // Uri url = Uri.parse('whatsapp://send?phone=$phoneNumber');  please note that starting from WhatsApp version 2.21.100 and later, WhatsApp has implemented a security feature that restricts launching the app using URL schemes directly. This means that this method may not work with recent versions of WhatsApp.
    Uri url = Uri.parse(
        'https://wa.me/$phoneNumber'); // this method will open whatsapp on browser , and if whatsapp app is installed , it will automatically open the app
    await canLaunchMyUrl(url, context);
  }

  Future<void> messanger(context) async {
    String userId = 'Noureen Naser';
    Uri url = Uri.parse('http://m.me/$userId');
    await canLaunchMyUrl(url, context);
  }

  // it seems strange but you can use sms method to send message using whatsapp
  Future<void> sms(context) async {
    String phoneNumber = '+201551190267';
    Uri url = Uri.parse('sms:$phoneNumber');
    await canLaunchMyUrl(url, context);
  }

  Future<void> email(context) async {
    String email = 'ah.ibrahiem70@yahoo.com';

    Uri url = Uri.parse('mailto:$email');
    await canLaunchMyUrl(url, context);
  }

  Future<void> canLaunchMyUrl(Uri url, context) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      
    } else {
      showSnackBar(context, url.toString());
    }
  }

  void showSnackBar(context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'can\'t launch $message',
          style: const TextStyle(fontSize: 20),
        ),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
