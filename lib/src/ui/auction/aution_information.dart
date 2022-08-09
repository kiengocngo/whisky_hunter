import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/blocs.dart';
import 'package:whisky_hunter/%20bloc/module/bloc_module.dart';
import 'package:whisky_hunter/src/constant/tm_icon.dart';
import 'package:whisky_hunter/theme/tm_colors.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';
import '../../data/model/model.dart';

class AuctionInformation extends StatefulWidget {
  const AuctionInformation({Key? key}) : super(key: key);

  @override
  State<AuctionInformation> createState() => _AuctionInformationState();
}

class _AuctionInformationState extends State<AuctionInformation> {
  late String url;
  late AuctionInfoBloc auctionInfoBloc;
  @override
  void initState() {
    getIt<AuctionInfoBloc>().add(GetAuctionInfoList());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TMColors.backgroundColor,
        centerTitle: true,
        title: Text(tr("auction_info"),
            style: TMThemeData.fromContext(context).textSetting),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: _buildListAuctionInfo(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListAuctionInfo() {
    return BlocBuilder<AuctionInfoBloc, AuctionInfoState>(
      bloc: getIt<AuctionInfoBloc>(),
      builder: (context, state) {
        switch (state.status) {
          case AuctionStatus.failure:
            return Center(
              child: Text(state.error),
            );
          case AuctionStatus.success:
            if (state.auctionInfo.isEmpty) {
              return Center(
                child: Text(tr('no_data')),
              );
            }
            return ListView.separated(
                itemBuilder: (context, index) {
                  return AuctionInfoListItem(
                    auctionInfo: state.auctionInfo[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: state.auctionInfo.length);
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}

class AuctionInfoListItem extends StatelessWidget {
  final AuctionInformations auctionInfo;
  const AuctionInfoListItem({Key? key, required this.auctionInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: TMColors.gradient,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    auctionInfo.name,
                    style: TMThemeData.fromContext(context).textNameWhisky,
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    auctionInfo.slug,
                    style: TMThemeData.fromContext(context).textNameWhisky,
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    '${tr("buyers_fee")}: ${auctionInfo.buyersFee.round()} ${auctionInfo.baseCurrency}',
                    style:
                        TMThemeData.fromContext(context).textDataAuctionBlack,
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    '${tr("sellers_fee")}: ${auctionInfo.sellersFee.round()} ${auctionInfo.baseCurrency}',
                    style:
                        TMThemeData.fromContext(context).textDataAuctionBlack,
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    '${tr("listing_fee")}: ${auctionInfo.listingFee.round()} ${auctionInfo.baseCurrency}',
                    style:
                        TMThemeData.fromContext(context).textDataAuctionBlack,
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 120,
                  width: 80,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image: AssetImage(TMIcons.whisky2),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
