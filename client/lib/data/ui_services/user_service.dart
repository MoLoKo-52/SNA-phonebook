import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/domain/src/phonebook.pb.dart';

final userProvider = ChangeNotifierProvider((ref) => UserNotifier());
/// UserNotifier for storing user data
class UserNotifier extends ChangeNotifier {
  String name = "";
  String phone = "";
  bool isExist = false;
  String signature = "";
  bool isVerified = false;

  void addUser(NumberResponse response) {
    name = response.name;
    phone = response.number;
    isExist = response.found;
    signature = response.signature;
    notifyListeners();
  }

  void clear() {
    name = "";
    phone = "";
    isExist = false;
    signature = "";
    notifyListeners();
  }

  void verify(bool state) {
    isVerified = state;
    notifyListeners();
  }
}
