import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class SaveToDevice {
  static void saveImage(BuildContext context, String imageUrl) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);  //ScaffoldMessenger.of(context) will always return a non-null value
    scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text('Saving image...',
          style: TextStyle(fontSize: 18),),
      ),
    );

    try {
      var response = await Dio()
          .get(imageUrl, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: 'image');
      print(result);
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Image saved successfully.',
            style: TextStyle(fontSize: 18),),
          duration: Duration(seconds: 1),
        ),
      );
    } catch (e) {
      print('Error saving image: $e');
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Failed to save image.',
            style: TextStyle(fontSize: 18),),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }
}



/*
class SaveToDevice {
  static void saveImage(BuildContext context, String imageUrl) async {
    if (mounted(context)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Saving image...'),
        ),
      );
    }
    try {
      var response = await Dio()
          .get(imageUrl, options: Options(responseType: ResponseType.bytes));
      final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
          name: 'image');
      print(result);
      if (mounted(context)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image saved successfully.'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      print('Error saving image: $e');
      if (mounted(context)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save image.'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }

  static bool mounted(BuildContext context) {
    return context != null && Navigator.canPop(context);
  }
}
*/
