import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';

class AuctionDataSlug extends StatefulWidget {
  final String dt;
  final String auctionName;
  final String auctionSlug;
  final int auctionLotsCount;
  final int allAuctionsLotsCount;
  final double winningBidMax;
  final double winningBidMin;
  final double auctionTradingVolume;

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
  int currentPage = 0;
  List listPage = [
    {"image": "lib/assets/images/whisky.jpeg"},
    {"image": "lib/assets/images/whiskey1.jpeg"},
    {"image": "lib/assets/images/whisky2.jpeg"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 8, bottom: 12),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(CupertinoIcons.back),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: PageView.builder(
                onPageChanged: (value) {
                  currentPage = value;
                },
                itemCount: listPage.length,
                itemBuilder: (context, index) => ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.asset(
                      listPage[index]['image'],
                      fit: BoxFit.fill,
                    )),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.auctionName,
                          style: TMThemeData.fromContext(context)
                              .textNameWhiskyBlack),
                      Text(
                        widget.auctionSlug,
                        style: TMThemeData.fromContext(context)
                            .textDataAuctionBlack,
                      ),
                      Text(
                        widget.dt,
                        style: TMThemeData.fromContext(context)
                            .textDataAuctionBlack,
                      ),
                      Text(
                        widget.auctionLotsCount.toString(),
                        style: TMThemeData.fromContext(context)
                            .textDataAuctionBlack,
                      ),
                      Text(
                        widget.allAuctionsLotsCount.toString(),
                        style: TMThemeData.fromContext(context)
                            .textDataAuctionBlack,
                      ),
                      Text(
                        widget.winningBidMax.toString(),
                        style: TMThemeData.fromContext(context)
                            .textDataAuctionBlack,
                      ),
                      Text(
                        widget.winningBidMin.toString(),
                        style: TMThemeData.fromContext(context)
                            .textDataAuctionBlack,
                      ),
                      Text(
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
