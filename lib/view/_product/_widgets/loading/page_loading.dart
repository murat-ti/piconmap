import 'package:flutter/material.dart';
import '../../../../core/extension/context_extension.dart';

class PageLoading extends StatelessWidget {
  const PageLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(context.colorScheme.secondaryVariant),
      ),
    );
  }
}
