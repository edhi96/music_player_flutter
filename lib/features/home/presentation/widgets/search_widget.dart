import 'package:flutter/material.dart';
import 'package:music_player_flutter/features/home/presentation/provider/search_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../common/styles.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (v) {
        if (v.isEmpty) {
          Provider.of<SearchNotifier>(context, listen: false).fetchSearch('');
        }
      },
      onSubmitted: (query) {
        Provider.of<SearchNotifier>(context, listen: false).fetchSearch(query);
      },
      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.blueColor),
      decoration: const InputDecoration(
        hintText: 'Search title',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(25.0),
          ),
        ),
      ),
      textInputAction: TextInputAction.search,
    );
  }
}
