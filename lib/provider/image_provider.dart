import 'package:creative_wallpapers/model_class/collection_image.dart';
import 'package:creative_wallpapers/model_class/image_model.dart';
import 'package:creative_wallpapers/model_class/trending_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImagesProvider with ChangeNotifier {
  List<ImageModel> _images = [];
  List<TrendingImage> _trendImage = [];
  List<CollectionImage> _collectionImage = [];
  List<TrendingImage> _searchImage = [];

  bool _isLoadingAll = false;
  bool _isLoadingTrending = false;
  bool _isLoadingCollection = false;
  bool _isLoadingSearch = false;
  bool _hasMoreDataAll = true;
  bool _hasMoreDataTrending = true;
  bool _hasMoreDataCollection = true;
  bool _hasMoreDataSearch = true;
  String _errorMessage = '';
  int _currentPage = 1; // Track current page number
  final int _perPage = 30;

  List<ImageModel> get images => _images;

  List<TrendingImage> get trendImage => _trendImage;

  List<CollectionImage> get collectionImage => _collectionImage;

  List<TrendingImage> get searchImage => _searchImage;

  bool get isLoading => _isLoadingAll;

  bool get isLoadingTrending => _isLoadingTrending;

  bool get isLoadingCollection => _isLoadingCollection;

  bool get isLoadingSearch => _isLoadingSearch;

  bool get hasError => _errorMessage.isNotEmpty;

  String get errorMessage => _errorMessage;

  bool get hasMoreDataAll => _hasMoreDataAll;

  bool get hasMoreDataCollection => _hasMoreDataCollection;

  bool get hasMoreDataTrending => _hasMoreDataTrending;

  Future<void> fetchImages() async {
    if (_isLoadingAll || !_hasMoreDataAll) return;
    _isLoadingAll = true;
    // notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://api.unsplash.com/photos/?client_id=RXHGOr2roQzdKvBe4ddPQdAdrO3vw2Qy2K8pIiB9OZw&page=$_currentPage&per_page=$_perPage'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<ImageModel> newImages =
            data.map((json) => ImageModel.fromJson(json)).toList();

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
        print('else');
        _errorMessage = 'Failed to load images';
      }
    } catch (error) {
      _errorMessage = 'This is a catch error: $error';
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
    if (_isLoadingTrending || !_hasMoreDataTrending) {
      return; // Do not fetch if already fetching or no more data
    }
    _isLoadingTrending = true;
    //notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://api.unsplash.com/search/photos?query=$query&client_id=RXHGOr2roQzdKvBe4ddPQdAdrO3vw2Qy2K8pIiB9OZw&page=$_currentPage&per_page=$_perPage'));

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
    if (_isLoadingCollection || !_hasMoreDataCollection) return;
    _isLoadingCollection = true;
    //notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(
            'https://api.unsplash.com/search/collections?query=$query&client_id=RXHGOr2roQzdKvBe4ddPQdAdrO3vw2Qy2K8pIiB9OZw&page=$_currentPage&per_page=$_perPage'),
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['results'];
        List<CollectionImage> collectImage =
            data.map((json) => CollectionImage.fromJson(json)).toList();
        if (_currentPage == 1) {
          _collectionImage = collectImage;
        } else {
          _collectionImage.addAll(collectImage);
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
      // print('Catch');
      // print(error);
    } finally {
      _isLoadingCollection = false;
      notifyListeners();
    }
  }

  Future<void> fetchImagesByColor(String color) async {
    // _searchImage = [];
    // print("fetchImagesByColor");
    // if (_isLoadingSearch || !_hasMoreDataSearch) return;
     _isLoadingSearch = true;
     _searchImage.clear();
    // notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://api.unsplash.com/search/photos?query=$color&client_id=RXHGOr2roQzdKvBe4ddPQdAdrO3vw2Qy2K8pIiB9OZw&page=$_currentPage&per_page=$_perPage'));
      // print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)["results"];

        if (data.isNotEmpty) {
          // Only update if data is not empty
          List<TrendingImage> newImage =
              data.map((json) => TrendingImage.fromJson(json)).toList();

          if (_currentPage == 1) {
            _searchImage = newImage;
          } else {
            _searchImage.addAll(newImage);
          }
        }

        //print("_collectionImage - ${_collectionImage.length}");

        if (data.length < _perPage) {
          _hasMoreDataSearch = false; // No more data available
        }

        _currentPage++;
        _errorMessage = ''; // Reset error message
      } else {
        _errorMessage = 'Failed to load images';
      }
    } catch (error) {
      _errorMessage = 'Error: $error';
    } finally {
      _isLoadingSearch = false;
      notifyListeners();
    }
  }

/*  clearSearch() async {
    _searchImage.clear();
  }*/

  clearList() async {
    _collectionImage.clear();
  }
}
