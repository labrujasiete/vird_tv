import 'package:flutter/material.dart';
import 'package:vird_tv/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.transparent,
          title: const Text('Vird TV'),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {}, 
              icon: const Icon(Icons.search_outlined)
              ),
          ],
        ),
        body: Column(
          children: const [
            CardSwiper()
          ],
        ),
    );
  }
}