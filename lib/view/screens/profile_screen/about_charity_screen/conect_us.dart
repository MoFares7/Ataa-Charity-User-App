import 'package:charity_management_system/configs/size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ConnectUs extends StatelessWidget {
  const ConnectUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          splashRadius: 20,
          icon: Icon(
            Icons.arrow_back,
            size: 20,
            color: Theme.of(context).dividerColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          tr('call us'),
          style:
              TextStyle(color: Theme.of(context).dividerColor, fontSize: 12.sp),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: defaultPadding / 3,
            ),
            Text(tr('Contact Information'),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: defaultPadding,
            ),
            AspectRatio(
              aspectRatio: 3 / 1.5,
              child: Image.asset(
                'assets/images/location.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Text(tr('Addrees'),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                )),
            const Divider(),
            const SizedBox(
              height: defaultPadding,
            ),
            Text(tr('sub_addrees'),
                style: TextStyle(
                  fontSize: 10.sp,
//fontWeight: FontWeight.bold,
                )),
            const SizedBox(
              height: defaultPadding,
            ),
            Text(tr('contact numbers'),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                )),
            const Divider(),
            const SizedBox(
              height: defaultPadding,
            ),
            Row(
              children: [
                Text(tr('Telephone number'),
                    style: TextStyle(
                      fontSize: 12.sp,
                      //   fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  width: defaultPadding,
                ),
                Text('0117007  ',
                    style: TextStyle(
                      fontSize: 10.sp,
                      //   fontWeight: FontWeight.bold,
                    )),
              ],
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Row(
              children: [
                Text(tr('mobile_number'),
                    style: TextStyle(
                      fontSize: 12.sp,
                      //   fontWeight: FontWeight.bold,
                    )),
                const SizedBox(
                  width: defaultPadding,
                ),
                Text('+963943632624  ',
                    style: TextStyle(
                      fontSize: 10.sp,
                      //   fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
