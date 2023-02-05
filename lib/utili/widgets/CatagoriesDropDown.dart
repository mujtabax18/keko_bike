import 'package:flutter/material.dart';


class CatagoriesDropDown extends StatelessWidget {
  const CatagoriesDropDown({
    super.key,
    required this.iconList,
    required this.onSelected,
  });
 final List<String> iconList;
 final Function(int) onSelected;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      onSelected: onSelected,
      offset: Offset(0, 60),
      constraints: BoxConstraints(
        minWidth: 10,
        maxWidth: 40,
      ),
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(80.0),
        ),
      ),
      itemBuilder: (context) {
        return List.generate(iconList.length, (index) => PopupMenuItem(
            value: index   ,
            child: ImageIcon(AssetImage(iconList[index]),
                size: 30, color: Colors.black),
            padding: EdgeInsets.all(5)));
      },
      icon: Icon(Icons.menu,color: Colors.black),
    );
  }
}


