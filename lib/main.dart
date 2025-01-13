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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
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
    var pair = appState.current;

    // トップレベルのwidgetがscaffold
    return Scaffold(
      // columnは任意の数のchildrenを持ち、上から下に配置する
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BigCard(pair: pair),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                appState.getNext();
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    // 現在のcontextのテーマを取得
    final theme = Theme.of(context);

    // displayは見出しの意味
    // copyWith()で、引数での指定のみ変更されたテキストスタイルを表現するオブジェクトのコピーが返る
    final style = theme.textTheme.displayMedium!.copyWith(
      // primary colorの上に適した色
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      // テーマのプライマリカラーを背景色に設定
      color: theme.colorScheme.primary,
      // 浮き上がり = 影の深さ
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          // screen readerに読み上げ対象として渡されるラベル
          semanticsLabel: '${pair.first} ${pair.second}',
        ),
      ),
    );
  }
}
