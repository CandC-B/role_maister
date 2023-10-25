import 'dart:math';
import 'package:flutter/material.dart';

class ImageColorFilter extends StatefulWidget {
  const ImageColorFilter({
    super.key,
    required this.imagePath,
    required this.routeName,
    required this.imageText,
    required this.isAvailable,
    required this.width,
    required this.height,
    required this.isLink,
    required this.preset,
  });
  final String imagePath;
  final String routeName;
  final String imageText;
  final bool isAvailable;
  final double width;
  final double height;
  final bool isLink;
  final bool preset;

  @override
  _ImageColorFilterState createState() => _ImageColorFilterState();
}

class _ImageColorFilterState extends State<ImageColorFilter> {
  bool isHovering = false;
  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (hovering) {
        setState(() {
          isHovering = hovering;
        });
      },
      child: ClipRect(
        child: ColorFiltered(
          colorFilter: isHovering || widget.preset
              ? ColorFilter.mode(Colors.transparent, BlendMode.color)
              : ColorFilter.mode(Colors.grey, BlendMode.saturation),
          child: Stack(
            children: [
              Container(
                width: widget.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: widget.width,
                height: widget.height,
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    widget.imageText,
                    style: const TextStyle(
                        fontSize: 30,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Poppins'),
                  ),
                ),
              ),
              SizedBox(
                width: widget.width,
                height: widget.height,
                child: CustomPaint(
                    painter: LinePainter(
                        color: widget.isAvailable
                            ? Colors.transparent
                            : Colors.deepPurple)),
              ),
              Container(
                width: widget.width,
                height: widget.height,
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: -atan(widget.height/widget.width),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "COMING SOON",
                      style: TextStyle(
                          fontSize: 40,
                          color: widget.isAvailable
                              ? Colors.transparent
                              : Colors.white,
                          fontWeight: FontWeight.w900,
                          fontFamily: 'Poppins'
                        ),
                      ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        // Handle the tap action here.
        // TODO: redirect to next page widget.routeName
        if (widget.isAvailable) {
          if (widget.isLink) {

          }
        }
      },
    );
  }
}

class LinePainter extends CustomPainter {
  final Color color; // Add a color attribute

  LinePainter({required this.color}); // Constructor to set the color

  @override
  void paint(Canvas canvas, Size size) {
    final p1 = Offset(size.width, 0);
    final p2 = Offset(0, size.height);
    final paint = Paint()
      ..color = color
      ..strokeWidth = 35;
    canvas.drawLine(p1, p2, paint);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) => false;
}