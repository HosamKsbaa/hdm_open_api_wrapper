import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  Logo({Key? key, this.width}) : super(key: key);
  double? width;

  @override
  Widget build(BuildContext context) {
    width ??= MediaQuery.of(context).size.width * .5;
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        SizedBox(
          height: width! * .6,
          width: width! * 1.2,
          child: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: const BorderRadius.all(Radius.circular(10.0))),
          ),
        ),
        Image.asset("assets/monasabatApp/Icon/icon.png", width: width),
      ],
    );
  }
}
