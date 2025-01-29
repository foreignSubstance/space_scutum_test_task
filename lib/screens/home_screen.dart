import 'package:flutter/material.dart';
import 'package:space_scutum_test_task/models/component_sizes_model.dart';
import 'package:space_scutum_test_task/widgets/all_categories_widget.dart';
import 'package:space_scutum_test_task/widgets/all_difficulties_widget.dart';
import 'package:space_scutum_test_task/widgets/custom_slider_widget.dart';
import 'package:space_scutum_test_task/widgets/start_quiz_button_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ComponentSizes.init(context);
    return const Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomHomePageText('How many questions do you want?'),
            CustomSliderWidget(
                min: 10, max: 50, divisions: 8, type: 'quantity'),
            CustomHomePageText('How much time per question do you need?'),
            CustomSliderWidget(min: 10, max: 55, divisions: 9, type: 'time'),
            CustomHomePageText('What topic are you intrested in?'),
            AllCategoriesWidget(),
            CustomHomePageText('How difficult questions will be?'),
            AllDifficultiesWidget(),
            StartQuizButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class CustomHomePageText extends StatelessWidget {
  const CustomHomePageText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ComponentSizes.defaultPadding,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
        textAlign: TextAlign.center,
      ),
    );
  }
}
