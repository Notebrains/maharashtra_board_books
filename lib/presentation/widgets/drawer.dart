import 'package:flutter/material.dart';
import 'package:maharashtra_board_books/common/constants/strings.dart';
import 'package:maharashtra_board_books/common/extensions/common_fun.dart';
import 'package:maharashtra_board_books/presentation/widgets/asset_pdf_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import 'createDrawerBodyItem.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
          margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      'Maharashtra',
                      style: TextStyle(
                          color: Colors.green.shade600,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    'Board Books',
                    style: TextStyle(
                        color: Colors.green.shade600,
                        fontSize: 26.0,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
          ),

          createDrawerBodyItem(
              icon: Icons.email,text: 'Send us correction',
              onTap: () async {
                final Uri params = Uri(
                  scheme: 'mailto',
                  path: 'ktmbsoftware@gmail.com',
                  query: 'subject=Maharashtra Board Books&body=',
                );

                var url = params.toString();
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
          }),

          createDrawerBodyItem(
              icon: Icons.lock_rounded,text: 'Privacy Policy', onTap: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
                  const AssetPdfView()
              ),
            );
          }),

          createDrawerBodyItem(
              icon: Icons.share_rounded,text: 'Share this app with your friend', onTap: () {
              Share.share('hey! check out this new app https://play.google.com/store/apps/details?id=com.board.maharashtra.books', subject: Strings.appName);
          }),
          createDrawerBodyItem(
              icon: Icons.star_rate,text: 'Rate this app', onTap: () {
              doLaunchUrl('https://play.google.com/store/apps/details?id=com.board.maharashtra.books');
          }),
          const Padding(
            padding: EdgeInsets.only(left: 12, right: 24),
            child: Divider(
              color: Colors.grey,
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'More apps',
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w500),
            ),
          ),

          createDrawerBodyItem(
              icon: Icons.search,text: 'More apps', onTap: () async {
              doLaunchUrl('https://play.google.com/store/search?q=maharashtra%20board%20books&hl=en');
          }),
        ],
      ),
    );
  }
}
