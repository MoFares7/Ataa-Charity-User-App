import 'package:flutter/material.dart';

import '../../configs/size.dart';

class SponsorCard extends StatelessWidget {
  const SponsorCard({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: InkWell(
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).cardColor),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: defaultPadding,
                    ),
                    Text(
                      title,
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
