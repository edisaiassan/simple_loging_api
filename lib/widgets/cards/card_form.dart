import 'package:flutter/material.dart';
import 'package:login_sigup/widgets/texts/subtitle_text.dart';

import '../../const/sizes.dart';
import '../texts/title_text.dart';

class CardForm extends StatelessWidget {
  final Widget? leading;
  final String title;
  final String subtitle;
  final String description;
  final List<Widget> content;
  const CardForm({
    super.key,
    required this.title,
    this.content = const <Widget>[],
    this.leading,
    required this.subtitle,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(minCorner),
      ),
      margin: const EdgeInsets.all(minMargin),
      child: Padding(
        padding: const EdgeInsets.all(maxMargin),
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(child: leading),
                  (leading == null)
                      ? const SizedBox()
                      : const SizedBox(width: minMargin),
                  TitleText(title),
                ],
              ),
              const SizedBox(height: minMargin),
              SubTitleText(subtitle),
              const SizedBox(height: minMargin),
              Text(description),

              const SizedBox(height: maxMargin),

              // ignore: unnecessary_null_comparison
              Column(
                children: content,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
