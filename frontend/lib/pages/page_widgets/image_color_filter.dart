import 'dart:math';
import 'package:flutter/material.dart';

class ImageColorFilter extends StatefulWidget {
  const ImageColorFilter({
    super.key,
    required this.imagePath,
    required this.routeName,
    required this.imageText,
    required this.isAvailable,
    required this.angle,
  });
  final String imagePath;
  final String routeName;
  final String imageText;
  final bool isAvailable;
  final double angle;

  @override
  _ImageColorFilterState createState() => _ImageColorFilterState();
}

class _ImageColorFilterState extends State<ImageColorFilter> {
  bool isHovering = false;
  

  @override
  Widget build(BuildContext context) {
    final width = (MediaQuery.of(context).size.width * 0.8) / 3;
    final height = (MediaQuery.of(context).size.height) * 0.9;

    return InkWell(
      onHover: (hovering) {
        setState(() {
          isHovering = hovering;
        });
      },
      child: ClipRect(
        child: ColorFiltered(
          colorFilter: isHovering
              ? ColorFilter.mode(Colors.transparent, BlendMode.color)
              : ColorFilter.mode(Colors.grey, BlendMode.saturation),
          child: Stack(
            children: [
              Container(
                width: width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: width,
                height: height,
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
                width: width,
                height: height,
                child: CustomPaint(
                    painter: LinePainter(
                        color: widget.isAvailable
                            ? Colors.transparent
                            : Colors.deepPurple)),
              ),
              Container(
                width: width,
                height: height,
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: -atan(height/width),
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
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => InitGame(),
          //   ),
          // );
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