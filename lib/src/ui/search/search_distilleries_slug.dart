import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whisky_hunter/%20bloc/search_distilleries_slug.dart/search_distilleries_slug_bloc.dart';
import 'package:whisky_hunter/%20bloc/search_distilleries_slug.dart/search_distilleries_slug_event.dart';
import 'package:whisky_hunter/%20bloc/search_distilleries_slug.dart/search_distilleries_slug_state.dart';
import 'package:whisky_hunter/%20bloc/search_slug/search_slug_bloc.dart';
import 'package:whisky_hunter/%20bloc/search_slug/search_slug_event.dart';
import 'package:whisky_hunter/%20bloc/search_slug/search_slug_state.dart';
import 'package:whisky_hunter/src/data/model/auction_data_model.dart';
import 'package:whisky_hunter/theme/tm_theme_data.dart';

class DistilleriesSlug extends StatefulWidget {
  const DistilleriesSlug({Key? key}) : super(key: key);

  @override
  State<DistilleriesSlug> createState() => _DistilleriesSlugScreenState();
}

class _DistilleriesSlugScreenState extends State<DistilleriesSlug> {
  final TextEditingController _searchSlugController = TextEditingController();
  final DistilleriesSlugBloc _distilleriesSlugBloc = DistilleriesSlugBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(CupertinoIcons.back),
                  ),
                ],
              ),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: _searchSlugController,
                decoration: InputDecoration(
                  hintText: 'Search with Slug...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(CupertinoIcons.search),
                    onPressed: () {
                      _distilleriesSlugBloc
                          .add(GetSLugList1(slug: _searchSlugController.text));
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Expanded(child: _buildSlug()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlug() {
    return BlocProvider(
      create: (_) => _distilleriesSlugBloc,
      child: BlocListener<DistilleriesSlugBloc, DistilleriesSlugState>(
        listener: (context, state) {
          if (state is SearchSlugError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Loi')));
          }
        },
        child: BlocBuilder<SearchSlugBloc, SearchSlugState>(
          builder: (context, state) {
            if (state is SearchSlugInitial) {
              return Container();
            } else if (state is SearchSlugLoading) {
              return _buildLoading();
            } else if (state is SearchSlugLoaded) {
              return Column(
              crossAxisAlignment: CrossAxisAlignment.start ,
                children: [
                  Text('Ket qua tim kiem cho tu khoa "${_searchSlugController.text}".'),
                  const SizedBox(height: 6,),
                  Expanded(child: _buildCard(context, state.listSlug)),
                ],
              );
            } else if (state is SearchSlugError) {
              return const Text('Loi tim kiem');
            } else {
              return const Text('Input slug to search');
            }
          },
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, List<AuctionDataModel> model) {
    return ListView.separated(
        itemCount: model.length,
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemBuilder: (context, index) {
          var data = model[index];
          return Container(
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
                Text(
                  data.dt,
                  style: TMThemeData.fromContext(context).textNameWhisky,
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
}
