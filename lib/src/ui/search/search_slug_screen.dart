import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/search_slug/search_slug_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/search_slug/search_slug_event.dart';
import 'package:whisky_hunter/%20bloc/blocs/search_slug/search_slug_state.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';

class SearchSlugScreen extends StatefulWidget {
  const SearchSlugScreen({Key? key}) : super(key: key);

  @override
  State<SearchSlugScreen> createState() => _SearchSlugScreenState();
}

class _SearchSlugScreenState extends State<SearchSlugScreen> {
  final TextEditingController _searchController = TextEditingController();
  late SearchSlugBloc _searchSlugBloc;
  @override
  void initState() {
    super.initState();
    _searchSlugBloc = context.read<SearchSlugBloc>();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: Column(
          children: [
            TextFormField(
              controller: _searchController,
              onChanged: (text) {
                _searchSlugBloc.add(GetSLugList(slug: text));
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                // hintText: 'Search with all auctions lots count',
                prefixIcon: const Icon(CupertinoIcons.search),
                suffixIcon: InkWell(
                  onTap: () {
                    _searchController.text = '';
                    _searchSlugBloc.add(const GetSLugList(slug: ''));
                  },
                  child: const Icon(CupertinoIcons.clear),
                ),
              ),
            ),
            BlocBuilder<SearchSlugBloc, SearchSlugState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is SearchError) {
                  return Text(state.error);
                }
                if (state is SearchSuccess) {
                  return state.search.isEmpty
                      ? const Text('No result')
                      : Expanded(
                          child: _SearchListItem(
                          search: state.search,
                        ));
                }
                return const Center(
                    child: Text('Please enter a slug to search'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
// todo search view
// class SearchListItem extends StatelessWidget {
//   final AuctionDataModel search;
//   const SearchListItem({Key? key, required this.search}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(search.auctionName),
//             const SizedBox(
//               height: 6,
//             ),
//             Text(search.auctionSlug),
//             const SizedBox(
//               height: 8,
//             ),
//             Text(search.allAuctionsLotsCount.toString()),
//           ],
//         ),
//       ),
//     );
//   }
// }
class _SearchListItem extends StatelessWidget {
  final List<AuctionDataModel> search;
  const _SearchListItem({Key? key, required this.search}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: search.length,
        itemBuilder: (contex, index) {
          return _SearchItem(
            item: search[index],
          );
        });
  }
}

class _SearchItem extends StatelessWidget {
  final AuctionDataModel item;
  const _SearchItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 7),
          ]),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item.auctionName),
              const SizedBox(
                height: 6,
              ),
              Text(item.auctionSlug),
              const SizedBox(
                height: 8,
              ),
              Text(item.dt),
            ],
          ),
        ),
      ),
    );
  }
}
