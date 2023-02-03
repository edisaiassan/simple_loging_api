import 'package:flutter/material.dart';
import 'package:login_sigup/const/sizes.dart';

//Este widget busca resumir el diseño de una lista centrada
//pide parámetro children y un booleano si es centrado o no
//reverse pide un VerticalDirection, .down o .up

class BetterListView extends StatelessWidget {
  final List<Widget> children;
  final bool center;
  final bool reverse;
  final double paddingTop;
  final double paddingBottom;
  const BetterListView({
    super.key,
    this.children = const <Widget>[],
    this.center = false,
    this.reverse = false,
    this.paddingTop = maxMargin,
    this.paddingBottom = maxMargin,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        reverse: reverse,
        shrinkWrap: center,
        primary: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.fromLTRB(
            maxMargin, paddingTop, maxMargin, paddingBottom),
        children: [
          Center(
            child: SizedBox(
              width: maxWidth,
              child: Column(
                verticalDirection:
                    reverse ? VerticalDirection.up : VerticalDirection.down,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
