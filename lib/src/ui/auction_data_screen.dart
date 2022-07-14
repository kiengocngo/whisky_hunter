import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';
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
  @override
  void initState() {
    listAuctionData = fetchAuctionData();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<AuctionDataModel>>(
          future: listAuctionData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: (snapshot.data as List<AuctionDataModel>).length,
                itemBuilder: (context, index) {
                  var auctionData =
                      (snapshot.data as List<AuctionDataModel>)[index];
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      height: 360,
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage('lib/assets/images/whisky.jpeg', ),
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
                            style:
                                TMThemeData.fromContext(context).textNameWhisky,
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
                                    width: 2, color: TMColors.textWhite),
                              ),
                              child: Center(
                                child: Text(
                                  'Learn More',
                                  style: TMThemeData.fromContext(context)
                                      .learnMore,
                                ),
                              ),
                            ),
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
