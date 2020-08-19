import 'dart:convert';

import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider{
  String _apikey   =  'd8a3fcbe032fa9fe769d40e4469a7dac';
  String _url      =  'api.themoviedb.org';
  String _language =  'es-CO';

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);
    return peliculas.items;  
  }

  Future<List<Pelicula>> getEnCines() async{
    final url = Uri.https(_url, '3/movie/now_playing',{
      'api_key' : _apikey,
      'language': _language,
    });
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopular() async{
    final url = Uri.https(_url, '3/movie/popular',{
      'api_key' : _apikey,
      'language': _language,
    });
    return await _procesarRespuesta(url);
  }
  
}

