import 'package:android_police_rss/classes/feed.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsTile extends StatefulWidget {
  @override
  _NewsTileState createState() => _NewsTileState();

  Feed feed;
  NewsTile({Key? key, required this.feed}) : super(key: key);
}

class _NewsTileState extends State<NewsTile> {
  //URL LAUNCHER
  _launchBrowser(String url) async {
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _launchBrowser(widget.feed.link);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 6),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.feed.title,
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 10,),
                      Text(
                        widget.feed.DataFormatada,
                        style: TextStyle(
                            fontSize: 12.5, color: Theme.of(context).hintColor),
                      ),
                    ],
                  ),

                  IconButton(
                      color: Theme.of(context).hintColor,
                      icon: Icon(Icons.share_outlined),
                      constraints: BoxConstraints(maxHeight: 30),
                      iconSize: 21,
                      splashRadius: 26,
                      onPressed: () {
                        Share.share(widget.feed.link);
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
