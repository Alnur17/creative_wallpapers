import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constant/color_palate.dart';

Widget buildShimmerPlaceholder() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: matteBlack,
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
    child: Padding(
      padding: const EdgeInsets.only(left: 12,right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            flex: 3, // Set a fixed height for the GridView
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
                    borderRadius: BorderRadius.circular(30),
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
    ),
  );
}
