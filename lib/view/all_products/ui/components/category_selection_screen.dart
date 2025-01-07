import 'package:ecommerce_app/utils/common_utils.dart';
import 'package:ecommerce_app/utils/res/app_colors.dart';
import 'package:flutter/material.dart';

class CategorySelectionScreen extends StatefulWidget {
  final List category;
  final String selected;
  final Function(String value) onChanged;
  final Function(String value) onReset;
  const CategorySelectionScreen({
    super.key,
    required this.category,
    required this.selected,
    required this.onChanged,
    required this.onReset,
  });

  @override
  State<CategorySelectionScreen> createState() => _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  late String selectedCategory;

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.selected;
  }

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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultPadding, vertical: defaultPadding).copyWith(bottom: defaultPadding / 2.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(),
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Icon(Icons.close),
                ),
              ],
            ),
          ),
          Divider(),

          SizedBox(
            height: defaultPadding / 2,
          ),

          ///
          SizedBox(
            height: MediaQuery.of(context).size.height / 4.2,
            child: ListView.builder(
              physics: RangeMaintainingScrollPhysics(),
              itemCount: widget.category.length,
              padding: EdgeInsets.symmetric(horizontal: defaultPadding / 1.5),
              itemBuilder: (context, index) {
                return RadioListTile(
                  activeColor: Theme.of(context).primaryColor,
                  visualDensity: VisualDensity.compact,
                  contentPadding: EdgeInsets.zero,
                  value: widget.category[index],
                  groupValue: selectedCategory,
                  selected: selectedCategory == widget.category[index],
                  onChanged: (value) {
                    setState(() {
                      selectedCategory = value as String;
                    });
                  },
                  title: Text(
                    widget.category[index].toString(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: selectedCategory == widget.category[index] ? Theme.of(context).primaryColor : AppColors.greyColor,
                          fontWeight: selectedCategory == widget.category[index] ? FontWeight.w600 : FontWeight.w400,
                        ),
                  ),
                );
              },
            ),
          ),

          Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    if (widget.selected != selectedCategory || selectedCategory != '') {
                      widget.onReset(selectedCategory);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding - 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(20),
                    ),
                    child: Center(
                      child: Text(
                        'Reset',
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
                  onTap: () {
                    Navigator.pop(context);
                    widget.onChanged(selectedCategory);
                  },
                  splashColor: Colors.transparent,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(vertical: defaultPadding - 5),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
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
