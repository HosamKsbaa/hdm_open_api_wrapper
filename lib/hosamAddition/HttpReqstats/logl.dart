import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key, this.width}) : super(key: key);
  final double? width;

  @override
  Widget build(BuildContext context) {
    final double w = width ?? MediaQuery.of(context).size.width * .5;
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SizedBox(
          height: w * .6,
          width: w * 1.2,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          ),
        ),
        Image.asset("assets/monasabatApp/Icon/icon.png", width: w),
      ],
    );
  }
}
