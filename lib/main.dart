import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proxy_test/user.dart';
import 'package:dio_proxy_adapter/dio_proxy_adapter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Proxyman Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<User> _users = [];
  late final Dio _dio;

  @override
  void initState() {
    super.initState();

    String proxy = Platform.isAndroid ? '10.0.2.2:9090' : 'localhost:9090';
    _dio = Dio()
      ..options.baseUrl = 'https://api.github.com/'
      ..useProxy(proxy);
  }

  Future<void> _fetchUser() async {
    try {
      final response = await _dio.get('/users/octocat');
      final user = User.fromJson(response.data);
      setState(() {
        _users.add(user);
      });
    } catch (e) {
      // do nothing
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _users.isEmpty
          ? const SizedBox.shrink()
          : ListView.builder(
              itemBuilder: (_, index) {
                final user = _users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatarUrl),
                  ),
                  title: Text(user.name),
                );
              },
              itemCount: _users.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchUser,
        child: const Icon(Icons.add),
      ),
    );
  }
}
