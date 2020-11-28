import 'package:flutter/material.dart';

class CollectionScreen extends StatefulWidget {
  final String title;
  final Function onLoad;
  final List media;

  const CollectionScreen({
    Key key,
    @required this.title,
    @required this.onLoad,
    this.media,
  }) : super(key: key);
  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  ScrollController _scrollController;
  int page = 1;
  bool isLoading = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!isLoading) {
          setState(() {
            isLoading = true;
            page++;
            widget.onLoad(context, page);
          });
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: GridView.builder(
        controller: _scrollController,
        padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        itemCount: widget.media.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          isLoading = false;
          return Container(
            height: 180,
            margin: EdgeInsets.only(right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://image.tmdb.org/t/p/w300/${widget.media[index].posterPath}',
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}