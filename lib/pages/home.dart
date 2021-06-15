import 'dart:async';
import 'package:android_police_rss/classes/feed.dart';
import 'package:android_police_rss/configs/settingsPage.dart';
import 'package:android_police_rss/widgets/newsCardSmall.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/webfeed.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const String feedUrl =
      'https://www.androidpolice.com/feed/';
  List<RssItem> articlesList = [];
  bool loading = true;

  //URL LAUNCHER
  _launchBrowser(String url) async {
    if (await launch(url)) {
      await launch(url);
    } else {
      throw 'Error';
    }
  }

  @override
  void initState() {
    getRssData();
    super.initState();
  }

  Future<void> getRssData() async {
    var client = http.Client();
    var response = await client.get(Uri.parse(feedUrl));
    var channel = RssFeed.parse(response.body);
    setState(() {
      articlesList = channel.items!.toList();
      loading = false;
    });
    client.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Android Police'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings_outlined,
                color: Theme.of(context)
                    .textTheme
                    .headline6!
                    .color!
                    .withOpacity(0.7),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => SettingsPage(),
                      fullscreenDialog: true,
                    ));
              }),
        ],
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : RefreshIndicator(
                onRefresh: getRssData,
                child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: articlesList.length,
                        itemBuilder: (context, index) {
                         return ListTile(
                           title: Text(articlesList[index].title.toString()),
                           //onTap: _launchBrowser('oi'),
                         );
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ]),
              ),
      ),
    );
  }
}
