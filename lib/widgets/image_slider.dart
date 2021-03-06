import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _index = 0;
  int _dataLength = 1;

  @override
  void initState() {
    getSliderImageFromDb();
    super.initState();
  }

  Future getSliderImageFromDb() async {
    var _fireStore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await _fireStore.collection('slider').get();
    if (mounted) {
      setState(() {
        _dataLength = snapshot.docs.length;
      });
    }
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          colors: [
            const Color(0xffbce6eb),
            const Color(0xFF26A69A)
          ], // whitish to gray
        ),
      ),
      child: Column(
        children: [
          if (_dataLength != 0)
            FutureBuilder(
              future: getSliderImageFromDb(),
              builder: (_, snapShot) {
                return snapShot.data == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 1),
                        child: CarouselSlider.builder(
                          options: CarouselOptions(
                              viewportFraction: 1,
                              initialPage: 0,
                              autoPlay: true,
                              height: 180,
                              onPageChanged:
                                  (int i, carouselPageChangedReason) {
                                setState(() {
                                  _index = i;
                                });
                              }),
                          itemCount: snapShot.data.length,
                          itemBuilder: (BuildContext context, int index, int) {
                            DocumentSnapshot sliderImage = snapShot.data[index];
                            Map getImage = sliderImage.data();
                            return SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Image.network(
                                  getImage['image'],
                                  fit: BoxFit.fill,
                                ));
                          },
                        ),
                      );
              },
            ),
          // if (_dataLength != 0)
          //   DotsIndicator(
          //     dotsCount: _dataLength,
          //     position: _index.toDouble(),
          //     decorator: DotsDecorator(
          //         size: const Size.square(5.0),
          //         activeSize: const Size(18.0, 5.0),
          //         activeShape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(5.0)),
          //         activeColor: Theme.of(context).primaryColor),
          //   )
        ],
      ),
    );
  }
}
