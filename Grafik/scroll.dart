import 'package:flutter/material.dart';

class Scrool extends StatelessWidget {
  const Scrool({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text("Sliver App Bar"),
            centerTitle: true,
            backgroundColor: Colors.amber,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text("Custom sliver"),
              centerTitle: true,
              background: Image.network(
                "https://www.alaturkadijital.com/images/services/998546131886-9-mobil%20app.jpg",
                fit: BoxFit.cover,
              ),
            ),
            floating: true,
            pinned: true,
            snap: true,
          ),
          SliverFixedExtentList(
            itemExtent: 200,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  height: 200,
                  color: Colors.blue[100 * ++index],
                  child: Center(child: Text("Dinamik bölüm $index")),
                );
              },
              childCount: 8,
            ),
          ),
          SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Container(
                    height: 200,
                    color: Colors.green[50 * ++index],
                    child: Center(
                      child: Text("Dinamik bölüm $index"),
                    ),
                  );
                },
                childCount: 12,
              ),
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3))
        ],
      ),
    );
  }
}
