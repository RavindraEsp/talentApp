import 'package:flutter/material.dart';

class CustomCircularLoaderWidget extends StatelessWidget {
  const CustomCircularLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
      ),
    );
  }
}
