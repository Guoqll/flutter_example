import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_state.dart';

class HomePage extends ConsumerStatefulWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Const 保持静态部分'),
            _getCounterWidget(ref),
            _getIndexWidget(ref),
            ElevatedButton(
              onPressed: () {
                ref.read(homeViewModelProvider.notifier).simulateLoading();
              },
              child: const Text('触发加载状态'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ref.read(homeViewModelProvider.notifier).incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _getCounterWidget(WidgetRef ref) {
    return Consumer(builder: (context, ref, _) {
      final counter = ref.watch(homeViewModelProvider.select((state) => state.counter));
      print('显示的计数器----build');
      return Text('显示的计数器: $counter');
    });
  }

  _getIndexWidget(WidgetRef ref) {
    return Consumer(builder: (context, ref, _) {
      final selectedTab = ref.watch(homeViewModelProvider.select((state) => state.selectedTab));
      print('显示的index----build');
      return Text('index: $selectedTab');
    });
  }
}
