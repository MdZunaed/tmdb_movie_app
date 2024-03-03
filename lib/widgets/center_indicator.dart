import 'package:flutter/cupertino.dart';

import '../utility/app_colors.dart';

class CenterIndicator extends StatelessWidget {
  const CenterIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CupertinoActivityIndicator(color: primaryColor));
  }
}
