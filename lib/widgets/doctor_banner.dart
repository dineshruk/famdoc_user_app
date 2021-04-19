import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:famdoc_user/providers/doctor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorBanner extends StatefulWidget {
  @override
  _DoctorBannerState createState() => _DoctorBannerState();
}

class _DoctorBannerState extends State<DoctorBanner> {
  int _index = 0;
  int _dataLength = 1;

  @override
  void didChangeDependencies() {
    var _doctorProvider = Provider.of<DoctorProvider>(context);
    getBannerImageFromDb(_doctorProvider);
    super.didChangeDependencies();
  }

  Future getBannerImageFromDb(DoctorProvider doctorProvider) async {
    var _fireStore = FirebaseFirestore.instance;
    QuerySnapshot snapshot = await _fireStore
        .collection('doctorcover')
        .where('doctoruid', isEqualTo: doctorProvider.doctordetails['uid'])
        .get();
    if (mounted) {
      setState(() {
        _dataLength = snapshot.docs.length;
      });
    }
    return snapshot.docs;
  }

  @override
  Widget build(BuildContext context) {
    var _doctorProvider = Provider.of<DoctorProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        //color: Colors.white,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
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
                future: getBannerImageFromDb(_doctorProvider),
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
                                    getImage['imageUrl'],
                                    fit: BoxFit.fill,
                                  )
                                  
                                  );
                                  
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
      ),
    );
  }
}
