import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'model/data.dart';

void main() {
  runApp(new MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
    const MyApp({Key? key}) : super(key: key);
    @override
    State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{
  final _accountSize = TextEditingController();
  bool _validate = false;
  Data data = new Data();
  final _portfolioRisk = TextEditingController();
  final _stopLoss = TextEditingController();
  final _target = TextEditingController();

calculate() {
    double ta =
        (data.portfolioRisk.toDouble() / 100 * data.accountSize.toDouble()) /
            (data.stopLoss.toDouble() / 100);
    String calculation = " You have a \$" +
        data.accountSize.toString() +
        " account" +
        "\n Account risk is " +
        data.portfolioRisk.toString() +
        "%" +
        "\n Stop Loss of the trade is " +
        data.stopLoss.toString() +
        "% and that will be \$" +
        (data.portfolioRisk.toDouble() / 100 * data.accountSize.toDouble())
            .toString() +
        "\n You need to enter the trade with \$" +
        ta.toString() +
        " in order to have " +
        data.portfolioRisk.toString() +
        "% account risk" +
        "\n If you win with a " +
        data.target.toString() +
        "% target, You'll win \$" +
        ((ta * data.target.toDouble()) / 100).toString();

    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Here are the results:"),
      content: Text(calculation),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  void _setTargetState(String target) {
    if (target.length > 0) data.target = int.parse(target);
  }

  void _setStopLossState(String stopLoss) {
    if (stopLoss.length > 0) data.stopLoss = int.parse(stopLoss);
  }

  void _setPortfolioRiskState(String portfolioRisk) {
    if (portfolioRisk.length > 0) data.portfolioRisk = int.parse(portfolioRisk);
  }

  void _setAccountSizeState(String accountSize) {
    if (accountSize.length > 0) data.accountSize = int.parse(accountSize);
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text("Trading calculator"),
        ),
        body: Center(
            child: FractionallySizedBox(
                widthFactor: 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: _accountSize,
                      onChanged: (val) {
                        _setAccountSizeState(val);
                      },
                      decoration: new InputDecoration(
                          errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          hintText: "Account size in \$"),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    TextField(
                      controller: _portfolioRisk,
                      onChanged: (val) {
                        _setPortfolioRiskState(val);
                      },
                      decoration: new InputDecoration(
                          errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          hintText: "What's your portfolio risk in %"),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    TextField(
                      controller: _stopLoss,
                      onChanged: (val) {
                        _setStopLossState(val);
                      },
                      decoration: new InputDecoration(
                          errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          hintText: "What's your stop loss on the trade in %"),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    TextField(
                      controller: _target,
                      onChanged: (val) {
                        _setTargetState(val);
                      },
                      decoration: new InputDecoration(
                          errorText: _validate ? 'Value Can\'t Be Empty' : null,
                          hintText: "What's your target in %"),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _target.text.isEmpty ||
                                  _stopLoss.text.isEmpty ||
                                  _portfolioRisk.text.isEmpty ||
                                  _accountSize.text.isEmpty
                              ? _validate = true
                              : _validate = false;
                        });
                        calculate();
                      },
                      child: Text("Calculate"),
                    ),
                  ],
                ))));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
