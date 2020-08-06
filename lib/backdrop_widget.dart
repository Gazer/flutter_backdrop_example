import 'package:flutter/material.dart';

class BackdropWidget extends StatefulWidget {
  final Widget frontLayer;
  final Widget backLayer;
  final Widget frontTitle;
  final Widget backTitle;

  const BackdropWidget(
      {Key key,
      this.frontLayer,
      this.backLayer,
      this.frontTitle,
      this.backTitle})
      : super(key: key);

  @override
  _BackdropWidgetState createState() => _BackdropWidgetState();
}

class _BackdropWidgetState extends State<BackdropWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 1.0,
      duration: Duration(milliseconds: 250),
      vsync: this,
    );
    _controller.addStatusListener((status) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: isFrontLayerVisible ? widget.frontTitle : widget.backTitle,
          elevation: 0.0,
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                _toggleLayer();
              },
            )
          ],
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            const titleHeight = 48;
            final Size canvasSize = constraints.biggest;
            final double h = canvasSize.height - titleHeight;

            Animation<RelativeRect> layerAnimation = RelativeRectTween(
              begin: RelativeRect.fromLTRB(0, h, 0, h - canvasSize.height),
              end: RelativeRect.fromLTRB(0, 0, 0, 0),
            ).animate(_controller.view);

            return Stack(
              children: [
                widget.backLayer,
                PositionedTransition(
                  rect: layerAnimation,
                  child: _FrontLayer(child: widget.frontLayer),
                ),
              ],
            );
          },
        ));
  }

  bool get isFrontLayerVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  _toggleLayer() {
    _controller.fling(velocity: isFrontLayerVisible ? -2 : 2);
  }
}

class _FrontLayer extends StatelessWidget {
  final Widget child;

  const _FrontLayer({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 12.0,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(32),
        ),
      ),
      child: Column(children: [
        Expanded(
          child: child,
        )
      ]),
    );
  }
}
