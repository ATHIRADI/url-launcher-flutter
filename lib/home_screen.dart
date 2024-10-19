import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Method to launch URLs
  void _launchURL(Uri uri, bool inApp) async {
    try {
      if (await canLaunchUrl(uri)) {
        // Choose launch mode: inApp or external browser
        if (inApp) {
          await launchUrl(uri, mode: LaunchMode.inAppWebView);
        } else {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      } else {
        _showSnackBar("Could not launch the URL: ${uri.toString()}");
      }
    } catch (e) {
      _showSnackBar("Error: ${e.toString()}");
    }
  }

  // Display a snackbar for errors
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Button creation for reusable code
  Widget buildActionButton(String text, Uri uri, bool inApp) {
    return InkWell(
      onTap: () => _launchURL(uri, inApp),
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('URL Launcher'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildActionButton(
              "Open URL in Browser",
              Uri.parse('https://www.google.com'),
              false,
            ),
            buildActionButton(
              "Open URL in App",
              Uri.parse('https://www.google.com'),
              true,
            ),
            buildActionButton(
              "Call Phone Number",
              Uri.parse('tel:+1234567890'),
              false,
            ),
            buildActionButton(
              "Send Email",
              Uri.parse('mailto:test@example.com'),
              false,
            ),
            buildActionButton(
              "Open YouTube Video",
              Uri.parse(
                  'https://www.youtube.com/watch?v=QOPqSxJajNc&list=WL&index=1&t=20s'),
              false,
            ),
          ],
        ),
      ),
    );
  }
}
