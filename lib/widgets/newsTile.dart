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
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
                    child: Text(
                      widget.feed.DataFormatada,
                      style: TextStyle(
                          fontSize: 12.5, color: Theme.of(context).hintColor),
                    ),
                  ),

                  ElevatedButton.icon(
                    icon: Icon(Icons.share_outlined, size: 16.0,color: Theme.of(context).textTheme.headline6!.color,),
                    label: Text("Share",style: TextStyle(fontSize: 13,color: Theme.of(context).textTheme.headline6!.color),),
                    onPressed: () {
                      Share.share(widget.feed.link);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      primary: Theme.of(context).cardTheme.color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
