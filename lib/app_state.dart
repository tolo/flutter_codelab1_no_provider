import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';


/// InheritedWidget class that provides the [MyAppState] to its descendants, and rebuilds them when the [MyAppState] changes.
class MyAppStateProvider extends InheritedNotifier {
  const MyAppStateProvider({
    Key? key,
    required this.appState,
    required Widget child,
  }) : super(key: key, notifier: appState, child: child);

  final MyAppState appState;

  @override
  bool updateShouldNotify(MyAppStateProvider old) => appState != old.appState;
}


class MyAppState extends ChangeNotifier {
  
  static MyAppState of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyAppStateProvider>()!.appState;
  }

  var current = WordPair.random();
  var history = <WordPair>[];

  GlobalKey? historyListKey;

  void getNext() {
    history.insert(0, current);
    var animatedList = historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[];

  void toggleFavorite([WordPair? pair]) {
    pair = pair ?? current;
    if (favorites.contains(pair)) {
      favorites.remove(pair);
    } else {
      favorites.add(pair);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }
}
