import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // ← أضف هذا

class ShareSheet {
  static void showShareAyahOptions({
    required BuildContext context,
    required String verseText,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 16,
            children: [
              const Text(
                'مشاركة الآية',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
                title: const Text("Share via WhatsApp | مشاركة على واتساب"),
                onTap: () {
                  Share.share(verseText);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                title: const Text("Share via Facebook | مشاركة على فيس بوك"),
                onTap: () {
                  Share.share(verseText);
                  Navigator.pop(context);
                },
              ),
               ListTile(
                leading: const FaIcon(FontAwesomeIcons.instagram, color: Colors.purple),
                title: const Text("Share via Instagram | مشاركة على انستقرام "),
                onTap: () {
                  Share.share(verseText);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text("مشاركة عبر تطبيق آخر"),
                onTap: () {
                  Share.share(verseText);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
   }

  static void showShareTafsirOptions({
    required BuildContext context,
    required String verseText,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: 16,
            children: [
              const Text(
                'مشاركة التفسير',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
                title: const Text("Share via WhatsApp | مشاركة على واتساب"),
                onTap: () {
                  Share.share(verseText);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
                title: const Text("Share via Facebook | مشاركة على فيس بوك"),
                onTap: () {
                  Share.share(verseText);
                  Navigator.pop(context);
                },
              ),
               ListTile(
                leading: const FaIcon(FontAwesomeIcons.instagram, color: Colors.purple),
                title: const Text("Share via Instagram | مشاركة على انستقرام "),
                onTap: () {
                  Share.share(verseText);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.share),
                title: Text("مشاركة عبر تطبيق آخر"),
                onTap: () {
                  Share.share(verseText);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }


}
