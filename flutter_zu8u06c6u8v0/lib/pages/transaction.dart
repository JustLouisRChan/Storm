// lib/pages/transaction_summary_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import '../widgets/action_button.dart';

class TransactionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve screen dimensions for responsive design
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(238, 236, 246, 1),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Boxicons.bx_arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Transaction Summary',
          style: TextStyle(
            color: Colors.black,
            fontSize: 19,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Color.fromRGBO(238, 236, 246, 1),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: screenHeight * 0.02),
              // Total Amount Container
              TotalAmountContainer(),
              SizedBox(height: 20),
              // Transact From Section
              TransactFromSection(),
              SizedBox(height: 20),
              // Top Up Button
              ActionButton(
                label: 'Transact',
                onTap: () {
                  print('Top Up clicked');
                  // Implement Top Up functionality
                },
                isPrimary: true,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/// TotalAmountContainer Widget displaying transaction details.
class TotalAmountContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color.fromRGBO(86, 63, 232, 1), width: 1),
        color: Color.fromRGBO(236, 234, 245, 1),
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Total Amount',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Text(
            ' 0.0001 ETH',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Transfer to : JustRice',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Name : FreedWasCooking',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Public ID : 0912334285',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// TransactFromSection Widget displaying the wallet used for transaction.
class TransactFromSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        // Section Title
        Row(
          children: <Widget>[
            SizedBox(width: 15), // Add space from the left side
            Text(
              'Transact from',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            Spacer(),
          ],
        ),
        SizedBox(height: 10),
        // Wallet Container
        Container(
          width: 310,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Color.fromRGBO(86, 63, 232, 1), width: 1),
            color: Color.fromRGBO(236, 234, 245, 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Boxicons.bx_wallet,
                size: 40,
                color: Colors.black,
              ),
              SizedBox(height: 10),
              Text(
                'Metamask (****)',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
