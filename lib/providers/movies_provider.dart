import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vird_tv/models/models.dart';



class MoviesProvider extends ChangeNotifier{

  String _apiKey    = 'fb0a8ce77f7b137669349d36932d45f4';
  String _baseUrl   = 'api.themoviedb.org';
  String _language  = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider(){
    getOnDisplayMovies();
    getOnPopularMovies();
  }

  Future<String> _getJsonData( String endpoint) async{
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key':_apiKey,
      'languaje':_language,
      'page': '1',
      });

    final response = await http.get(url);
    return response.body;
  }



  getOnDisplayMovies()async{
    
    var url = Uri.https(_baseUrl, '3/movie/now_playing', {
      'api_key':_apiKey,
      'languaje':_language,
      'page': '1',
      });

    final response = await http.get(url);
    //final nowPlayingResponse = NowPlayingResponse.fromJson(jsonDecode(response.body));
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    //final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    //final Map<String, String> decodedData = json.decode(response.body);

    //print(nowPlayingResponse.results[4].title);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();

  }


  getOnPopularMovies()async{
    var url = Uri.https(_baseUrl, '3/movie/popular', {
      'api_key':_apiKey,
      'languaje':_language,
      'page': '1',
      });

    final response = await http.get(url);
    final popularResponse = PopularResponse.fromJson(response.body);

    popularMovies = [ ...popularMovies, ...popularResponse.results ];
    notifyListeners();
  }

}