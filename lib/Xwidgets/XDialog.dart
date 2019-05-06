import 'package:flutter/material.dart';
// Custom Dialogs

class Dialog{
  Future<bool> asyncConfirm(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Dialog'),
          content: const Text(
              'Do you want to delete ?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: const Text('ACCEPT'),
              onPressed: () {
                // _delete(id);
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      },
    );
  }
}
