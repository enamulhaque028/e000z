import 'package:flutter/material.dart';

import '../config/presentation/app_color.dart';

class Expandable extends StatefulWidget {
  const Expandable({
    Key? key,
    required this.header,
    required this.children,
    this.headerTrailing,
  }) : super(key: key);

  final Widget header;
  final List<Widget> children;
  final Widget? headerTrailing;

  @override
  _ExpandableState createState() => _ExpandableState();
}

class _ExpandableState extends State<Expandable>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _iconColorTween = ColorTween();

  bool _isOpen = false;
  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));

    _isOpen = PageStorage.of(context)?.readState(context) as bool? ?? false;
    if (_isOpen) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _iconColorTween
      ..begin = AppColor.kPrimaryColor
      ..end = AppColor.kDarkBlueColor;
    super.didChangeDependencies();
  }

  void _handleTap() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isOpen);
    });
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: widget.header,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8,
                  right: widget.headerTrailing != null ? 8 : 0,
                ),
                child: InkResponse(
                  onTap: _handleTap,
                  radius: 16,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).canvasColor,
                    ),
                    child: RotationTransition(
                      turns: _iconTurns,
                      child: const Icon(
                        Icons.keyboard_arrow_down,
                        // size: 8,
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.headerTrailing != null) widget.headerTrailing!,
            ],
          ),
          ClipRect(
            child: Align(
              heightFactor: _heightFactor.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isOpen && _controller.isDismissed;

    final Widget result = Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.grey.shade400,
              width: 1.2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.only(top: 16),
          child: Column(
            children: widget.children,
          ),
        ),
      ),
    );

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: result,
    );
  }
}
