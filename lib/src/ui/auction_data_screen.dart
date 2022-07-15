import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';
import 'package:whisky_hunter/src/data/model/distilleries_info.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';
import 'package:whisky_hunter/src/sqflite/sql_helper.dart';
import 'package:whisky_hunter/theme/tm_colors.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';

class AuctionDataScreen extends StatefulWidget {
  const AuctionDataScreen({Key? key}) : super(key: key);

  @override
  State<AuctionDataScreen> createState() => _AuctionDataScreenState();
}

class _AuctionDataScreenState extends State<AuctionDataScreen> {
  late Future<List<AuctionDataModel>> listAuctionData;
  late Future<List<AuctionDataModel>> listSearchAuction;
  late Future<List<DistilleriesInfo>> listDistilleriesInfo;
  @override
  void initState() {
    listAuctionData = fetchAuctionData();
    listDistilleriesInfo = fetchDistillerInfo();
    super.initState();
  }

  Future<List<AuctionDataModel>> fetchAuctionData() async {
    try {
      Response response =
          await Dio().get('https://whiskyhunter.net/api/auctions_data/');
      if (response.statusCode == 200) {
        var getData = response.data as List;
        var listAuctionData =
            getData.map((e) => AuctionDataModel.fromJson(e)).toList();
        return listAuctionData;
      } else {
        throw Exception('Faild to load AuctionData');
      }
    } on DioError catch (e) {
      log(e.toString());
      throw Exception('Faild to to Data ');
    }
  }

  Future<List<DistilleriesInfo>> fetchDistillerInfo() async {
    try {
      Response response =
          await Dio().get('https://whiskyhunter.net/api/distilleries_info/');
      if (response.statusCode == 200) {
        var getData = response.data as List;
        var listDistilleriesInfo =
            getData.map((e) => DistilleriesInfo.fromJson(e)).toList();
        return listDistilleriesInfo;
      } else {
        throw Exception('Faild to load AuctionData');
      }
    } on DioError catch (e) {
      log(e.toString());
      throw Exception('Faild to to Data ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: FutureBuilder<List<DistilleriesInfo>>(
                      future: listDistilleriesInfo,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.separated(
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    width: 10,
                                  ),
                              scrollDirection: Axis.horizontal,
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                var distillerInfo = (snapshot.data
                                    as List<DistilleriesInfo>)[index];
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    height: 100,
                                    width: 300,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          'lib/assets/images/whisky2.jpeg',
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            distillerInfo.name,
                                            style:
                                                TMThemeData.fromContext(context)
                                                    .textNameWhisky,
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Text(
                                            distillerInfo.country,
                                            style:
                                                TMThemeData.fromContext(context)
                                                    .textDataAuction,
                                          ),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                'lib/assets/icons/vote.svg',
                                                height: 30,
                                                width: 30,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                distillerInfo.votes,
                                                style: TMThemeData.fromContext(
                                                        context)
                                                    .textDataAuction,
                                              ),
                                            ],
                                          ),
                                          RatingBar(
                                            initialRating: 3,
                                            itemCount: 5,
                                            ratingWidget: RatingWidget(
                                                empty: const Icon(
                                                  Icons.star_border_outlined,
                                                  color: Colors.amber,
                                                ),
                                                half: const Icon(
                                                  Icons.star_half,
                                                  color: Colors.amber,
                                                ),
                                                full: const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                )),
                                            onRatingUpdate: (rating) {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
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
                      })),
            ),
            Expanded(
              flex: 3,
              child: FutureBuilder<List<AuctionDataModel>>(
                future: listAuctionData,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount:
                          (snapshot.data as List<AuctionDataModel>).length,
                      itemBuilder: (context, index) {
                        var auctionData =
                            (snapshot.data as List<AuctionDataModel>)[index];

                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 3 / 5,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      auctionData.auctionName,
                                      style: TMThemeData.fromContext(context)
                                          .textNameWhisky,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(TMRoute.auctionSlug.name!,
                                            arguments: [
                                              auctionData.dt,
                                              auctionData.auctionName,
                                              auctionData.auctionSlug,
                                              auctionData.auctionLotsCount,
                                              auctionData.allAuctionsLotsCount,
                                              auctionData.winningBidMax,
                                              auctionData.winningBidMin,
                                              auctionData.auctionTradingVolume,
                                            ]);
                                      },
                                      child: Container(
                                        height: 56,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: TMColors.textWhite),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'Learn More',
                                            style:
                                                TMThemeData.fromContext(context)
                                                    .learnMore,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: 16, left: 16,
                                child: InkWell(
                                  onTap: () {
                                    SQLHelper.createItem(
                                        auctionData.auctionName,
                                        auctionData.auctionSlug);
                                  },
                                  child: const Icon(
                                    Icons.favorite_outline,
                                    color: Colors.red,
                                  ),
                                ),
                                // MyFavorite(),
                              ),
                            ],
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
          ],
        ),
      ),
    );
  }
}
// class MyFavorite extends StatefulWidget {
//   const MyFavorite({Key? key}) : super(key: key);

//   @override
//   State<MyFavorite> createState() => _MyFavoriteState();
// }

// class _MyFavoriteState extends State<MyFavorite> {
//   bool isFavorite = false;
 
  
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () => setState(() async{
//         isFavorite = !isFavorite;
        
//       }),
//       child: Icon(isFavorite?Icons.favorite: Icons.favorite_outline,color: Colors.red, ),);
//   }
// }