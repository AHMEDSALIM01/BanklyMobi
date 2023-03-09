import 'package:flutter/material.dart';

class BanklyAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple,
      title: Text('Bankly'),
      centerTitle: true,
    );
  }
}
