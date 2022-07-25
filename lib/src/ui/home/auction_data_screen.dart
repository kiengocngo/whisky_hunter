import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/aution_event.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/aution_state.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/auction_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/distilleries_info/distilleries_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/distilleries_info/distilleries_info_event.dart';
import 'package:whisky_hunter/%20bloc/blocs/distilleries_info/distilleries_info_state.dart';
import 'package:whisky_hunter/%20bloc/module/bloc_module.dart';
import 'package:whisky_hunter/src/constant/tm_icon.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';
import 'package:whisky_hunter/src/data/model/distilleries_info.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';
import 'package:whisky_hunter/src/sqflite/sql_helper.dart';
import 'package:whisky_hunter/theme/tm_colors.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';
import 'package:easy_localization/easy_localization.dart';

class AuctionDataScreen extends StatefulWidget {
  const AuctionDataScreen({Key? key}) : super(key: key);

  @override
  State<AuctionDataScreen> createState() => _AuctionDataScreenState();
}

class _AuctionDataScreenState extends State<AuctionDataScreen> {
  late AuctionBloc auctionBloc;
  late DistilleriesInfoBloc disInfoBloc;

  @override
  void initState() {
    getIt<AuctionBloc>().add(GetAuctionList());
    getIt<DistilleriesInfoBloc>().add(GetDistilleriesInfoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              Expanded(flex: 1, child: _buildSearch()),
              const SizedBox(
                height: 12,
              ),
              Expanded(
                flex: 2,
                child: _buildListDisInfo(context),
              ),
              const SizedBox(height: 6,),
              const Divider(),
              const SizedBox(height: 6,),
              Expanded(
                flex: 6,
                child: _buildListAuction(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListAuction(BuildContext context) {
    return BlocBuilder<AuctionBloc, AuctionState>(
      bloc: getIt<AuctionBloc>(),
      builder: (context, state) {
        if (state is AuctionInitial || state is AuctionLoading) {
          return _buildLoading();
        } else if (state is AuctionLoaded) {
          return _buildCard(context, state.listAutionModel);
        } else if (state is AuctionError) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildCard(BuildContext context, List<AuctionDataModel> model) {
    return GridView.builder(
        itemCount: 8,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 16.0, mainAxisSpacing: 16.0),
        itemBuilder: (context, index) {
          var data = model[index];
          return Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 2 / 5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: const DecorationImage(
                    image: AssetImage(
                      TMIcons.whisky2,
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
                            tr("seeMore"),
                            style: TMThemeData.fromContext(context).learnMore,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 4,
                right: 16,
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
          );
        });
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            tr("branch"),
            style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontStyle: FontStyle.italic),
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(TMRoute.serchslug.name!);
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
    );
  }

  Widget _buildListDisInfo(BuildContext context) {
    return BlocBuilder<DistilleriesInfoBloc, DistilleriesInfoState>(
      bloc: getIt<DistilleriesInfoBloc>(),
      builder: (context, state) {
        if (state is DistilleriesInfoInitial) {
          return _buildLoading();
        } else if (state is DistilleriesInfoLoading) {
          return _buildLoading();
        } else if (state is DistilleriesInfoLoaded) {
          return _buildCard1(context, state.listDistilleriesInfo);
        } else if (state is DistilleriesInfoError) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildCard1(BuildContext context, List<DistilleriesInfo> model) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 10,
        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: 5,
      itemBuilder: (context, index) {
        var data = model[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 100,
            width: 300,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  TMIcons.whisky3,
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: TMThemeData.fromContext(context).textNameWhisky,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '${tr("country")}: ${data.country}',
                    style: TMThemeData.fromContext(context).textDataAuction,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '${tr("vote")}: ${data.votes}',
                        style: TMThemeData.fromContext(context).textDataAuction,
                      ),
                    ],
                  ),
                  Text(
                    '${tr("rate")}: ${data.rating}',
                    style: TMThemeData.fromContext(context).textDataAuction,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
