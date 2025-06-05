// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:simple_nav_bar/constants/colors.dart';

class Breadcrump extends StatefulWidget {
  final int currentPage;
  final String title ;
  final PageController controller;

  const Breadcrump({
    super.key,
    required this.title,
    required this.currentPage,
    required this.controller,
  });

  @override
  State<Breadcrump> createState() => _BreadcrumpState();
}

class _BreadcrumpState extends State<Breadcrump> {
   late int currentPage;

@override
  void initState() {
    super.initState();
    currentPage = widget.currentPage;
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        padding: const EdgeInsets.only(top: 4),
        alignment: Alignment.bottomCenter,
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues( alpha:  0.5),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Back + Title
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (widget.currentPage != 0) ...[
                        InkWell(
                          onTap: () {
                            if (widget.currentPage > 0) {
                              widget.controller.previousPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                              setState(() {
                                currentPage--;
                              });
                            }
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                            color: blackColor,
                          ),
                        ),
                        SizedBox(width: 4),
                      ],
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  /// Progress text (e.g. 1/6)
                  Text(
                    '${widget.currentPage + 1}/6',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.75,
              child: LinearProgressIndicator(

                value: (widget.currentPage + 1) / 6,
                backgroundColor: Colors.grey[300],
                color: purple_600,
                minHeight: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
