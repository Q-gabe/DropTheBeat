<h1 align="center">
  <a href="https://github.com/Q-gabe/DropTheBeat"><img src="https://raw.githubusercontent.com/Q-gabe/DropTheBeat/master/preview/Banner.png" alt="Drop The Beat" width="100%"></a>
</h1>
<h3 align="center">Share your audio-spatial experiences, wherever you are.</h3>

<p align="center">
	<a href=""><img src="https://img.shields.io/badge/Devpost-Drop The Beat-informational"></a>
	<a href = "https://flutter.dev/"><img src="https://img.shields.io/badge/Made with-Flutter-23425C?logo=flutter"></a>
	<a href = "https://developers.google.com/maps/documentation"><img src="https://img.shields.io/badge/Powered by-Google Maps-blue?logo=google"></a>
	<a href = "https://flutter.dev/"><img src="https://img.shields.io/badge/Powered by-Spotify-green?logo=spotify"></a>
	<a href = "https://static.mlh.io/docs/mlh-code-of-conduct.pdf"><img src="https://img.shields.io/badge/Code of Conduct-MLH-important"></a>
	<a href = "https://github.com/Q-gabe/DropTheBeat/blob/master/LICENSE"><img src="https://img.shields.io/badge/License-MIT-informational"></a>
</p>

<h4 align="center">A Hack'n'Roll 2020 Project by Team Doki Doki Tanama Club (<a href="https://github.com/Q-gabe">@Q-gabe</a> and <a href="https://github.com/seanlowjk">@seanlowjk</a>). ♫</h4>

## _Drop The Beat_ - Redefining how we share the music we love. :heart:

Ever felt that _serene peace_ during a train ride or on a smooth drive at the hustle and bustle, just listening to your favourite track? Or maybe, that _pulse of adrenaline_ blasting your favourite _EDM_ hits while gaming it out at a LAN shop?

So have we! For [**Hack'n'Roll 2020**](https://hacknroll.nushackers.org/), our team built an application that enables anyone to share that audio-spatial experience with others easily on the go. And so we proudly we present our multi-platform mobile application **Drop The Beat**!

<p align="center">
  <img src="https://raw.githubusercontent.com/Q-gabe/DropTheBeat/master/preview/2Overview_with_Tag.png" width="256" hspace="4">
  <img src="https://raw.githubusercontent.com/Q-gabe/DropTheBeat/master/preview/5Song_Search.png" width="256" hspace="4">
  <img src="https://raw.githubusercontent.com/Q-gabe/DropTheBeat/master/preview/6Song_Entry.png" width="256" hspace="4">
</p>

## Main Features :sparkles:

* **Geolocation-tagging with your favourite songs** :earth_asia:
	* '_Drop_' your songs onto your current location to capture your favourite audio-spatial moment!
* **Share your experience in real-time!** :clock1:
	* _Drops_ are updated with our backend in real-time to share your tags with others instantly!
* **Song search powered by _Spotify_** :musical_note:
	* Choose from the entire 50+ million songs available from _Spotify_ to _drop_!
* **Cross-platform** :iphone:
	* iOS and Android ready!
* **Many more planned features!** :construction_worker::soon:
	* Drop The Beat is currently in development and we hope to bring many more features soon!

## Drop The Beat's Roadmap! :world_map:

* We plan to increase the interactivity of our application with Spotify, so that _Droppers_ can enjoy an even better user experience (Direct linking to songs, album crawling, etc.). 
* We hope to provide a temporary in-app broadcast channel (_DropParties_ :crown:) for Droppers who are in the near vicinity to join, and stream music together! (Think _Silent Disco_ but modular in design!) 
* Our idea banks are full and we are excited to work on the _Drop The Beat_ even further!

## Getting Started :sparkler:
As _Drop The Beat_ is still currently in **very early development**, we have yet to release a build-ready Android apk or Apple app, and as such are using purely debug builds as of right now. This is in-line with our goal of establishing a proof-of-concept of _Drop The Beat_ and making it for the deadline of the [initial hackathon](https://hacknroll.nushackers.org/). As development continues, we hope to be able to ship a full release of the application soon.

However, if you are a developer looking to test the application, here are the steps required to get a debugging environment set up to run our current debug build:
* **1.** Install the **Flutter SDK** according to the [Flutter Installation Guide](https://flutter.dev/docs/get-started/install). Ensure that `flutter doctor -v` shows no errors for the platform that you intend to test on (Android or iOS).
* **2.** Clone this repository and navigate to it on your computer.
* **3.** Follow the instructions as specified in the links below to set up either an emulator or an actual device to run the application in debug mode:
	* **3.1.** [Android Setup](https://flutter.dev/docs/get-started/install/macos#android-setup)
	* **3.2.** [iOS Setup](https://flutter.dev/docs/get-started/install/macos#deploy-to-ios-devices)
* **4.** Running `flutter run` will launch _Drop The Beat_ on your emulator/device. To install a portable debug version of the application on your connected device, ensure the device is connected and run  `flutter install`.

## Development and Contributions :space_invader:
We built _Drop The Beat_ with:
* **Firebase** - Back-end for geolocation tags.
* **Flutter** - Front-end mobile framework using Dart.
* **Google Maps API** - Geolocation Processing.
* **Spotify API** - Song search Processing.

We welcome contributors to work on _Drop The Beat_ together with us! Feel free to make various improvements as you see fit, no matter how small! Changes will be subject to approval however through pull requests.

### Contributors
| :space_invader: Author    | :beer: Roles                          |
|--------------|--------------------------------|
| [Q-gabe](https://github.com/Q-gabe)       | Front-end, API Development, _Flutter Admiral_     |
| [seanlowjk](https://github.com/seanlowjk) | Back-end, API Development, _Baron of Firebase_  |


## Hackathon and Learning Experience :computer:

Click [**here**](https://devpost.com/software/drop-the-beat-cny5o8) for the project's Devpost to learn more about what we went through in the 24 hours in building Drop The Beat!

## License :pencil:

This project is licensed under the MIT License - see the [LICENSE]([https://github.com/Q-gabe/DropTheBeat/blob/master/LICENSE) file for details.
