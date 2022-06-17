import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertService {
  void showSignOut(BuildContext context, String title, String desc,
      Function onSignout, Function onCancel) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(desc),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    "YES",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    onSignout();
                  },
                ),
                TextButton(
                  child: const Text(
                    "NO",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    onCancel();
                  },
                )
              ],
            ));
  }

  void showConfirm(BuildContext context, String title, String desc,
      Function onOk, Function onCancel) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(desc),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    "YES",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    onOk();
                  },
                ),
                TextButton(
                  child: const Text(
                    "NO",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    onCancel();
                  },
                )
              ],
            ));
  }

  void showSuccess(
      BuildContext context, String title, String desc, Function onCancel) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(desc),
              actions: <Widget>[
                TextButton(
                    child: const Text(
                      "Done",
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    onPressed: () {
                      onCancel();
                    }),
              ],
            ));
  }

  void showError(
      BuildContext context, String title, String desc, Function onCancel) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(desc),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    "DONE",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    onCancel();
                  },
                )
              ],
            ));
  }

  void showWarning(
      BuildContext context, String title, String desc, Function onCancel) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title),
              content: Text(desc),
              actions: <Widget>[
                TextButton(
                  child: const Text(
                    "DONE",
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    onCancel();
                  },
                )
              ],
            ));
  }
}
