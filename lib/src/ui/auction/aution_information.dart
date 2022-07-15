import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whisky_hunter/src/data/model/auction_information_model.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';

class AuctionInformation extends StatefulWidget {
  const AuctionInformation({Key? key}) : super(key: key);

  @override
  State<AuctionInformation> createState() => _AuctionInformationState();
}

class _AuctionInformationState extends State<AuctionInformation> {
  late Future<List<AuctionInformations>> listAuctionInformation;
  late String url;
  @override
  void initState() {
    listAuctionInformation = fetchAuctionInfo();
    super.initState();
  }

  Future<List<AuctionInformations>> fetchAuctionInfo() async {
    try {
      Response response =
          await Dio().get('https://whiskyhunter.net/api/auctions_info');
      if (response.statusCode == 200) {
        var getData = response.data as List;
        var listAuctionInformation =
            getData.map((e) => AuctionInformations.fromJson(e)).toList();
        return listAuctionInformation;
      } else {
        throw Exception('Faild to load AuctionData');
      }
    } on DioError catch (e) {
      throw Exception('Faild to to Data ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<AuctionInformations>>(
          future: listAuctionInformation,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: (snapshot.data as List<AuctionInformations>).length,
                itemBuilder: (context, index) {
                  var auctionInfo =
                      (snapshot.data as List<AuctionInformations>)[index];
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 2 / 5,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage(
                            'lib/assets/images/whisky.jpeg',
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        
                        children: [
                          InkWell(
                            onTap: () => launchUrl(Uri.parse(auctionInfo.url)),
                            child: Text(
                              auctionInfo.name,
                              style: TMThemeData.fromContext(context)
                                  .textNameWhisky,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            auctionInfo.slug,
                            style:
                                TMThemeData.fromContext(context).textNameWhisky,
                          ),
                          
                              Text(
                                'Buyers: ${auctionInfo.buyersFee} ${auctionInfo.baseCurrency}',
                                style: TMThemeData.fromContext(context)
                                    .textDataAuction,
                              ),
                              Text(
                                'Sellers: ${auctionInfo.sellersFee} ${auctionInfo.baseCurrency}',
                                style: TMThemeData.fromContext(context)
                                    .textDataAuction,
                              ),
                              Text(
                                'Listing: ${auctionInfo.listingFee} ${auctionInfo.baseCurrency}',
                                style: TMThemeData.fromContext(context)
                                    .textDataAuction,
                              ),
                           
                          const SizedBox(
                            height: 12,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }
}
