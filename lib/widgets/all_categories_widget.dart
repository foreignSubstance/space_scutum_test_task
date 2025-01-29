import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:space_scutum_test_task/providers/query_configuration_provider.dart';
import 'package:space_scutum_test_task/widgets/single_category_widget.dart';

class AllCategoriesWidget extends ConsumerStatefulWidget {
  const AllCategoriesWidget({super.key});

  @override
  ConsumerState<AllCategoriesWidget> createState() =>
      _AllCategoriesWidgetState();
}

class _AllCategoriesWidgetState extends ConsumerState<AllCategoriesWidget> {
  final Map<String, int> _categories = {
    'films': 11,
    'music': 12,
    'games': 15,
  };
  String selectedCategory = '';

  void setSelectedCategory(String title) {
    if (selectedCategory != title) {
      setState(() {
        selectedCategory = title;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ..._categories.entries.map(
            (categoryEntry) => SingleCategoryWidget(
              onCategoryChose: () {
                HapticFeedback.lightImpact();
                ref
                    .read(queryConfigurationProvider.notifier)
                    .setSettings(category: categoryEntry.value);
                setSelectedCategory(categoryEntry.key);
              },
              title: categoryEntry.key,
              isSelected: selectedCategory == categoryEntry.key,
            ),
          ),
        ],
      ),
    );
  }
}
