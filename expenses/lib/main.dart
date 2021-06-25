import 'dart:math';
import 'dart:io'; //para ver a plataforma
import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './models/transaction.dart';
import './components/transaction_form.dart';
import './components/transaction_list.dart';

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber, //cor de destaque
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                    fontFamily: "OpenSans",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  button: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ) //light é o tema padrão
            ),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [Locale('pt', 'BR')],
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePage createState() {
    return _MyHomePage();
  }
}

class _MyHomePage extends State<MyHomePage> with WidgetsBindingObserver {
  final _transactions = <Transaction>[];
  bool _showChart = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  List<Transaction> get _recentTransactions {
    DateTime semanaPassada = DateTime.now().subtract(Duration(days: 7));
    final List<Transaction> weekTransactions = _transactions
        .where((transaction) =>
            transaction.date.isAfter(semanaPassada)) //filter no js
        .toList();
    return weekTransactions;
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });
    Navigator.of(context).pop();
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  _openTransactionModal(
    BuildContext context,
  ) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Container(
        height: 300,
        child: TransactionForm(_addTransaction),
      ),
    );
  }

  Widget _getPlatformButton(IconData icon, Function callback) {
    return Platform.isIOS
        ? GestureDetector(
            onTap: callback,
            child: Icon(icon),
          )
        : IconButton(icon: Icon(icon), onPressed: callback);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaquery = MediaQuery.of(context);
    final bool isDesktopApp =
        Platform.isLinux || Platform.isWindows || Platform.isMacOS;
    bool isLandscape =
        mediaquery.orientation == Orientation.landscape && !isDesktopApp;

    final iconList = Platform.isIOS ? CupertinoIcons.list_bullet : Icons.list;
    final iconChart =
        Platform.isIOS ? CupertinoIcons.chart_bar_alt_fill : Icons.bar_chart;

    final actions = <Widget>[
      if (isLandscape)
        _getPlatformButton(
            _showChart ? iconList : iconChart,
            () => setState(() {
                  _showChart = !_showChart;
                })),
      _getPlatformButton(Platform.isIOS ? CupertinoIcons.add : Icons.add,
          () => _openTransactionModal(context))
    ];

    final PreferredSizeWidget appbar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Despesas Pessoais',
                style: TextStyle(
                  fontSize: Theme.of(context)
                          .appBarTheme
                          .textTheme
                          .headline6
                          .fontSize *
                      mediaquery.textScaleFactor,
                )),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: actions,
            ),
          )
        : AppBar(
            title: Text(
              'Despesas Pessoais',
              style: TextStyle(
                fontSize:
                    Theme.of(context).appBarTheme.textTheme.headline6.fontSize *
                        mediaquery.textScaleFactor,
              ),
              // style: TextStyle(fontFamily: "OpenSans"),
            ),
            actions: actions);

    final double availableHight = mediaquery.size.height -
        appbar.preferredSize.height -
        mediaquery.padding.top;

    final bodyPage = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (_showChart || !isLandscape)
              Container(
                height: availableHight * (isLandscape ? 0.75 : 0.3),
                child: Chart(_recentTransactions),
              ),
            if (!_showChart || !isLandscape)
              Container(
                height: availableHight * (isLandscape ? 1 : 0.7),
                child: TransactionList(_transactions, _deleteTransaction),
              ),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appbar,
            child: bodyPage,
          )
        : Scaffold(
            appBar: appbar,
            body: bodyPage,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _openTransactionModal(context),
            ),
            floatingActionButtonLocation: !Platform.isIOS
                ? FloatingActionButtonLocation.centerFloat
                : Container(),
          );
  }
}

main(List<String> args) {
  runApp(ExpensesApp());
}
