
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io';
import 'calcuator.dart';


List<String> _text = [
  "%","C","<-","÷",
  "7","8","9","x",
  "4","5","6","-",
  "1","2","3","+",
  ".","0","+/-","=",
];
int rowNum =4;
String _calcuator = '0.0';
bool isStartCal=false;

class CPage extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('loop_in_Row')),

      ),
      body: CPageStatefulWidget(title: tr('loop_in_Row')),
    );
  }
}


class CPageStatefulWidget extends StatefulWidget {

  CPageStatefulWidget({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _ParentWidgetState createState() => new _ParentWidgetState();
}


class _ParentWidgetState extends State<CPageStatefulWidget> {
  void _setData(String v){
    if(     v==("x")
        ||  v==("+")
        ||  v==("-")
        ||  v==("÷")
        ||  v==("%")
        ||  v==("+/-")
    ){
      isStartCal = true;
    }

    setState(() {
      if(!isStartCal){
        isStartCal = true;
        _calcuator="0.0";
      }
      switch (v){
        case 'C':
          _calcuator = '0.0';
          isStartCal = false;
          break;
        case '<-':
          _calcuator = Calcuator().rmSub(_calcuator);
          break;
        case 'X':
        case 'x':
          _calcuator = '$_calcuator'+'x';
          break;
        case '=':
          isStartCal = false;
          var ssss = _calcuator;
          _calcuator = Calcuator().init(ssss).toString();
          break;
        case '+/-':
          var ssss = _calcuator;
          var list =Calcuator().PositiveAndNegative(ssss);
          _calcuator = list.toString();
          break;
        default :
          if(_calcuator=='0.0'){
            _calcuator = '$v';
          }else
            _calcuator = '$_calcuator'+'$v';
          break;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 5.0, bottom: 10.0), //容器外填充
              padding: EdgeInsets.all(10.0), //容器内补白
              decoration: new BoxDecoration(color: Colors.blue),
              child: new Center(
                child:Text('$_calcuator',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                  ),
                ) ,
              ),
            ),
            for(int i =0;i<(_text.length/rowNum);i++)
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    for(int j=0;j<rowNum;j++)
                      Container(
                        //margin:EdgeInsets.only(left: padNum,right: padNum),
                        child: ButtonTheme(
                          buttonColor: Colors.lightBlue,
                          child: RaisedButton(
                            onPressed: () {
                                _setData(_text[i*rowNum+j].toString());
                            },
                            child: Text(_text[i*rowNum+j].toString(),
                                style: TextStyle(
                                    fontSize: 30.0,
                                    color: Colors.white)
                            ),
                          ),
                        ),
                      ),
                  ]
              )
          ],
        )
    );
  }


}

