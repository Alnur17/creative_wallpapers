import 'package:creative_wallpapers/model_class/collection_image.dart';
import 'package:creative_wallpapers/model_class/image_model.dart';
import 'package:creative_wallpapers/model_class/trending_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ImagesProvider with ChangeNotifier {

  final String _clientId = 'e8gVc5wKIVcSIihSoURU8f0t6vlbG_sNTAH-1Ypr08k';
  int _currentPage = 1; // Track current page number
  final int _perPage = 30;
  String _errorMessage = '';

  String get errorMessage => _errorMessage;

  bool get hasError => _errorMessage.isNotEmpty;

  // For ImageModel or Home image
  List<ImageModel> _images = [];

  List<ImageModel> get images => _images;
  bool _isLoadingAll = false;
  bool _hasMoreDataAll = true;

  bool get isLoading => _isLoadingAll;

  bool get hasMoreDataAll => _hasMoreDataAll;

  Future<void> fetchImages() async {
    if (_isLoadingAll || !_hasMoreDataAll) return;
    _isLoadingAll = true;
    // notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://api.unsplash.com/photos/?client_id=$_clientId&page=$_currentPage&per_page=$_perPage'));

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

  // Trending Images
  List<TrendingImage> _trendImage = [];
  bool _isLoadingTrending = false;
  bool _hasMoreDataTrending = true;

  List<TrendingImage> get trendImage => _trendImage;

  bool get isLoadingTrending => _isLoadingTrending;

  bool get hasMoreDataTrending => _hasMoreDataTrending;

  Future<void> fetchTrendingImages(String query) async {
    //print("fetchTrendingImages");
    if (_isLoadingTrending || !_hasMoreDataTrending) {
      return; // Do not fetch if already fetching or no more data
    }
    _isLoadingTrending = true;
    //notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://api.unsplash.com/search/photos?query=$query&client_id=$_clientId&page=$_currentPage&per_page=$_perPage'));

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

// For Collection Images
  List<CollectionImage> _collectionImage = [];
  bool _isLoadingCollection = false;
  bool _hasMoreDataCollection = true;

  List<CollectionImage> get collectionImage => _collectionImage;

  bool get isLoadingCollection => _isLoadingCollection;

  bool get hasMoreDataCollection => _hasMoreDataCollection;

  late String _currentCollectionName = '';

  String get currentCollectionName => _currentCollectionName;


  // Method to reset the current page to 1
   resetCurrentPage() async{
    _currentPage = 1;
    notifyListeners();
  }

  Future<void> fetchCollectionImages(String query) async {
    _currentCollectionName = query;
    _isLoadingCollection = true;
    //notifyListeners();

    try {
      final response = await http.get(
        Uri.parse(
            'https://api.unsplash.com/search/collections?query=$query&client_id=$_clientId&page=$_currentPage&per_page=$_perPage'),
      );
      print('this is response');
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)['results'];
        List<CollectionImage> collectImage =
            data.map((json) => CollectionImage.fromJson(json)).toList();
        print(collectImage);

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
        print('this is else');
        _errorMessage = 'Failed to load images';
      }
    } catch (error) {
      _errorMessage = 'Error: $error';
      print('this is Catch');
      print('$error');
    } finally {
      _isLoadingCollection = false;
      notifyListeners();
    }
  }

  //For Trending Image Search
  List<TrendingImage> _searchImage = [];

  bool _isLoadingSearch = false;

  bool _hasMoreDataSearch = true;

  List<TrendingImage> get searchImage => _searchImage;

  bool get isLoadingSearch => _isLoadingSearch;

  Future<void> fetchImagesByColor(String color) async {
    // _searchImage = [];
    // print("fetchImagesByColor");
    //if (_isLoadingSearch || !_hasMoreDataSearch) return;

    _isLoadingSearch = true;
    _searchImage.clear();
    // notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://api.unsplash.com/search/photos?query=$color&client_id=$_clientId&page=$_currentPage&per_page=$_perPage'));
      // print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)["results"];

        List<TrendingImage> newImage =
            data.map((json) => TrendingImage.fromJson(json)).toList();

        if (_currentPage == 1) {
          _searchImage = newImage;
        } else {
          _searchImage.addAll(newImage);
        }

        //print("_collectionImage - ${_collectionImage.length}");

        if (data.length < _perPage) {
          _hasMoreDataSearch = false; // No more data available
        }

        _currentPage++;
        _errorMessage = ''; // Reset error message
      } else {
        print('elseC');
        _errorMessage = 'Failed to load images';
      }
    } catch (error) {
      print('catchC');
      _errorMessage = 'Error: $error';
    } finally {
      _isLoadingSearch = false;
      notifyListeners();
    }
  }

  Future<void> fetchImagesByColorWhenScroll(String color) async {
    // _searchImage = [];
    // print("fetchImagesByColor");
    //if (_isLoadingSearch || !_hasMoreDataSearch) return;
    _isLoadingSearch = true;

    //notifyListeners();

    try {
      final response = await http.get(Uri.parse(
          'https://api.unsplash.com/search/photos?query=$color&client_id=$_clientId&page=$_currentPage&per_page=$_perPage'));
      // print(response.statusCode);
      // print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body)["results"];

        List<TrendingImage> newImage =
            data.map((json) => TrendingImage.fromJson(json)).toList();

        if (_currentPage == 1) {
          _searchImage = newImage;
        } else {
          _searchImage.addAll(newImage);
        }

        //print("_collectionImage - ${_collectionImage.length}");

        if (data.length < _perPage) {
          _hasMoreDataSearch = false; // No more data available
        }

        _currentPage++;
        _errorMessage = ''; // Reset error message
      } else {
        print('elseS');
        _errorMessage = 'Failed to load images';
      }
    } catch (error) {
      print('catchS');
      _errorMessage = 'Error: $error';
    } finally {
      _isLoadingSearch = false;
      notifyListeners();
    }
  }

/*  clearSearch() async {
    _searchImage.clear();
  }*/

   clearList() async{
    _collectionImage.clear();
    //notifyListeners();
  }
}
