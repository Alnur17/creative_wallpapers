import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constant/color_palate.dart';

Widget buildShimmerPlaceholder() {
  return Shimmer.fromColors(
    baseColor: matteBlack,
    highlightColor: Colors.deepOrangeAccent[700]!,
    direction: ShimmerDirection.ltr,
    child: Container(
      color: Colors.white,
    ),
  );
}

Widget buildShimmerEffect() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Container(
          height: 200,
          width: double.infinity,
          color: Colors.white,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 500, // Set a fixed height for the GridView
          child: GridView.builder(
            primary: false,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: 6, // Placeholder count
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    color: Colors.grey[300],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

