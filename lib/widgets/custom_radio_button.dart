import 'package:flutter/material.dart';
import 'package:flutter_graphql/theme_data.dart';

class MyRadioListTile<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String leading;
  final Widget? title;
  final ValueChanged<T?> onChanged;

  const MyRadioListTile({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.leading,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return InkWell(
      onTap: () => onChanged(value),
      child: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            _customRadioButton,
          ],
        ),
      ),
    );
  }

  Widget get _customRadioButton {
    final isSelected = value == groupValue;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: isSelected ? MyTheme.appbarTitleColor : null,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected ? MyTheme.appbarTitleColor : Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Text(
        leading,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.grey[600]!,
          fontSize: 15,
        ),
      ),
    );
  }
}
