import 'package:flutter/material.dart';

import '../../utils/util.dart';
import 'responsive_text.dart';

class CustomDialog {
  static void showCustomActionDialog(
    BuildContext context, {
    required Function() onTap,
    required String negativeText,
    required String positiveText,
    required String title,
  }) {
    showDialog(
        context: context,
        builder: (ctx) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin:
                  EdgeInsets.symmetric(horizontal: kHorizontalMargin),
                  padding: EdgeInsets.symmetric(
                      vertical: kVerticalMargin,
                      horizontal: kHorizontalMargin),
                  width: width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ResponsiveText(
                        title,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(
                        height: kVerticalMargin * 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Material(
                            color
                                : Colors.white,
                            child: InkWell(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: kHorizontalMargin,
                                    vertical: kVerticalMargin / 2),
                                child: ResponsiveText(
                                  negativeText,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onTap: () {
                                Navigator.pop(ctx);
                              },
                            ),
                          ),
                          SizedBox(
                            width: kHorizontalMargin * 2,
                          ),
                          Material(
                            color
                                : Colors.white,
                            child: InkWell(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: kHorizontalMargin,
                                    vertical: kVerticalMargin / 2),
                                child: ResponsiveText(
                                  positiveText,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onTap: () async {
                                Navigator.pop(ctx);
                                onTap();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
