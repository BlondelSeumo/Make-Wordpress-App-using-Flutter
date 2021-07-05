import 'package:cirilla/mixins/utility_mixin.dart';
import 'package:flutter/material.dart';

class OrderBilling extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String address1;
  final String city;
  final String postcode;
  final String country;
  final String email;
  final String phone;
  final TextStyle style;
  final Map billingData;

  const OrderBilling(
      {Key key,
      this.firstName,
      this.lastName,
      this.address1,
      this.city,
      this.postcode,
      this.country,
      this.email,
      this.phone,
      this.style,
      this.billingData})
      : super(key: key);
  @override
  _OrderBillingState createState() => _OrderBillingState();
}

class _OrderBillingState extends State<OrderBilling> with Utility {
  @override
  Widget build(BuildContext context) {
    String firstName = get(widget.billingData, ['first_name'], '');
    String lastName = get(widget.billingData, ['last_name'], '');
    String address1 = get(widget.billingData, ['address_1'], '');
    String email = get(widget.billingData, ['email'], '');
    String phone = get(widget.billingData, ['phone'], '');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // SizedBox(height: 16),
        Text(
          '' + firstName + '' + lastName + '',
          style: Theme.of(context).textTheme.subtitle2,
        ),
        Text(
          address1,
          style: widget.style,
        ),
        Text(
          'Email address : ' + email + '',
          style: widget.style,
        ),
        Text(
          'Phone: ' + phone + '',
          style: widget.style,
        ),
      ],
    );
  }
}
