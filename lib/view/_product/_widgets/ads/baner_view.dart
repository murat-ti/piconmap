import '../../../../core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerView extends StatelessWidget {
  final BannerAd? anchoredBanner;

  const BannerView({Key? key, this.anchoredBanner}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(color: context.colorScheme.primary.withOpacity(0.3), blurRadius: 10.0, offset: Offset(0.75, 0.75))
        ],
        color: Colors.white,
      ),
      height: 60,
      width: context.width,
      padding: context.horizontalPaddingNormal,
      child: (anchoredBanner != null)
          ? Container(
              color: Colors.white,
              width: anchoredBanner!.size.width.toDouble(),
              height: anchoredBanner!.size.height.toDouble(),
              child: AdWidget(ad: anchoredBanner!),
            )
          : SizedBox(),
    );
  }
}
