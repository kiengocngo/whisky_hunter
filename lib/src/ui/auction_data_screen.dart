import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:whisky_hunter/%20bloc/aution_bloc/auction/aution_event.dart';
import 'package:whisky_hunter/%20bloc/aution_bloc/auction/aution_state.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/bloc/auction_bloc.dart';

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
  late Future<List<AuctionDataModel>> listSearchAuction;
  late Future<List<DistilleriesInfo>> listDistilleriesInfo;
  final AuctionBloc _auctionBloc = AuctionBloc();
  @override
  void initState() {
    listDistilleriesInfo = fetchDistillerInfo();
    _auctionBloc.add(GetAuctionList());
    super.initState();
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
              child: _buildSearch()),
            const SizedBox(height: 12,),
            Expanded(
              flex: 2,
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
                                                height: 14,
                                                width: 14,
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
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See more...',
                      style: TMThemeData.fromContext(context).textSeeMore,
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 6,
              child: _buildListAuction(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListAuction() {
    return BlocProvider(
      create: (_) => _auctionBloc,
      child: BlocListener<AuctionBloc, AuctionState>(
        listener: (context, state) {
          if (state is AuctionError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        child: BlocBuilder<AuctionBloc, AuctionState>(
          builder: (context, state) {
            if (state is AuctionInitial) {
              return _buildLoading();
            } else if (state is AuctionLoading) {
              return _buildLoading();
            } else if (state is AuctionLoaded) {
              return _buildCard(context, state.listAutionModel);
            } else if (state is AuctionError) {
              return Container();
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, List<AuctionDataModel> model) {
    return GridView.builder(
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 2.0, mainAxisSpacing: 2.0),
        itemBuilder: (context, index) {
          var data = model[index];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Stack(
              children: [
                Container(
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.auctionName,
                        style: TMThemeData.fromContext(context).textNameWhisky,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(TMRoute.auctionSlug.name!, arguments: [
                            data.dt,
                            data.auctionName,
                            data.auctionSlug,
                            data.auctionLotsCount,
                            data.allAuctionsLotsCount,
                            data.winningBidMax,
                            data.winningBidMin,
                            data.auctionTradingVolume,
                          ]);
                        },
                        child: Container(
                          height: 40,
                          width: 160,
                          decoration: BoxDecoration(
                            border:
                                Border.all(width: 2, color: TMColors.textWhite),
                          ),
                          child: Center(
                            child: Text(
                              'See More',
                              style: TMThemeData.fromContext(context).learnMore,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: InkWell(
                    onTap: () {
                      SQLHelper.createItem(data.auctionName, data.auctionSlug);
                    },
                    child: const Icon(
                      Icons.favorite_outline,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  Widget _buildSearch() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: 'Search with slug',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
