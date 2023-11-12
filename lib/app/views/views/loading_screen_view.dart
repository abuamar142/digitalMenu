import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingScreenView extends GetView {
  const LoadingScreenView({
    super.key,
    this.dataError,
  });

  final List<Object>? dataError;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
