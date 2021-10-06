import 'package:exch_book/models/book.dart';
import 'package:flutter/material.dart';

class OfferDialog extends StatefulWidget {
  // const OfferDialog({Key? key}) : super(key: key);
  late final Book book;
  OfferDialog(this.book);

  @override
  _OfferDialogState createState() => _OfferDialogState();
}

class _OfferDialogState extends State<OfferDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Center(
        child: Text('zadas'),
      ),
    );
  }
}
