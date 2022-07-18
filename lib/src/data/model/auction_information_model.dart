class AuctionInformations {
  final String name;
  final String slug;
  final String url;
  final double buyersFee;
  final double sellersFee;
  final double reserveFee;
  final double listingFee;
  final String baseCurrency;

  AuctionInformations(
      {required this.name,
      required this.slug,
      required this.url,
      required this.buyersFee,
      required this.sellersFee,
      required this.reserveFee,
      required this.listingFee,
      required this.baseCurrency});

  factory AuctionInformations.fromJson(Map<String, dynamic> json) {
    return AuctionInformations(
        name: json['name'],
        slug: json['slug'],
        url: json['url'],
        buyersFee: json['buyers_fee'],
        sellersFee: json['sellers_fee'],
        reserveFee: json['reserve_fee'],
        listingFee: json['listing_fee'],
        baseCurrency: json['base_currency']);
  }
  Map<String, dynamic> toJson() => {
    'name' : name,
    'slug' : slug,
    'url' : url,
    'buyers_fee': buyersFee,
    'sellers_fee': sellersFee,
    'reserver_fee': reserveFee,
    'listing_fee': listingFee,
    'baseCurrenct': baseCurrency,
  };
}




