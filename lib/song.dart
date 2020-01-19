import 'package:flutter/material.dart';

class Song {
  String name;
  String href;
  String imageUrl;
  Set<String> artistNames;

  Song(String name, String href, String imageUrl, Set<String> artistNames) {
    this.name = name.trim();
    this.href = href;
    this.imageUrl = imageUrl;
    this.artistNames = artistNames;
  }

  ///
  /// A single song bar widget
  ///
  Widget returnSongWidget() {
    return Card(
        elevation: 5.0,
        color: Colors.grey,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // Album Picture
            Image.network(
              imageUrl, 
              height: 65, 
              width: 65),
            // Spacer
            Container (width: 10, height: 1),
            // Track title, Artist(s)
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //TITLE
                Text(name, 
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700
                ),
                //textAlign: TextAlign.left,
                ),
                //ARTISTS
                Text(parseArtists(), 
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.left,
                ),
              ],
            ) 
          ],
        )
        
      );
  }

  String parseArtists() {
    String artists = "";
    if (artistNames.length == 1) {
      for (name in artistNames) {
        return name.trim();
      }
    }

    for (name in artistNames) {
      artists += name.trim();
      artists += "; ";
    }
    return artists.trim();
  }
}
