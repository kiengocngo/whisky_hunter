import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:whisky_hunter/src/data/model/model.dart';
import 'package:whisky_hunter/theme/tm_colors.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';

class AuctionInfoListItem extends StatelessWidget {
  final AuctionInformations auctionInfo;
  const AuctionInfoListItem({Key? key, required this.auctionInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: TMColors.gradient,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                auctionInfo.name,
                style: TMThemeData.fromContext(context).textNameWhisky,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                auctionInfo.slug,
                style: TMThemeData.fromContext(context).textNameWhisky,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                '${tr("buyers_fee")}: ${auctionInfo.buyersFee.round()} ${auctionInfo.baseCurrency}',
                style: TMThemeData.fromContext(context).textDataAuctionBlack,
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                '${tr("sellers_fee")}: ${auctionInfo.sellersFee.round()} ${auctionInfo.baseCurrency}',
                style: TMThemeData.fromContext(context).textDataAuctionBlack,
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                '${tr("listing_fee")}: ${auctionInfo.listingFee.round()} ${auctionInfo.baseCurrency}',
                style: TMThemeData.fromContext(context).textDataAuctionBlack,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
