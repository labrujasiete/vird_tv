import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vird_tv/providers/movies_provider.dart';
import 'package:vird_tv/widgets/widgets.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);

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
        body: SingleChildScrollView(
          child: Column(
            children: [
              CardSwiper( movies: moviesProvider.onDisplayMovies ),
              MovieSlider(),
            ],
          ),
        ),
    );
  }
}