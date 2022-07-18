import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/aution_bloc/auction_info/auctio_info_state.dart';
import 'package:whisky_hunter/%20bloc/aution_bloc/auction_info/auction_info_event.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction_info/auction_info_bloc.dart';
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
  final AuctionInfoBloc _auctionInfoBloc = AuctionInfoBloc();
  @override
  void initState() {
  _auctionInfoBloc.add(GetAuctionInfoList());
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
    return BlocProvider(
      create: (_) => _auctionInfoBloc,
      child: BlocListener<AuctionInfoBloc, AuctionInfoState>(
        listener:(context, state){  
          if (state is AuctionInfoError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
        child: BlocBuilder<AuctionInfoBloc, AuctionInfoState>(
          builder: (context, state) {
            if (state is AuctionInfoInitial) {
              return _buildLoading();
            } else if (state is AuctionInfoLoading) {
              return _buildLoading();
            } else if (state is AuctionInfoLoaded) {
              return _buildCard(context, state.listAuctionInfoModel);
            } else if (state is AuctionInfoError) {
              return Container();
            } else {
              return Container();
            }
        },
      ),
      )
      );
  }
  
  Widget _buildLoading() {
    return const Center(child: CircularProgressIndicator(),);
  }
  
  Widget _buildCard(BuildContext context, List<AuctionInformations> model) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: model.length,
        separatorBuilder: (context, index){
          return const Divider();
        },
        itemBuilder: (context, index){
          var data = model[index];
          return Container(
            height: MediaQuery.of(context).size.height* 2/5,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
            image: const DecorationImage(image: AssetImage('lib/assets/images/whiskey1.jpeg'),
            fit: BoxFit.fill,
            ),
           
           
          ),
           padding: const EdgeInsets.all(16.0),
           child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(data.name, style: TMThemeData.fromContext(context).textNameWhisky,),
              const SizedBox(height: 12,),
              Text(data.slug, style: TMThemeData.fromContext(context).textNameWhisky,),
              const SizedBox(height: 12.0,),
              Text('Buyers Fee: ${data.buyersFee} ${data.baseCurrency}', style: TMThemeData.fromContext(context).textDataAuction,),
              Text('Sellers Fee: ${data.sellersFee} ${data.baseCurrency}', style: TMThemeData.fromContext(context).textDataAuction,),
              Text('Listing Fee: ${data.listingFee} ${data.baseCurrency}', style: TMThemeData.fromContext(context).textDataAuction,),
            ],
           ),
          );
        },
      ),
    );
  }
}
