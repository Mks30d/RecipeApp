import 'package:flutter/material.dart';

class QuantityIncrementDecrement extends StatelessWidget {
  final int currNumber;
  final Function() onIncrement;
  final Function() onDecrement;
  const QuantityIncrementDecrement({
    super.key,
    required this.currNumber,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: onDecrement, icon: Icon(Icons.remove)),
          Text(
            "$currNumber",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          IconButton(onPressed: onIncrement, icon: Icon(Icons.add)),
        ],
      ),
    );
  }
}
