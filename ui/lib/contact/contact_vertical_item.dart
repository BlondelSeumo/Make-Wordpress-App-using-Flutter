import 'package:flutter/material.dart';
import 'contact_item.dart';
class ContactVerticalItem extends ContactItem{
  ContactVerticalItem({
    Key? key,
    required this.headOffice,
    required this.iconPhone,
    required this.phoneNumber,
    required this.iconEmail,
    required this.email,
    required this.iconAddress,
    required this.address,
    this.iconCornerUpRight,
    this.onTapPhone,
    this.onTapEmail,
    this.onTapAddress,
  }): super(key: key);

  final Widget headOffice;
  final Widget iconPhone;
  final Widget phoneNumber;
  final Widget iconEmail;
  final Widget email;
  final Widget iconAddress;
  final Widget address;
  final Widget? iconCornerUpRight;
  final Function? onTapPhone;
  final Function? onTapEmail;
  final Function? onTapAddress;
  @override
  Widget buildLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 20,end: 20),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              headOffice,
              iconCornerUpRight ?? Container(),
            ]
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsetsDirectional.only(top: 16,start: 16,end: 16),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                InkWell(
                  onTap: () => onTapPhone?.call() ?? null,
                  child:Row(
                    children: [
                      iconPhone,
                      SizedBox(width: 16),
                      phoneNumber
                    ],
                  ),
                ),
                SizedBox(height: 18),
                InkWell(
                  onTap: () => onTapEmail?.call() ?? null,
                  child:Row(
                    children: [
                      iconEmail,
                      SizedBox(width: 16),
                      Expanded(
                        child:  email,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18),
                InkWell(
                  onTap: () => onTapAddress?.call() ?? null,
                  child:Row(
                    children: [
                      iconAddress,
                      SizedBox(width: 16),
                      Expanded(
                        child:  address,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
              ]
            )
          )
        ],
      ),
    );
  }
}