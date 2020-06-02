import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class BPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('page_b_title')),

      ),
      body: _BPage(),
    );
  }
}

class _BPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child:Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Image.network(
                'https://titangene.github.io/images/cover/flutter.jpg'),
          ),
          Expanded(
              child: InkWell(
                  onTap : (){
                    Navigator.pop(context);
                  },
                  child: new Image.asset('resources/images/lyonhsu3_t.png')
              )
          ),
          RaisedButton(
            child: Text(tr('back_front_page')),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Image.asset('resources/images/record.png'),
              ),
              Visibility(
                visible: true,
                child:  Expanded(
                  child: Image.asset('resources/images/record.png'),
                ),
              ),
              Expanded(
                child: Image.asset('resources/images/record.png'),
              ),
              Expanded(
                child: Image.asset('resources/images/record.png'),
              ),
            ],
          ),
        ],
      )
    );
  }
}

