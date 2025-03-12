import 'package:flutter/material.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';

class CollapsableInfoContent extends StatefulWidget {
  const CollapsableInfoContent({
    super.key,
    this.title,
    this.content,
    this.contentCollapsed,
    this.crossAxisAlignment,
    this.collapsedText,
    this.expandedText,
    this.alignment,
    this.shadowColor,
  });

  final String? title;
  final List<Widget>? content;
  final List<Widget>? contentCollapsed;
  final CrossAxisAlignment? crossAxisAlignment;
  final String? collapsedText;
  final String? expandedText;
  final Alignment? alignment;
  final Color? shadowColor;

  @override
  State<StatefulWidget> createState() => _CollapsableInfoContent();
}

class _CollapsableInfoContent extends State<CollapsableInfoContent> {
  late String title;

  @override
  void initState() {
    super.initState();

    title = widget.collapsedText ?? 'Exibir mais informações';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shadowColor: widget.shadowColor ?? Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
              widget.crossAxisAlignment ?? CrossAxisAlignment.center,
          children: [
            if (widget.title != null)
              Column(
                children: [
                  Text(
                    widget.title!,
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(),
                ],
              ),
            if (widget.content?.isNotEmpty ?? false) ...widget.content!,
            if (widget.contentCollapsed?.isNotEmpty ?? false)
              ExpansionTile(
                onExpansionChanged: (isExpanded) {
                  setState(() {
                    title =
                        isExpanded
                            ? widget.expandedText ?? 'Ocultar informações'
                            : widget.collapsedText ?? 'Exibir mais informações';
                  });
                },
                title: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: context.theme.textTheme.titleMedium?.copyWith(
                    color: Colors.blue,
                  ),
                ),
                shape: Border.all(color: Colors.transparent),
                expandedCrossAxisAlignment:
                    widget.crossAxisAlignment ?? CrossAxisAlignment.center,
                expandedAlignment: widget.alignment ?? Alignment.centerLeft,
                children: widget.contentCollapsed ?? [],
              ),
          ],
        ),
      ),
    );
  }
}
