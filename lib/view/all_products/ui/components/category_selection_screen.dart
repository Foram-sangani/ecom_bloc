import 'package:ecommerce_app/utils/color_print.dart';
import 'package:ecommerce_app/utils/common_utils.dart';
import 'package:ecommerce_app/utils/res/app_colors.dart';
import 'package:flutter/material.dart';

class CategorySelectionScreen extends StatelessWidget {
  final List category;
  final String selected;
  final Function(String value) onChanged;
  const CategorySelectionScreen({super.key, required this.category, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(defaultRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: defaultPadding / 1.5,
          ),
          Text(
            'Categories',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Divider(),

          SizedBox(
            height: defaultPadding / 2,
          ),

          ///
          SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            child: ListView.builder(
              itemCount: category.length,
              itemBuilder: (context, index) {
                return RadioListTile(
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.zero,
                  value: category[index],
                  groupValue: category,
                  selected: selected == category[index],
                  onChanged: (value) {
                    if (value.runtimeType == String) {
                      String val = value as String;
                      onChanged(val);
                    }
                  },
                  title: Text(category[index].toString()),
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding - 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(20),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(defaultRadius),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Close',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {},
                  splashColor: Colors.transparent,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding - 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(defaultRadius),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
