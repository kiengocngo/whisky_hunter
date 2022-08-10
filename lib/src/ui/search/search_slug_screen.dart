import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/blocs/search_slug/search_slug_cubit.dart';
import 'package:whisky_hunter/%20bloc/blocs/search_slug/search_slug_state.dart';
import 'package:whisky_hunter/src/comp/appbar/tm_app_bar.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';
import 'package:whisky_hunter/theme/tm_colors.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';

class SearchSlugScreen extends StatefulWidget {
  const SearchSlugScreen({Key? key}) : super(key: key);

  @override
  State<SearchSlugScreen> createState() => _SearchSlugScreenState();
}

class _SearchSlugScreenState extends State<SearchSlugScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(tr('search')),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        child: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.done,
              style: TMThemeData.fromContext(context).textDataAuctionBlack,
              cursorHeight: 20,
              cursorColor: TMColors.backgroundColor,
              controller: _searchController,
              onChanged: (text) {
                context.read<SearchCubit>().getSearchList(text);
              },
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      width: 1, color: TMColors.backgroundColor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: TMColors.backgroundColor,
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    _searchController.text = '';
                    context.read<SearchCubit>().getSearchList('');
                  },
                  child: const Icon(
                    CupertinoIcons.clear,
                    color: TMColors.backgroundColor,
                  ),
                ),
              ),
            ),
            BlocBuilder<SearchCubit, SearchSlugState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: CircularProgressIndicator(
                      color: TMColors.backgroundColor,
                    ),
                  );
                }
                if (state is SearchError) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Text(
                      state.error!,
                      style:
                          TMThemeData.fromContext(context).textNameWhiskyBlack,
                    ),
                  );
                }
                if (state is SearchSuccess) {
                  return state.search.isEmpty
                      ? Text(tr("no_data"))
                      : Expanded(
                          child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: _SearchListItem(
                            search: state.search,
                          ),
                        ));
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      tr('please_enter'),
                      style:
                          TMThemeData.fromContext(context).textNameWhiskyBlack,
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
    return Card(
      elevation: 5,
      shadowColor: TMColors.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: TMColors.gradient,
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
