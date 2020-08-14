import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providertext/provider/counter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => Counter(),
          ),
        ],
        child: Consumer<Counter>(builder: (context, counter, _) {
          return MaterialApp(home: MyHomePage());
        }));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: CounterLabel()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => TileAdd())),
        ));
  }
}

class TileAdd extends StatelessWidget {
  const TileAdd({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    final TextEditingController textEditingController = TextEditingController();
    return Scaffold(
        body: Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
          TextField(
            controller: textEditingController,
          ),
          FlatButton(
            child: Icon(Icons.subdirectory_arrow_left),
            onPressed: () {
              print(textEditingController.text);
              counter.insertList(ListTile(
                title: Text(textEditingController.text),
              ));
              Navigator.pop(context);
            },
          )
        ])));
  }
}

/// IncrementCounterFab
///
/// Fab이 눌리면 [Counter] Provider의 increment를 호출한다.
///
///
int i = 0;

class IncrementCounterFab extends StatelessWidget {
  const IncrementCounterFab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    return FloatingActionButton(
      onPressed: () {
        i++;
        counter.increment();
        counter.insertList(ListTile(title: Text(i.toString())));
      },
      child: Icon(Icons.add),
    );
  }
}

/// CounterLabel
///
/// build 메소드 안에서 리스너가 변경을 수신하면 count 정보를 변경한다.
class CounterLabel extends StatelessWidget {
  const CounterLabel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    return ListView.builder(
      itemCount: counter.listTiles.length,
      itemBuilder: (BuildContext context, int index) {
        if (counter.listTiles == null) {
          print("No list tiles, index: ");
          print(index.toString());
        } else {
          return counter.listTiles[index];
        }
      },
    );
  }
}
