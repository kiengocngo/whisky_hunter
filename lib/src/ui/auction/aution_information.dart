import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/blocs.dart';
import 'package:whisky_hunter/%20bloc/module/bloc_module.dart';
import 'package:whisky_hunter/src/constant/tm_icon.dart';
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
              return const Center(
                child: Text('no data'),
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
      child: Container(
        height: MediaQuery.of(context).size.height * 2 / 5,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          image: const DecorationImage(
            image: AssetImage(TMIcons.whisky1),
            fit: BoxFit.fill,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              auctionInfo.name,
              style: TMThemeData.fromContext(context).textNameWhisky,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              auctionInfo.slug,
              style: TMThemeData.fromContext(context).textNameWhisky,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              '${tr("buyers_fee")}: ${auctionInfo.buyersFee} ${auctionInfo.baseCurrency}',
              style: TMThemeData.fromContext(context).textDataAuction,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              '${tr("sellers_fee")}: ${auctionInfo.sellersFee} ${auctionInfo.baseCurrency}',
              style: TMThemeData.fromContext(context).textDataAuction,
            ),
            const SizedBox(
              height: 12.0,
            ),
            Text(
              '${tr("listing_fee")}: ${auctionInfo.listingFee} ${auctionInfo.baseCurrency}',
              style: TMThemeData.fromContext(context).textDataAuction,
            ),
          ],
        ),
      ),
    );
  }
}
