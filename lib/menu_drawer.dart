

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:email_launcher/email_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info/package_info.dart';

import 'BPage.dart';
import 'CPage.dart';

String _appVersion = '0.0.0';

class MenuStatefulWidget extends StatefulWidget {
  MenuStatefulWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ParentWidgetState createState() => new _ParentWidgetState();
}

class _ParentWidgetState extends State<MenuStatefulWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initVersion();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
      ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Lyon flutter make app'),
            accountEmail: Text(_appVersion),
            currentAccountPicture: Image.asset('resources/images/lyonhsu3_t.png'),
            decoration: BoxDecoration(color: Colors.grey),
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text(tr('about_Me')),
            onTap: () {
              Navigator.pop(context);
              showMyMaterialDialog(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.more),
            title: Text(tr('next_page')),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => BPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.more),
            title: Text(tr('loop_in_Row')),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => CPage()));
            },
          ),
        ],
      );
  }



  void showMyMaterialDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text("title"),
            content: new Text(
              tr('title'),
              // 加大字体, 便于演示
              style: TextStyle(fontSize: 30),),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: new Text(tr('ok')),
              ),
              IconButton(
                onPressed: (){
                  send();
                },
                icon: Icon(Icons.mail),
              )
            ],
          );
        });
  }

  Future initVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var localVersion = packageInfo.version;
    var buildNumber = packageInfo.buildNumber;
    print('initVersion() localVersion:$localVersion buildNumber=$buildNumber');
    setState(() {
      _appVersion = 'ver:$localVersion($buildNumber)';
    });
  }



  void send() async {
    List<String> to = ['lejiteyu@gmail.com'];
    List<String> cc = [''];
    List<String> bcc = [''];
    String subject = tr('app_name') + ' ' + _appVersion;
    String body = '';
    if (Platform.isAndroid) {
      Email email = Email(
          to: to,
          cc: cc,
          bcc: bcc,
          subject: subject,
          body: body);
      await EmailLauncher.launch(email);
    }else if (Platform.isIOS) {
      var mail = to[0];
      var sub = subject.replaceAll(" ", "%20");
      var boddy = body.replaceAll(" ", "%20");
      var _launched = _openUrl('mailto:$mail?subject=$sub&body=$boddy');
    }
  }

  Future<void> _launched;

  Future<void> _openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}