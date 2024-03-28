import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constant/color_palate.dart';

Widget buildShimmerPlaceholder() {
  return Shimmer.fromColors(
    baseColor: matteBlack,
    highlightColor: Colors.blueGrey,
    child: Container(
      color: Colors.white,
    ),
  );
}
