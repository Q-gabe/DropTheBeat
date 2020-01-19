import 'dart:async';
import 'package:flutter/material.dart';
import 'package:spotify/spotify_io.dart' as spotify;
import 'song.dart';

class CustomSearchDelegate extends SearchDelegate {
  final credentials = new spotify.SpotifyApiCredentials(
      "a6911ee455964cb78f03df7c5035bdad", "402d20133197438da9994dbad86fbb93");

  
  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return ThemeData.dark().copyWith(
      primaryColor: Colors.black,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.light,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Guard function: query too short! (len <= 2)
    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container (
            color: Colors.black,
            child: Center(
            child: Text(
              "Search term must be longer than two letters.",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),),
        ],
      );
    }

    return new FutureBuilder(
      future: _search(query),
      builder: (context, AsyncSnapshot<List<Song>> snapshot) {
        if (!snapshot.hasData) return new Container();
        List<Song> content = snapshot.data;
        if (content.length == 0) {
          return Column(children: <Widget>[Container(
            color: Colors.black,
            child: Text("No Results Found.",
            style: TextStyle(fontSize: 16, color: Colors.white),),
          )
          ]);
        } else {
          return new Container(
            color: Colors.black,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: content.length,
              itemBuilder: (context, index) {
                return new Container(
                  alignment: FractionalOffset.center,
                  child: new GestureDetector(
                    onTap: () => 
                      this.close(context, content[index]), // return to main app
                    child: content[index].returnSongWidget()
                    ),
                );
              }),);
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }

  Future<List<Song>> _search(String search) async {
    return _startSearch(search);
  }

  Future<List<Song>> _startSearch(String text) async {
    var spotifyAPI = new spotify.SpotifyApi(credentials);
    List<Song> songs = new List();

    var search = await spotifyAPI.search
        .get(text)
        .first(10) // get First 10 Results
        .catchError((err) => print((err as spotify.SpotifyException).message));

    search.forEach((pages) {
      pages.items.forEach((item) {
        if (item is spotify.Track) {
          Set<String> artistList = new Set();
          item.artists.forEach((artist) => artistList.add(artist.name));
          Song song = new Song(
              item.name, item.href, item.album.images[0].url, artistList);
          songs.add(song);
        }
      });
    });

    return songs;
  }
}
