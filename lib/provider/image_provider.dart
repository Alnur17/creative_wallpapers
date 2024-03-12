import 'package:creative_wallpapers/model_class/trending_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model_class/image_model.dart';

class ImagesProvider with ChangeNotifier {


  List<UnsplashImage> _images = [];
  List<TrendingImage> _trendImage = [];


  bool _isLoading = false;
  bool _hasMoreData = true;
  String _errorMessage = '';
  int _currentPage = 1; // Track current page number
  final int _perPage = 30;

  List<UnsplashImage> get images => _images;
  List<TrendingImage> get trendImage => _trendImage;

  bool get isLoading => _isLoading;

  bool get hasError => _errorMessage.isNotEmpty;

  String get errorMessage => _errorMessage;

  bool get hasMoreData => _hasMoreData;


  void toggleFavorite(int index) {
    _images[index].isFavorite = !_images[index].isFavorite;
    notifyListeners();
  }


  Future<void> fetchImages() async {
    if (_isLoading || !_hasMoreData) return; // Do not fetch if already fetching or no more data
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://api.unsplash.com/photos?client_id=RXHGOr2roQzdKvBe4ddPQdAdrO3vw2Qy2K8pIiB9OZw&page=$_currentPage&per_page=$_perPage'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<UnsplashImage> newImages =
        data.map((json) => UnsplashImage.fromJson(json)).toList();

        if (_currentPage == 1) {
          _images = newImages;
        } else {
          _images.addAll(newImages);
        }

        if (data.length < _perPage) {
          _hasMoreData = false; // No more data available
        }

        _currentPage++;
        _errorMessage = ''; // Reset error message
      } else {
        _errorMessage = 'Failed to load images';
      }
    } catch (error) {
      _errorMessage = 'Error: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreImages() async {
    await fetchImages();
  }

  Future<void> fetchSearchedImages(String query) async {
    if (_isLoading || !_hasMoreData) return; // Do not fetch if already fetching or no more data
    _isLoading = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://api.unsplash.com/search/photos?query=${query}&client_id=RXHGOr2roQzdKvBe4ddPQdAdrO3vw2Qy2K8pIiB9OZw&page=$_currentPage&per_page=$_perPage'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)["results"];
        List<TrendingImage> newImage =
        data.map((json) => TrendingImage.fromJson(json)).toList();

        if (_currentPage == 1) {
          _trendImage = newImage;
        } else {
          _trendImage.addAll(newImage);
        }

        if (data.length < _perPage) {
          _hasMoreData = false; // No more data available
        }

        _currentPage++;
        _errorMessage = ''; // Reset error message
      } else {
        _errorMessage = 'Failed to load images';
      }
    } catch (error) {
      _errorMessage = 'Error: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  Future<void> loadMoreImage() async {
    await fetchSearchedImages('bird');
  }

}