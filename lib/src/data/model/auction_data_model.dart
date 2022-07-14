class AuctionDataModel {
  final String dt;
  final String auctionName;
  final String auctionSlug;
  final int auctionLotsCount;
  final int allAuctionsLotsCount;
  final double winningBidMax;
  final double winningBidMin;
  final double auctionTradingVolume;

  AuctionDataModel(
      {required this.dt,
      required this.auctionName,
      required this.auctionSlug,
      required this.auctionLotsCount,
      required this.allAuctionsLotsCount,
      required this.winningBidMax,
      required this.winningBidMin, required this.auctionTradingVolume});

  factory AuctionDataModel.fromJson(Map<String, dynamic> json) {
    return AuctionDataModel(
        dt: json['dt'],
        auctionName: json['auction_name'],
        auctionSlug: json['auction_slug'],
        auctionLotsCount: json['auction_lots_count'],
        allAuctionsLotsCount: json['all_auctions_lots_count'],
        winningBidMax: json['winning_bid_max'],
        winningBidMin: json['winning_bid_min'],
        auctionTradingVolume: json['auction_trading_volume']
        );
  }
}
