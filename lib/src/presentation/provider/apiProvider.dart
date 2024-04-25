import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userListProvider = StateNotifierProvider<UserListProvider, List<dynamic>>(
  (ref) => UserListProvider(),
);

class UserListProvider extends StateNotifier<List<dynamic>> {
  UserListProvider() : super([]);

  Future<void> fetchUsers() async {
    const url = 'https://randomuser.me/api/?results=20';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    state = json['results'];
  }
}
