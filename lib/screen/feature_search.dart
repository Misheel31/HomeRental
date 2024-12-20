import 'package:flutter/material.dart';

class FeatureSearch extends SearchDelegate {
  final List<Map<String, String>> features;

  FeatureSearch(this.features);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = features.where((feature) {
      return feature['title']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final feature = results[index];
        return ListTile(
          title: Text(feature['title']!),
          leading: Image.asset(feature['image']!),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = features.where((feature) {
      return feature['title']!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final feature = suggestions[index];
        return ListTile(
          title: Text(feature['title']!),
          onTap: () {
            query = feature['title']!;
            showResults(context);
          },
        );
      },
    );
  }
}
