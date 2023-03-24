import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vird_tv/helpers/debouncer.dart';
import 'package:vird_tv/models/models.dart';
import 'package:vird_tv/models/search_response.dart';



class MoviesProvider extends ChangeNotifier{

  String _apiKey    = 'fb0a8ce77f7b137669349d36932d45f4';
  String _baseUrl   = 'api.themoviedb.org';
  String _language  = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};

  int _popularPage = 0;


  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
    );


  final StreamController<List<Movie>> _suggestionStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => _suggestionStreamController.stream;


  MoviesProvider(){
    getOnDisplayMovies();
    getOnPopularMovies();

    //_suggestionStreamController.close();
  }

  Future<String> _getJsonData( String endpoint, [int page = 1]) async{
    var url = Uri.https(_baseUrl, endpoint, {
      'api_key':_apiKey,
      'languaje':_language,
      'page': '$page',
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

    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular', 1);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [ ...popularMovies, ...popularResponse.results ];
    notifyListeners();
  }


  Future<List<Cast>> getMoviesCast(int movieId) async{
    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    final jsonData = await _getJsonData('3/movie/$movieId/credits');

    // no response, ??
    final creditsResponse = CreditsResponse.fromJson( jsonData );

    moviesCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;

  }

  Future<List<Movie>> searchMovies( String query ) async{

    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key':_apiKey,
      'languaje':_language,
      'query' : query,
    });

    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;

  }
  
  void getSuggestionsByQuery( String searchTerm ) {
    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      //print('Tenemos valor a buscar: $value');
      final result = await searchMovies(value);
      _suggestionStreamController.add(result);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), ( _ ) {
      debouncer.value = searchTerm;
     });

     Future.delayed(Duration(milliseconds: 301)).then(( _ ) => timer.cancel());


  }

}