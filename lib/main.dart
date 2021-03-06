import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String numberField = "";

  void _calcVisual(String _number) {
    setState(() {
      switch (_number) {
        case "+":
          numberField += " " + _number + " ";
          break;
        case "-":
          numberField += " " + _number + " ";
          break;
        case "*":
          numberField += " " + _number + " ";
          break;
        case "/":
          numberField += " " + _number + " ";
          break;
        case "=":
          numberField = _calcTotal(numberField);
          break;
        case "c":
          numberField = "";
          numberField = "0";
          break;
        default:
          var listlastnumber = numberField.split(" ");
          String lastsymbol = "";
          String lastnumber = "";
          if (listlastnumber.length >= 3) {
            lastsymbol = listlastnumber[listlastnumber.length - 2];
            lastnumber = listlastnumber[listlastnumber.length - 1];
          }
          if (_isItASymbol(lastsymbol) && lastnumber == "") {
            numberField += double.parse(_number).toString();
          } else if (_isItASymbol(lastsymbol) && lastnumber != "") {
            listlastnumber[listlastnumber.length - 1] =
                _addNumber(lastnumber, _number);
            numberField = "";
            for (var item in listlastnumber) {
              if (_isItASymbol(item)) {
                item = " " + item + " ";
              }
              numberField += item;
            }
          } else if (numberField == "0") {
            numberField = double.parse(_number).toString();
          } else {
            numberField = _addNumber(numberField, _number);
          }
      }
    });
  }

  String _addNumber(String _mainNumber, String _newNumber) {
    _mainNumber =
        (double.parse(_mainNumber) * 10 + double.parse(_newNumber)).toString();
    return _mainNumber;
  }

  bool _isItASymbol(String lastsymbol) {
    bool returner = false;
    if (lastsymbol == "+" ||
        lastsymbol == "-" ||
        lastsymbol == "*" ||
        lastsymbol == "/") {
      returner = true;
    }
    return returner;
  }

  String _calcTotal(String _calculation) {
    List counter = new List();
    String sResult = "";
    double iResult = 0;
    counter = _calculation.split(" ");
    for (int i = 0; i <= counter.length; i++) {
      switch (counter[i]) {
        case "+":
          iResult = double.parse(counter[i - 1]) + double.parse(counter[i + 1]);
          sResult = iResult.toString();
          break;
        case "-":
          iResult = double.parse(counter[i - 1]) - double.parse(counter[i + 1]);
          sResult = iResult.toString();
          break;
        case "*":
          iResult = double.parse(counter[i - 1]) * double.parse(counter[i + 1]);
          sResult = iResult.toString();
          break;
        case "/":
          iResult = double.parse(counter[i - 1]) / double.parse(counter[i + 1]);
          sResult = iResult.toString();
          break;
        default:
          if (sResult != "") {
            return sResult;
          }
      }
    }
    return sResult;
  }

  Widget newButton(String _buttonNumber) {
    return (RaisedButton(
      onPressed: () => _calcVisual(_buttonNumber),
      color: Colors.white,
      child: Text(_buttonNumber),
      padding: EdgeInsets.all(35),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              "$numberField",
              style: TextStyle(fontSize: 50),
            ),
            Row(
              children: <Widget>[
                newButton("7"),
                newButton("8"),
                newButton("9"),
                newButton("/"),
              ],
            ),
            Row(
              children: <Widget>[
                newButton("4"),
                newButton("5"),
                newButton("6"),
                newButton("*"),
              ],
            ),
            Row(
              children: <Widget>[
                newButton("1"),
                newButton("2"),
                newButton("3"),
                newButton("-"),
              ],
            ),
            Row(
              children: <Widget>[
                newButton("0"),
                newButton("c"),
                newButton("="),
                newButton("+"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
