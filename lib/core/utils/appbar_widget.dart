import 'package:flutter/material.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final String title;
  final double? elevation;
  final Function? onPressed;
  final Color? onPressedColor;
  final Brightness? brightness;
  final TextStyle textStyle;
  final List<Widget>? actions;
  final IconData? iconBackButton;
  final bool? centerTitle;
  final double? titleSpacing;
  final double? topPadding;
  final double? bottomPadding;
  final Widget? titleContainer;

  AppBarWidget({
    Key? key,
    this.backgroundColor,
    this.foregroundColor,
    required this.title,
    this.elevation = 0,
    this.onPressed,
    this.onPressedColor,
    this.brightness,
    this.textStyle = const TextStyle(
      fontFamily: 'Roboto',
      color: Colors.black,
      fontWeight: FontWeight.w700,
      fontSize: 24,
    ),
    this.actions,
    this.iconBackButton = Icons.arrow_back,
    this.centerTitle,
    this.titleSpacing = 0,
    this.topPadding,
    this.bottomPadding,
    this.titleContainer,
  }) : preferredSize = Size.fromHeight(AppBar().preferredSize.height),
       super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: false,
      foregroundColor: widget.foregroundColor ?? Colors.white,
      scrolledUnderElevation: 0,
      elevation: widget.elevation,
      backgroundColor:
          widget.backgroundColor == null
              ? Colors.white
              : widget.backgroundColor,
      title: Padding(
        padding: EdgeInsets.only(
          top: widget.topPadding == null ? 0 : widget.topPadding!,
          bottom: widget.bottomPadding == null ? 0 : widget.bottomPadding!,
        ),
        child:
            widget.titleContainer ??
            Text(
              widget.title.isEmpty ? "" : widget.title,
              style: widget.textStyle,
            ),
      ),
      // brightness:
      //     widget.brightness == null ? Brightness.light : widget.brightness,
      leading:
          widget.onPressed != null
              ? IconButton(
                icon: Icon(
                  widget.iconBackButton,
                  color:
                      widget.onPressedColor == null
                          ? Colors.black
                          : widget.onPressedColor,
                ),
                color: Colors.black,
                onPressed: widget.onPressed as void Function()?,
              )
              : Container(),
      centerTitle: widget.centerTitle == null ? true : widget.centerTitle,
      titleSpacing: widget.titleSpacing == null ? 0 : widget.titleSpacing,
      actions: widget.actions,
    );
  }
}

class AppBarBS extends StatelessWidget {
  final String? title;
  final VoidCallback? callBack;

  const AppBarBS({Key? key, required this.title, this.callBack})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    callBack != null ? callBack!() : Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Center(
                child: Text(
                  title!,
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
