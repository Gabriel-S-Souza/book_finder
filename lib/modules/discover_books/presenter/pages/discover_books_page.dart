import 'package:flutter/material.dart';

class DiscoverBooksPage extends StatelessWidget {
  const DiscoverBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discover Books'),
      ),
      body: const Center(
        child: Text('Discover Books'),
      ),
    );
  }
}
