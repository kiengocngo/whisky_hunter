import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:whisky_hunter/%20bloc/blocs/blocs.dart';
import 'package:whisky_hunter/src/constant/tm_icon.dart';
import 'package:whisky_hunter/src/data/model/model.dart';
import 'package:whisky_hunter/src/route/tm_route.dart';
import 'package:whisky_hunter/src/sqflite/sql_helper.dart';
import 'package:whisky_hunter/src/ui/search/animation.dart';
import 'package:whisky_hunter/theme/tm_colors.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';
import 'package:easy_localization/easy_localization.dart';

class AuctionDataScreen extends StatefulWidget {
  const AuctionDataScreen({Key? key}) : super(key: key);

  @override
  State<AuctionDataScreen> createState() => _AuctionDataScreenState();
}

class _AuctionDataScreenState extends State<AuctionDataScreen> {
  final bool favorited = false;

  @override
  void initState() {
    context.read<AuctionCubit>().getAuctionList();
    context.read<DistilleriesInfoCubit>().getListDistillInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: TMColors.backgroundColor,
        centerTitle: true,
        title: Text(
          tr("branch"),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontStyle: FontStyle.normal,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(createRoutToPage());
            },
            icon: const Icon(CupertinoIcons.search),
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 12,
              ),
              Text(
                tr('distilleries'),
                style: TMThemeData.fromContext(context).textNameWhiskyBlack,
              ),
              const SizedBox(
                height: 6,
              ),
              Expanded(
                flex: 2,
                child: _buildListDisInfo(context),
              ),
              const Divider(),
              Text(
                tr('auction'),
                style: TMThemeData.fromContext(context).textNameWhiskyBlack,
              ),
              const SizedBox(
                height: 6,
              ),
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
    return BlocBuilder<AuctionCubit, AuctionState>(
      builder: (context, state) {
        switch (state.status) {
          case AuctionStatus.failure:
            return Center(
              child: Text(state.error),
            );

          case AuctionStatus.success:
            if (state.auction.isEmpty) {
              return Center(
                child: Text(tr('no_data')),
              );
            }
            return GridView.builder(
                itemCount: state.auction.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0),
                itemBuilder: (context, index) {
                  return AuctionListItem(
                    auction: state.auction[index],
                  );
                });
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }

  Widget _buildListDisInfo(BuildContext context) {
    return BlocBuilder<DistilleriesInfoCubit, DistilleriesInfoState>(
      builder: (context, state) {
        switch (state.status) {
          case AuctionStatus.failure:
            return Center(
              child: Text(state.error),
            );
          case AuctionStatus.success:
            if (state.distilleries.isEmpty) {
              return Text(tr('no_data'));
            }
            return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return DistilleriesListItem(
                      distilleries: state.distilleries[index]);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    width: 10,
                  );
                },
                itemCount: state.distilleries.length);
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}

class AuctionListItem extends StatefulWidget {
  const AuctionListItem({Key? key, required this.auction}) : super(key: key);

  final AuctionDataModel auction;

  @override
  State<AuctionListItem> createState() => _AuctionListItemState();
}

class _AuctionListItemState extends State<AuctionListItem> {
  bool _favorited = false;

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: MediaQuery.of(context).size.height * 2 / 5,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  TMIcons.whisky2,
                ),
                fit: BoxFit.fill,
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    widget.auction.auctionName,
                    style: TMThemeData.fromContext(context).textNameWhisky,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(TMRoute.auctionSlug.name!,
                        arguments: [widget.auction]);
                  },
                  child: Container(
                    height: 40,
                    width: 160,
                    decoration: BoxDecoration(
                      gradient: TMColors.gradient,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(width: 2, color: TMColors.textWhite),
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
        ),
        Positioned(
          top: 4,
          right: 16,
          child: InkWell(
              onTap: () {
                setState(() {
                  _favorited = !_favorited;
                });
                SQLHelper.createItem(
                    widget.auction.auctionName, widget.auction.auctionSlug);
              },
              child: Icon(
                Icons.favorite,
                color: _favorited ? Colors.red : Colors.white,
              )),
        ),
      ],
    ));
  }
}

class DistilleriesListItem extends StatelessWidget {
  final DistilleriesInfo distilleries;
  const DistilleriesListItem({Key? key, required this.distilleries})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 120,
        width: 240,
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
                distilleries.name,
                style: TMThemeData.fromContext(context).textNameWhisky,
              ),
              const SizedBox(
                height: 6.0,
              ),
              Text(
                '${tr("country")}: ${distilleries.country}',
                style: TMThemeData.fromContext(context).textDataAuction,
              ),
              const SizedBox(
                height: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${tr("vote")}: ${distilleries.votes}',
                    style: TMThemeData.fromContext(context).textDataAuction,
                  ),
                ],
              ),
              Text(
                '${tr("rate")}: ${distilleries.rating}',
                style: TMThemeData.fromContext(context).textDataAuction,
              )
            ],
          ),
        ),
      ),
    );
  }
}
