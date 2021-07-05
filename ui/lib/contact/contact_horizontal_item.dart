import 'package:flutter/material.dart';
import 'contact_item.dart';
class ContactHorizontalItem extends ContactItem {
  ContactHorizontalItem({
    Key? key,
    required this.headOffice,
    required this.iconPhone,
    required this.phoneNumber,
    required this.iconEmail,
    required this.email,
    required this.iconAddress,
    required this.address,
    this.iconCornerUpRight,
    this.itemsCount = 0,
    this.onTapPhone,
    this.onTapEmail,
    this.onTapAddress,
  }) : super(key: key);

  final Widget headOffice;
  final Widget iconPhone;
  final Widget phoneNumber;
  final Widget iconEmail;
  final Widget email;
  final Widget iconAddress;
  final Widget address;
  final Widget? iconCornerUpRight;
  final int itemsCount;
  final Function? onTapPhone;
  final Function? onTapEmail;
  final Function? onTapAddress;
  @override
  Widget buildLayout(BuildContext context) {
    return Container(
      width: itemsCount > 1
        ? MediaQuery.of(context).size.width * 0.8 
        : MediaQuery.of(context).size.width * 0.8934 - 000.025,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding( padding: EdgeInsets.all(24),
        child: Column(
            mainAxisSize: MainAxisSize.min,
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
              InkWell(
                onTap: () => onTapPhone?.call() ?? null,
                child: Row(
                  children: [iconPhone, SizedBox(width: 16), phoneNumber],
                ),
              ),
              SizedBox(height: 10),
              InkWell(
                onTap: () => onTapEmail?.call() ?? null,
                child:Row(
                  children: [iconEmail, SizedBox(width: 16), email],
                ),
              ),
              SizedBox(height: 7),
              InkWell(
                onTap: () => onTapAddress?.call() ?? null,
                child:Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 3),
                    child: iconAddress,
                    ),
                    SizedBox(width: 16),
                    Flexible(
                      child:  address,
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      )
    );
  }
}
