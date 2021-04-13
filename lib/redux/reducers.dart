import 'package:flutter_redux_app/redux/actions.dart';

int counterReducer(int count,dynamic action){
  if(action is AddAction){
    return _add(count);
  } else if (action is RemoveAction){
    return _remove(count);
  }
}

int _remove(int count) {
  int newCount = count-1;
  return newCount;
}

int _add(int count) {
  int newCount = count+1;
  return newCount;
}