import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp/items.dart';
import 'package:myapp/screens/product_detail.dart';
import 'package:myapp/widgets.dart' as wd;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Carditem> cardItems = [];
  String searchText = "";

  @override
  void initState() {
    super.initState();
    cardItems = [
      Carditem(title: "dress1", price: "Rs650", image: [
        "https://img.freepik.com/free-photo/portrait-young-girl-posing-while-bowing-head-shoulder-white-t-shirt-looking-cheerful-front-view_176474-59050.jpg?size=626&ext=jpg&ga=GA1.1.1997250661.1712141735&semt=ais_hybrid",
        "https://img.freepik.com/free-photo/portrait-young-girl-posing-while-bowing-head-shoulder-white-t-shirt-looking-cheerful-front-view_176474-59050.jpg?size=626&ext=jpg&ga=GA1.1.1997250661.1712141735&semt=ais_hybrid",
        "https://img.freepik.com/free-photo/portrait-young-girl-posing-while-bowing-head-shoulder-white-t-shirt-looking-cheerful-front-view_176474-59050.jpg?size=626&ext=jpg&ga=GA1.1.1997250661.1712141735&semt=ais_hybrid"
      ]),
      Carditem(title: "dress2", price: "Rs750", image: [
        "https://cdn.pixabay.com/photo/2024/05/09/13/35/ai-generated-8751042_1280.png",
        "https://cdn.pixabay.com/photo/2024/05/09/13/35/ai-generated-8751042_1280.png",
        "https://cdn.pixabay.com/photo/2024/05/09/13/35/ai-generated-8751042_1280.png"
      ]),
      Carditem(title: "dress3", price: "Rs750", image: [
        "https://cdn.pixabay.com/photo/2024/01/20/01/54/ai-generated-8520240_1280.jpg",
        "https://cdn.pixabay.com/photo/2024/01/20/01/54/ai-generated-8520240_1280.jpg",
        "https://cdn.pixabay.com/photo/2024/01/20/01/54/ai-generated-8520240_1280.jpg"
      ]),
      Carditem(title: "dress4", price: "Rs690", image: [
        "https://cdn.pixabay.com/photo/2024/01/20/01/50/ai-generated-8520179_1280.jpg",
        "https://cdn.pixabay.com/photo/2024/01/20/01/50/ai-generated-8520179_1280.jpg",
        "https://cdn.pixabay.com/photo/2024/01/20/01/50/ai-generated-8520179_1280.jpg"
      ]),
      Carditem(title: "dress5", price: "Rs880", image: [
        "https://cdn.pixabay.com/photo/2024/01/20/01/50/ai-generated-8520179_1280.jpg",
        "https://cdn.pixabay.com/photo/2024/01/20/01/50/ai-generated-8520179_1280.jpg",
        "https://cdn.pixabay.com/photo/2024/01/20/01/50/ai-generated-8520179_1280.jpg"
      ]),
      Carditem(title: "dress6", price: "Rs780", image: [
        "https://media.istockphoto.com/id/1328049157/photo/mens-short-sleeve-t-shirt-mockup-in-front-and-back-views.jpg?b=1&s=612x612&w=0&k=20&c=naPy6RFK_tPbgo8FK4FFsn2_aWKUuqTC_Gw-wDG2xss=",
        "https://cdn.pixabay.com/photo/2024/01/20/01/50/ai-generated-8520179_1280.jpg",
        "https://cdn.pixabay.com/photo/2024/01/20/01/50/ai-generated-8520179_1280.jpg"
      ])
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: wd.customBottomNavigation(context),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search_off_rounded,
                    color: Colors.grey,
                  ),
                  suffixIcon: Icon(Icons.filter_list),
                  hintText: "Search Products",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide(
                      width: 4,
                      color: Color.fromRGBO(101, 202, 245, 1),
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },
              ),
            ),
            Expanded(
                child: GridView.count(
                    crossAxisCount: 2,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: cardItems
                        .where((Carditem) => Carditem.title
                            .toLowerCase()
                            .contains(searchText.toLowerCase()))
                        .map((cardItems) {
                      return buildCard(cardItems);
                    }).toList()))
          ],
        ),
      ),
    );
  }

  Widget buildCard(Carditem cardItem) {
    return GestureDetector(
      onTap: () async {
        await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetail(
                      product: 0,
                    )));
      },
      child: Card(
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height / 10,
                child: PageView.builder(
                    itemCount: cardItem.image.length,
                    onPageChanged: (int index) {
                      setState(() {
                        cardItem.currentIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.network(
                        cardItem.image[index],
                        fit: BoxFit.cover,
                      );
                    })),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(cardItem.image.length,
                  (int circleindex) {
                return Padding(
                  padding: EdgeInsets.all(4),
                  child: CircleAvatar(
                    radius: 4,
                    backgroundColor: circleindex == cardItem.currentIndex
                        ? Color.fromRGBO(2, 139, 107, 0.91)
                        : Color.fromRGBO(141, 161, 156, 0.91),
                  ),
                );
              }),
            ),
            ListTile(
              title: Text(
                cardItem.title,
                style: TextStyle(fontSize: 15),
              ),
              subtitle: Text(
                cardItem.price,
                style: TextStyle(fontSize: 15),
              ),
              trailing: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "Premium",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Carditem {
  final String title;
  final String price;
  final List<String> image;
  int currentIndex;

  Carditem(
      {required this.title,
      required this.price,
      required this.image,
      this.currentIndex = 0});
}
