import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whisky_hunter/src/comp/appbar/tm_app_bar.dart';
import 'package:whisky_hunter/src/constant/tm_icon.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';

class AuctionDataSlug extends StatefulWidget {
  final String dt;
  final String auctionName;
  final String auctionSlug;
  final int auctionLotsCount;
  final int allAuctionsLotsCount;
  final int winningBidMax;
  final int winningBidMin;
  final int auctionTradingVolume;

  const AuctionDataSlug({
    Key? key,
    required this.dt,
    required this.auctionName,
    required this.auctionSlug,
    required this.auctionLotsCount,
    required this.allAuctionsLotsCount,
    required this.winningBidMax,
    required this.winningBidMin,
    required this.auctionTradingVolume,
  }) : super(key: key);

  @override
  State<AuctionDataSlug> createState() => _AuctionDataSlugState();
}

class _AuctionDataSlugState extends State<AuctionDataSlug> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar('${(tr('info'))} ${widget.auctionName}'),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      TMIcons.whisky1,
                      fit: BoxFit.fill,
                    ),
                  )),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            tr('info'),
                            style: TMThemeData.fromContext(context)
                                .textDataAuctionBlack,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Icon(CupertinoIcons.info),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(tr('auction_name') + widget.auctionName,
                          style: TMThemeData.fromContext(context)
                              .textNameWhiskyBlack),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        tr('auction_slug') + (widget.auctionSlug),
                        style: TMThemeData.fromContext(context)
                            .textDataAuctionBlack,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        tr('dt') + widget.dt,
                        style: TMThemeData.fromContext(context)
                            .textDataAuctionBlack,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        tr('auction_lots_count') +
                            widget.auctionLotsCount.toString(),
                        style: TMThemeData.fromContext(context)
                            .textDataAuctionBlack,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        tr('all_auctions_lots_count') +
                            widget.allAuctionsLotsCount.toString(),
                        style: TMThemeData.fromContext(context)
                            .textDataAuctionBlack,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        tr('winning_bid_max') + widget.winningBidMax.toString(),
                        style: TMThemeData.fromContext(context)
                            .textDataAuctionBlack,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        tr('winning_bid_min') + widget.winningBidMin.toString(),
                        style: TMThemeData.fromContext(context)
                            .textDataAuctionBlack,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        tr('auction_trading_volume') +
                            widget.auctionTradingVolume.toString(),
                        style: TMThemeData.fromContext(context)
                            .textDataAuctionBlack,
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// todo format string to date
// formatStringToDate(String dateString) {
//   final DateTime dateFormat = DateFormat('yyyy-MM-dd').parse(dateString);
//   final String date = dateFormat.toString();
//   return date;
// }
