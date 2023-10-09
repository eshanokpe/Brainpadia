import 'package:flutter/material.dart';

class DialogBox {
  information(BuildContext context, String title, String description,
      {Function? no}) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description,
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, color: Colors.black))
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () => no != null ? no() : Navigator.pop(context),
              )
            ],
          );
        });
  }

  waiting(BuildContext context, String description) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () => Future.value(false),
            child: AlertDialog(
              content: SingleChildScrollView(
                padding: const EdgeInsets.all(5),
                child: Row(
                  children: <Widget>[
                    CircularProgressIndicator(
                      color: Colors.grey[500],
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(description,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.black))
                  ],
                ),
              ),
            ),
          );
        });
  }

  options(
      BuildContext context, String title, String description, Function yes) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          Orientation orientation = MediaQuery.of(context).orientation;
          final width = orientation == Orientation.portrait
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.height;

          return AlertDialog(
            title: Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(description,
                      style: TextStyle(
                          fontSize: width * .035,
                          fontWeight: FontWeight.w300,
                          color: Colors.black))
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('No',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor)),
                onPressed: () => Navigator.pop(context),
              ),
              TextButton(
                child: Text('Yes',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).primaryColor)),
                onPressed: () {
                  Navigator.pop(context);
                  yes();
                },
              ),
            ],
          );
        });
  }
}
