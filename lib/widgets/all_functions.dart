import 'dart:typed_data';
import 'package:creative_wallpapers/constant/color_palate.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import '../constant/style.dart';


void saveImageToDevice(BuildContext context, String imageUrl) async {
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    scaffoldMessenger.showSnackBar(
      const SnackBar(
        content: Text(
          'Saving image...',
          style: styleWB20,
        ),
      ),
    );

    try {
      // Fetch image data from the URL
      var response = await Dio()
          .get(imageUrl, options: Options(responseType: ResponseType.bytes));

      if (response.statusCode == 200) {
        // Image downloaded successfully
        final result = await ImageGallerySaver.saveImage(
          Uint8List.fromList(response.data),
          quality: 60,
        );

        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text(
              'Image saved successfully.',
              style: styleWB20,
            ),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        // If the image couldn't be downloaded (e.g., server error)
        scaffoldMessenger.showSnackBar(
          const SnackBar(
            content: Text(
              'Failed to download image. Please try again later.',
              style: styleWB20,
            ),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      // Error occurred during the process
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Failed to save image. Please check your internet connection.',
            style: styleWB20,
          ),
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

