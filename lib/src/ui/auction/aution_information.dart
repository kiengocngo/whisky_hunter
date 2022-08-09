import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/blocs.dart';
import 'package:whisky_hunter/theme/tm_colors.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';
import 'aution_info_item.dart';

class AuctionInformation extends StatefulWidget {
  const AuctionInformation({Key? key}) : super(key: key);

  @override
  State<AuctionInformation> createState() => _AuctionInformationState();
}

class _AuctionInformationState extends State<AuctionInformation> {
  late String url;

  @override
  void initState() {
    context.read<AuctionInfoCubit>().getListAucionInfo();

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
    return BlocBuilder<AuctionInfoCubit, AuctionInfoState>(
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
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return AuctionInfoListItem(
                      auctionInfo: state.auctionInfo[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: state.auctionInfo.length),
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}
