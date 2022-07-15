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
}




//  {
//         "name": "Prestige Whisky Auction",
//         "slug": "prestige-whisky-auction",
//         "url": "https://www.prestigewhiskyauction.com",
//         "buyers_fee": 10.0,
//         "sellers_fee": 0.0,
//         "reserve_fee": 4.0,
//         "listing_fee": 3.0,
//         "base_currency": "GBP"
//     },
//     {
//         "name": "The Whisky Shop Auctions",
//         "slug": "the-whisky-shop-auctions",
//         "url": "https://www.whiskyshop.com/auctions/",
//         "buyers_fee": 10.0,
//         "sellers_fee": 0.0,
//         "reserve_fee": 5.0,
//         "listing_fee": 3.0,
//         "base_currency": "GBP"
//     },
//     {
//         "name": "Australian Whisky Auctions",
//         "slug": "australian-whisky-auctions",
//         "url": "https://www.australianwhiskyauctions.com.au",
//         "buyers_fee": 10.0,
//         "sellers_fee": 0.0,
//         "reserve_fee": 6.0,
//         "listing_fee": 4.0,
//         "base_currency": "AUD"
//     },
//     {
//         "name": "Whisky Bull Auctions",
//         "slug": "whisky-bull-auctions",
//         "url": "https://www.whiskybull.com/",
//         "buyers_fee": 7.0,
//         "sellers_fee": 0.0,
//         "reserve_fee": 5.0,
//         "listing_fee": 0.0,
//         "base_currency": "GBP"
//     },
//     {
//         "name": "WVA Whisky Auctions",
//         "slug": "wva-whisky-auctions",
//         "url": "https://www.wvawhiskyauctions.co.uk/",
//         "buyers_fee": 10.0,
//         "sellers_fee": 0.0,
//         "reserve_fee": 0.0,
//         "listing_fee": 0.0,
//         "base_currency": "GBP"
//     },
//     {
//         "name": "Speyside Whisky Auctions",
//         "slug": "speyside-whisky-auctions",
//         "url": "https://www.speysidewhiskyauctions.co.uk/",
//         "buyers_fee": 10.0,
//         "sellers_fee": 0.0,
//         "reserve_fee": 4.0,
//         "listing_fee": 3.0,
//         "base_currency": "GBP"
//     },
//     {
//         "name": "Scotch Whisky Auctions",
//         "slug": "scotchwhiskyauctions",
//         "url": "https://www.scotchwhiskyauctions.com/",
//         "buyers_fee": 10.0,
//         "sellers_fee": 0.0,
//         "reserve_fee": 10.0,
//         "listing_fee": 6.0,
//         "base_currency": "GBP"
//     },
//     {
//         "name": "Rum Auctioneer",
//         "slug": "rumauctioneer",
//         "url": "https://www.rumauctioneer.com/",
//         "buyers_fee": 10.0,
//         "sellers_fee": 5.0,
//         "reserve_fee": 4.0,
//         "listing_fee": 3.0,
//         "base_currency": "GBP"
//     },