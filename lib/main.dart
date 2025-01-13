import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

// ウィジェットは、すべての Flutter アプリを作成する際の元になる要素です。ご覧のように、このアプリ自体がウィジェットです。
// StatelessWidget, StatefulWidget がある
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Flutter には、アプリの状態を管理する強力な方法が多数あります。特に説明しやすいのが、このアプリで採用している ChangeNotifier を使用する方法です。
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  // widgetは必ずbuildメソッドをもつ。widget or widgetのネストしたツリーを返す
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    // トップレベルのwidgetがscaffold
    return Scaffold(
      // columnは任意の数のchildrenを持ち、上から下に配置する
      body: Column(
        children: [
          Text('A random idea: hoge'),
          Text(appState.current.asLowerCase),
          ElevatedButton(
            onPressed: () {
              appState.getNext();
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
