import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/auction/aution_state.dart';
import 'package:whisky_hunter/%20bloc/blocs/search_slug/search_slug_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/search_slug/search_slug_event.dart';
import 'package:whisky_hunter/%20bloc/blocs/search_slug/search_slug_state.dart';
import 'package:whisky_hunter/%20bloc/module/bloc_module.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';

class SearchSlugScreen extends StatefulWidget {
  const SearchSlugScreen({Key? key}) : super(key: key);

  @override
  State<SearchSlugScreen> createState() => _SearchSlugScreenState();
}

class _SearchSlugScreenState extends State<SearchSlugScreen> {
  @override
  void initState() {
    super.initState();
    getIt<SearchSlugBloc>().add(GetSLugList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(onChanged: (value) {
              setState(() {});
            }),
            BlocBuilder<SearchSlugBloc, SearchSlugState>(
              bloc: getIt<SearchSlugBloc>(),
              builder: (context, state) {
                switch (state.status) {
                  case AuctionStatus.failure:
                    return const Text('faild to fetch data');
                  case AuctionStatus.success:
                    if (state.search.isEmpty) {
                      return const Text('no data');
                    }
                    return Expanded(
                      child: ListView.builder(
                        itemCount: state.search.length,
                        itemBuilder: (context, index) {
                          return SearchListItem(search: state.search[index]);
                        },
                      ),
                    );
                  default:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SearchListItem extends StatelessWidget {
  final AuctionDataModel search;
  const SearchListItem({Key? key, required this.search}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(search.auctionName),
      subtitle: Text(search.auctionSlug),
      title: Text(search.allAuctionsLotsCount.toString()),
    );
  }
}
