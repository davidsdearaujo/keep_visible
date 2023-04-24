import 'package:flutter/material.dart';
import 'package:keep_visible/keep_visible.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 400,
              color: Colors.yellow,
              alignment: Alignment.center,
              child: const Text('HEADER'),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'email',
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'password',
                        ),
                      ),
                    ],
                  ),
                ),
                KeepVisible(
                  child: Container(
                    height: 100,
                    margin: const EdgeInsets.only(top: 24),
                    color: Colors.blue,
                    alignment: Alignment.center,
                    child: const Text('FOOTER'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
