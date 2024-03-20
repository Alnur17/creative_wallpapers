import 'package:creative_wallpapers/model_class/trending_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model_class/image_model.dart';

class ImagesProvider with ChangeNotifier {


  List<UnsplashImage> _images = [];
  List<TrendingImage> _trendImage = [];
  List<TrendingImage> _collectionImage = [];


  bool _isLoadingAll = false;
  bool _isLoadingTrending = false;
  bool _isLoadingCollection = false;
  bool _hasMoreDataAll = true;
  bool _hasMoreDataTrending = true;
  bool _hasMoreDataCollection = true;
  String _errorMessage = '';
  int _currentPage = 1; // Track current page number
  final int _perPage = 30;

  List<UnsplashImage> get images => _images;
  List<TrendingImage> get trendImage => _trendImage;
  List<TrendingImage> get collectionImage => _collectionImage;

  bool get isLoading => _isLoadingAll;
  bool get isLoadingTrending => _isLoadingTrending;
  bool get isLoadingCollection => _isLoadingCollection;

  bool get hasError => _errorMessage.isNotEmpty;

  String get errorMessage => _errorMessage;

  bool get hasMoreDataAll => _hasMoreDataAll;
  bool get hasMoreDataCollection => _hasMoreDataCollection;
  bool get hasMoreDataTrending => _hasMoreDataTrending;


  void toggleFavorite(int index) {
    _images[index].isFavorite = !_images[index].isFavorite;
    notifyListeners();
  }

  void toggleFavoriteTrending(int index) {
    _trendImage[index].isFavorite = !_trendImage[index].isFavorite;
    notifyListeners();
  }

  void toggleFavoriteCollections(int index) {
    _collectionImage[index].isFavorite = !_collectionImage[index].isFavorite;
    notifyListeners();
  }

  Future<void> fetchImages() async {
    if (_isLoadingAll || !_hasMoreDataAll) return; // Do not fetch if already fetching or no more data
    _isLoadingAll = true;
    // notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://api.unsplash.com/photos/?client_id=RXHGOr2roQzdKvBe4ddPQdAdrO3vw2Qy2K8pIiB9OZw&page=$_currentPage&per_page=$_perPage'));

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
          _hasMoreDataAll = false; // No more data available
        }

        _currentPage++;
        _errorMessage = ''; // Reset error message
      } else {
        _errorMessage = 'Failed to load images';
      }
    } catch (error) {
      _errorMessage = 'Error: $error';
    } finally {
      _isLoadingAll = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreImages() async {
    await fetchImages();
  }

  Future<void> fetchTrendingImages(String query) async {
    //print("fetchTrendingImages");
    if (_isLoadingTrending || !_hasMoreDataTrending) return; // Do not fetch if already fetching or no more data
    _isLoadingTrending = true;
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
       // print("_trendImage - ${_trendImage.length}");

        if (data.length < _perPage) {
          _hasMoreDataTrending = false; // No more data available
        }

        _currentPage++;
        notifyListeners();
        _errorMessage = ''; // Reset error message
      } else {
        _errorMessage = 'Failed to load images';
      }
    } catch (error) {
      _errorMessage = 'Error: $error';
    } finally {
      _isLoadingTrending = false;
      notifyListeners();
    }
  }
  Future<void> fetchCollectionImages(String query) async {
    //print("fetchCollectionImages");
    if (_isLoadingCollection || !_hasMoreDataCollection) return; // Do not fetch if already fetching or no more data
    _isLoadingCollection = true;
    notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://api.unsplash.com/search/photos?query=${query}&client_id=RXHGOr2roQzdKvBe4ddPQdAdrO3vw2Qy2K8pIiB9OZw&page=$_currentPage&per_page=$_perPage'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)["results"];
        List<TrendingImage> newImage =
        data.map((json) => TrendingImage.fromJson(json)).toList();

        if (_currentPage == 1) {
          _collectionImage = newImage;
        } else {
          _collectionImage.addAll(newImage);
        }

        //print("_collectionImage - ${_collectionImage.length}");

        if (data.length < _perPage) {
          _hasMoreDataCollection = false; // No more data available
        }

        _currentPage++;
        _errorMessage = ''; // Reset error message
      } else {
        _errorMessage = 'Failed to load images';
      }
    } catch (error) {
      _errorMessage = 'Error: $error';
    } finally {
      _isLoadingCollection = false;
      notifyListeners();
    }
  }
  // Future<void> loadMoreImage() async {
  //   await fetchSearchedImages('peacock');
  // }

  // Future<void> loadsMoreImage() async {
  //   await fetchSearchedImages('bird');
  // }




}