class DistilleriesSlug{

final String dt;
  final String name;
  final String slug;
  final int lotsCount;
  final double winningBidMean;
  final double winningBidMax;
  final double winningBidMin;
  final double tradingVolume;

  DistilleriesSlug(
      {required this.dt,
      required this.name,
      required this.slug,
      required this.lotsCount,
      required this.winningBidMean,
      required this.winningBidMax,
      required this.winningBidMin,
      required this.tradingVolume});

  factory DistilleriesSlug.fromJson(Map<String, dynamic> json) {
    return DistilleriesSlug(
      dt: json['dt'],
      name: json['name'],
      slug: json['slug'],
      lotsCount: json['lots_count'],
      winningBidMean: json['winning_bid_mean'],
      winningBidMax: json['winning_bid_max'],
      winningBidMin: json['winning_bid_min'],
      tradingVolume: json['trading_volume'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'slug': slug,
        'lost_count': lotsCount,
        'winning_bid_mean': winningBidMean,
        'winning_bid_max': winningBidMax,
        'winning_bid_min': winningBidMin,
        'trading_volume': tradingVolume,
      };
}
