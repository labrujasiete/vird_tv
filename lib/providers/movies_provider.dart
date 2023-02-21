import 'package:flutter/material.dart';




class MoviesProvider extends ChangeNotifier{
  MoviesProvider(){
    print('Movies Provider Inicializado');
    getOnDisplayMovies();
  }
}


getOnDisplayMovies()async{
  print('getOnDisplayMovies');
}