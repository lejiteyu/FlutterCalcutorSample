

class Calcuator {
  List negateRemainder(String call){
    var x = call.split('%');
    return x;
  }
  List negateLess(String call){
    var x = call.split('-');
    return x;
  }

  List negateAdd(String call){
    var x = call.split('+');
    return x;
  }

  List negateExcept(String call){
    var x = call.split('÷');
    return x;
  }

  List negateMultiply(String call){
    var x = call.split('x');
    return x;
  }
  List negatE(String f){
    print("f size:${f.length}, $f");
    var r = negateRemainder(f);
    print("r size:${r.length}, $r");
    var lenR = r.length;
    var list = new List();
    for (var i=0 ;i<lenR;i++){
      var m = negateMultiply(r[i]);
      print("m size:${m.length}, $m");
      var lenM = m.length;
      for (var j=0 ;j<lenM;j++){
        var e = negateExcept(m[j]);
        print("e size:${e.length}, $e");
        var lenE = e.length;
        for (var k=0 ;k<lenE;k++){
          var a = negateAdd(e[k]);
          print("a size:${a.length}, $a");
          var lenA = a.length;
          for (var l=0 ;l<lenA;l++){
            var L = negateLess(a[l]);
            print("L size:${L.length}, $L");
            var lenL = L.length;
            for(var n=0 ;n<lenL;n++){
              list.add(L[n]);
              if(lenL>1 && n<lenL-1)
                list.add("-");
            }
            if(lenA>1 && l<lenA-1)
              list.add("+");
          }
          if(lenE>1 && k<lenE-1)
            list.add("÷");
        }
        if(lenM>1&& j<lenM-1)
          list.add("x");
      }
      if(lenR>1&& i<lenR-1)
        list.add("%");
    }
    print("List size:${list.length}, $list");
    return list;
  }

//移除空值
  List rmEmpty(List f){
    var len = f.length;
    for(var i =0;i<len;i++){
      if(f[i].isEmpty){
        f.removeAt(i);
        len=f.length;
        print("len:, $len");
      }
    }
    return f;
  }

  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  //負值歸位
  List NegativeValueHoming(List list){
    var len = list.length;
    for(var i =0;i<len;i++){
      var num = list[i];
      if (i + 1 < len ) {
        var num2 = list[i + 1];
        var isNum = isNumeric(num2);
        if (num=="-" && isNum) {
          var num3 = num + num2;
          list.insert(i, num3);
          list.removeAt(i + 1);
          list.removeAt(i + 1);
          len = list.length;
        }
      }
    }
    return list;
  }

  //先取餘數
  List remainder(List list){
    var len = list.length;
     for(var i=0;i<len-1;i++){
       var num = list[i];
       if (i + 1 < len  && i>0) {
         String num2S = list[i + 1];
         var num2 = num2S.replaceAll(" ","");
         var num3 = list[i - 1].replaceAll(" ","");
         var isNum2 = isNumeric(num2);
         var isNum3 =isNumeric(num3);
         if (num==("%") && isNum2 && isNum3) {
           var num4 = double.parse(num3) % double.parse(num2);
           print("20200514 you remainder $num3 % $num2 = $num4");
           list.insert(i-1, num4.toString());
           list.removeAt(i );
           list.removeAt(i );
           list.removeAt(i );
           len = list.length;
           i=0;
         }
       }
     }
     return list;
  }
  //先乘除
  List MultiplyFirst(List list){
      var len = list.length;
      for(var i=0;i<len-1;i++) {
        var num = list[i];
        if (i + 1 < len  && i>0) {
          var num2 = list[i + 1].replaceAll(" ","");
          var num3 = list[i - 1].replaceAll(" ","");
          var isNum2 = isNumeric(num2);
          var isNum3 = isNumeric(num3);
          if (num==("x") && isNum2 && isNum3) {
            var num4 = double.parse(num3) * double.parse(num2);
            list.insert(i-1, num4.toString());
            list.removeAt(i );
            list.removeAt(i );
            list.removeAt(i );
            len = list.length;
            print("20200514 you complent t[$i]:"+list.toString());
            i=0;
          }
          else if (num==("÷") && isNum2 && isNum3) {
            var num4  = double.parse(num3) / double.parse(num2);
            list.insert(i-1, num4.toString());
            list.removeAt(i );
            list.removeAt(i );
            list.removeAt(i );
            len = list.length;
            print("20200514 you complent t[$i]:"+list.toString());
            i=0;
          }
        }
      }
      return list;
  }

  //移除非數字部分
  List reNoNum(List list){
    var len =list.length;
    for (var i=0 ; i<len;i++){
        var num = list[i];
        if (!isNumeric(num)) {
          list.removeAt(i);
          len =list.length;
        }
    }
    print("20200514 you reNoNum :"+list.toString());
    return list;
  }

  List AddSub(List list){
    var len = list.length;
    for(int i=0;i<len-1;){
      var num2 = list[i + 1].replaceAll(" ","");
      var num3 = list[i].replaceAll(" ","");
      var isNum2 = isNumeric(num2);
      var isNum3 = isNumeric(num3);
      if (isNum2 && isNum3) {
        var num4 = double.parse(num3) + double.parse(num2);
        list.insert(0, num4.toString());
        if(list.length>2) {
          list.removeAt(i+1);
          list.removeAt(i+1);
          len =list.length;
        }
        i=0;
      }else
        i++;
    }
    return list;
  }

  String rmSub(String sss){
    int len = sss.length;
    if(len>0) {
      sss=sss.substring(0,len-1);
    }
    return sss;
  }

  String PositiveAndNegative(String ssss){
    var list= Calcuator().negatE(ssss);
    var len = list.length;
    RegExp regex = new RegExp("[+|-|x|÷]");
    RegExp regex2 = new RegExp("[+|-]");
    var t="";
    for(var i = len-1; i>=0;i--){
      var num = list[i];
      var num2 ="";
      if(i-1<len && i!=0)
        num2 = list[i-1];
      var flag = regex.hasMatch(num);
      var flag2 = regex2.hasMatch(num2);
      if(flag2){
        if(num2==("+")){
          list.insert(i-1,"-");
          list.removeAt(i);
        }else{
          list.insert(i-1,"+");
          list.removeAt(i);
        }
        break;
      }else if(!flag){
        var num3 =  double.parse(num);
        var num4 = num3*-1;
        list.insert(i,num4.toString());
        list.removeAt(i+1);
        break;
      }
    }
    print ('PositiveAndNegative = $list');
    var sss ='';
    len = list.length;
    for(var i=0;i<len;i++){
      sss =sss+list[i];
    }
    print ('PositiveAndNegative sss= $sss');
    return sss;
  }

  dynamic init(String c){
    var f =negatE(c);//詳細分割
    f= rmEmpty(f);//移除空值
    f = NegativeValueHoming(f); //負值歸位
    f = remainder(f);//先取餘數
    f = MultiplyFirst(f);//先乘除
    f = reNoNum(f);//移除非數字部分
    f = AddSub(f);//後加減
    print("rmEmpty size:, $f");
    print("f size:, $f");

    return double.parse(f[0]);
  }


}
