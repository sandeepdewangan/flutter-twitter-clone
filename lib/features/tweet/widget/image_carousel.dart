import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> imageLinks;
  const ImageCarousel({super.key, required this.imageLinks});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          items:
              widget.imageLinks.map((link) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Image.network(link, fit: BoxFit.contain),
                );
              }).toList(),
          options: CarouselOptions(height: 200, enableInfiniteScroll: false),
        ),
      ],
    );
  }
}
