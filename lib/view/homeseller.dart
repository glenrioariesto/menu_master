import 'package:flutter/material.dart';
import 'package:menu_master/shared/constants.dart';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:provider/provider.dart';
import '../provider/auth.dart';
import '../widgets/widgets_product_grid.dart';
import '../view/profile/profileseller.dart';

class HomeSeller extends StatefulWidget {
  const HomeSeller({super.key, required this.title});

  static const nameRoute = '/homeseller';
  final String title;

  @override
  State<HomeSeller> createState() => _HomeSellerState();
}

class BannerImages {
  static const String banner1 =
      "https://assets.grab.com/wp-content/uploads/sites/9/2020/08/06150116/1200x630Blog_diskon-88.jpg";
  static const String banner2 =
      "https://assets.grab.com/wp-content/uploads/sites/9/2020/07/03145618/DK7.7_BLOGPOST_1200X630.jpg";
  static const String banner3 =
      "https://1.bp.blogspot.com/-LHB9nYzE4Qw/YTytZhyYG0I/AAAAAAAE6_w/XiLWGeD2tIEZJNp99njLAb4SadKuWKfEgCNcBGAsYHQ/s1080/CHICKEN%2BPAO%2BPromo%2BMAGER%2BMakan%2BGratis%2BDiskon%2B60%2525%2Bvia%2BShopeeFood.jpg";

  static List<BannerModel> listBanners = [
    BannerModel(imagePath: banner1, id: "1"),
    BannerModel(imagePath: banner2, id: "2"),
    BannerModel(imagePath: banner3, id: "3"),
  ];
}

class _HomeSellerState extends State<HomeSeller> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorPalette.primaryColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/logoMenuMaster.png',
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: const TextStyle(color: ColorPalette.textColorMM),
            ),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  auth.tempData();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Profileseller()));
                },
                icon: const Icon(Icons.person_2_outlined),
                label: const Text("Profile"),
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(ColorPalette.primaryColor)),
              ),
            )
          ],
        ),
        titleTextStyle: const TextStyle(
          fontSize: 30,
          fontFamily: 'Climate Crisis',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BannerCarousel(
              banners: BannerImages.listBanners,
              onTap: (id) => print(id),
              animation: true,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: ProductGrid(),
            ),
          ],
        ),
      ),
    );
  }
}
