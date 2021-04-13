import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_app/redux/actions.dart';
import 'package:flutter_redux_app/redux/reducers.dart';
import 'package:redux/redux.dart';

void main() {
  final Store<int> store = Store(counterReducer, initialState: 1);
  runApp(StoreProvider(
    store: store,
    child: MaterialApp(
      home: Scaffold(
        body: SafeArea(child: _Counter()),
      ),
    ),
  ));
}

class _Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StoreConnector<int, int>(
              converter: (store) => store.state,
              builder: (context, state) => Text(
                state.toString(),
                style: TextStyle(fontSize: 48),
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StoreConnector<int, OnRemoveCallback>(
                  converter: (store) =>
                      (count) => store.dispatch(RemoveAction()),
                  builder: (context, callback) => FloatingActionButton(
                    onPressed: () =>
                        callback(StoreProvider.of<int>(context).state),
                    child: Icon(Icons.remove),
                  ),
                ),
                SizedBox(width: 16),
                StoreConnector<int, OnAddCallback>(
                  converter: (store) => (count) => store.dispatch(AddAction()),
                  builder: (context, callback) => FloatingActionButton(
                    onPressed: () =>
                        callback(StoreProvider.of<int>(context).state),
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

typedef OnAddCallback = Function(int count);
typedef OnRemoveCallback = Function(int count);
