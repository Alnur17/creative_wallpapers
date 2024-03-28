import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../constant/color_palate.dart';

Widget buildShimmerPlaceholder() {
  return Shimmer.fromColors(
    baseColor: matteBlack,
    highlightColor: Colors.blueGrey[900]!,direction: ShimmerDirection.ttb,
    child: Container(
      color: Colors.white,
    ),
  );
}
