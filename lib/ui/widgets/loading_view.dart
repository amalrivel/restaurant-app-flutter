import 'package:flutter/material.dart';

class LoadingView extends StatelessWidget {
  final String title;
  const LoadingView({super.key, this.title = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
