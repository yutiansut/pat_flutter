import 'package:flutter/material.dart';
// Custom Dialogs

class Dialog{

  TextEditingController _textFieldController = TextEditingController();


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

  Future inputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('TextField in Dialog'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "TextField in Dialog"),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop('');
              },
            ),
            FlatButton(
              child: const Text('Set'),
              onPressed: () {
                Navigator.of(context).pop(_textFieldController.text);
              },
            )
          ],
        );
      }
    );
  }

  Future colorDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Color Dialog'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Pick a color"),
          ),
          actions: <Widget>[
            
            new FlatButton(
              child: new Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop('');
              },
            ),
            FlatButton(
              child: const Text('Set'),
              onPressed: () {
                Navigator.of(context).pop(_textFieldController.text);
              },
            )
          ],
        );
      }
    );
  }

}
