import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/utils/constants/asset_strings.dart';
import 'package:flutter_application/utils/constants/text_styles.dart';
import 'package:flutter_application/utils/constants/colors.dart';
import 'package:flutter_application/common/widgets/buttons.dart';
import 'package:flutter_application/common/widgets/navbar.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class StoresMapScreen extends StatefulWidget {
  const StoresMapScreen({super.key});

  @override
  State<StoresMapScreen> createState() => _StoresMapScreenState();
}

class _StoresMapScreenState extends State<StoresMapScreen> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white1,
        bottomNavigationBar: const BottomNavBar(selectedOption: 'explore',),
        body: SafeArea(
            child: Column(children: [
          Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(bkg4),
                fit: BoxFit.cover,
              ),
              border: Border(
                bottom: BorderSide(color: red5, width: 3),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(CupertinoIcons.chevron_left,
                          color: red5, size: 32),
                      onPressed: () => Get.back(),
                    ),
                    Text('Stores map', style: h4.copyWith(color: red5)),
                    const SizedBox(width: 32)
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          Expanded(
              child: ListView(children: [
            SizedBox(
              height: 224,
              width: double.infinity,
              child: GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: LatLng(44.4273399636345, 26.08068257372738),
                  zoom: 11.0,
                ),
                markers: {
                  const Marker(
                    markerId: MarkerId('Droplet - AFI Palace Mall'),
                    position: LatLng(44.43152983797006, 26.05229259098059),
                    infoWindow: InfoWindow(title: "Droplet - AFI Palace Mall"),
                  ),
                  const Marker(
                    markerId: MarkerId('Droplet - Baneasa Mall'),
                    position: LatLng(44.50854672800284, 26.0899935831031),
                    infoWindow: InfoWindow(title: "Droplet - Baneasa Mall"),
                  ),
                  const Marker(
                    markerId: MarkerId('Droplet - Mega Mall'),
                    position: LatLng(44.442460032030496, 26.15210379098955),
                    infoWindow: InfoWindow(title: "Droplet - Mega Mall"),
                  ),
                  const Marker(
                    markerId: MarkerId('Droplet - ParkLake Mall'),
                    position: LatLng(44.42122980572285, 26.149534021658777),
                    infoWindow: InfoWindow(title: "Droplet - ParkLake Mall"),
                  ),
                  const Marker(
                    markerId: MarkerId('Droplet - Plaza Romania} Mall'),
                    position: LatLng(44.42908307233006, 26.03462240632193),
                    infoWindow:
                        InfoWindow(title: "Droplet - Plaza Romania Mall"),
                  ),
                  const Marker(
                    markerId: MarkerId('Droplet - Promenada Mall'),
                    position: LatLng(44.478266850935945, 26.10345699101884),
                    infoWindow: InfoWindow(title: "Droplet - Promenada Mall"),
                  ),
                  const Marker(
                    markerId: MarkerId('Droplet - Sun Plaza Mall'),
                    position: LatLng(44.39593681277492, 26.12245247560829),
                    infoWindow: InfoWindow(title: "Droplet - Sun Plaza Mall"),
                  ),
                  const Marker(
                    markerId: MarkerId('Droplet - Unirii Shopping Center'),
                    position: LatLng(44.42885121015347, 26.104513337008164),
                    infoWindow:
                        InfoWindow(title: "Droplet - Unirii Shopping Center"),
                  ),
                },
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                overlayColor: const Color.fromARGB(0, 255, 255, 255),
              ),
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    double latitude;
                    double longitude;
                    String googleUrl;

                    return AlertDialog(
                      insetPadding: const EdgeInsets.all(16),
                      backgroundColor: white1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      shadowColor: blue7dtrans,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(CupertinoIcons.xmark,
                                color: red5, size: 24),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                              width: context.width,
                              child: Text('Droplet\nAfi Palace Mall',
                                  textAlign: TextAlign.center,
                                  style: h5.copyWith(color: black))),
                          //const SizedBox(height: 20),
                        ],
                      ),
                      content: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Monday - Sunday',
                              style: tParagraph.copyWith(color: grey8)),
                          const SizedBox(width: 10),
                          Text('10:00 - 22:00',
                              style: tParagraph.copyWith(color: grey8)),
                          const SizedBox(width: 10),
                          Text('|', style: tParagraph.copyWith(color: black)),
                          const SizedBox(width: 10),
                          now.hour >= 10 && now.hour < 22
                              ? Text('Open',
                                  style: tParagraph.copyWith(color: green))
                              : Text('Closed',
                                  style: tParagraph.copyWith(color: red5)),
                        ],
                      ),
                      actions: <Widget>[
                        Column(children: [
                          //const SizedBox(height: 20),
                          ButtonTypeIcon(
                              text: 'Call 123-456-789',
                              icon: CupertinoIcons.phone,
                              color: red5,
                              type: 'primary',
                              onPressed: () =>
                                  launchUrlString("tel://123456789")),
                          const SizedBox(height: 20),
                          ButtonTypeIcon(
                              text: 'Open in Maps',
                              icon: CupertinoIcons.map,
                              color: blue7,
                              type: 'primary',
                              onPressed: () async => {
                                    latitude = 44.43152983797006,
                                    longitude = 26.05229259098059,
                                    googleUrl =
                                        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
                                    if (await canLaunchUrl(
                                        Uri.parse(googleUrl)))
                                      {await launchUrl(Uri.parse(googleUrl))}
                                    else
                                      {throw 'Could not open the map.'}
                                  })
                        ]),
                      ],
                    );
                  }),
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFB23A48), width: 1))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Droplet - AFI Palace Mall',
                            style: tButton.copyWith(color: black)),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '(1.0 km)',
                          style: tParagraph.copyWith(color: grey8),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text('Monday - Sunday',
                            style: tParagraph.copyWith(color: grey8)),
                        const SizedBox(width: 20),
                        Text('10:00 - 22:00',
                            style: tParagraph.copyWith(color: grey8)),
                        const SizedBox(width: 20),
                        Text('|', style: tParagraph.copyWith(color: black)),
                        const SizedBox(width: 20),
                        now.hour >= 10 && now.hour < 22
                            ? Text('Open',
                                style: tParagraph.copyWith(color: green))
                            : Text('Closed',
                                style: tParagraph.copyWith(color: red5)),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                overlayColor: const Color.fromARGB(0, 255, 255, 255),
              ),
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    double latitude;
                    double longitude;
                    String googleUrl;

                    return AlertDialog(
                      insetPadding: const EdgeInsets.all(16),
                      backgroundColor: white1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      shadowColor: blue7dtrans,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(CupertinoIcons.xmark,
                                color: red5, size: 24),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                              width: context.width,
                              child: Text('Droplet\nPlaza Romania Mall',
                                  textAlign: TextAlign.center,
                                  style: h5.copyWith(color: black))),
                          //const SizedBox(height: 20),
                        ],
                      ),
                      content: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Monday - Sunday',
                              style: tParagraph.copyWith(color: grey8)),
                          const SizedBox(width: 10),
                          Text('12:00 - 22:00',
                              style: tParagraph.copyWith(color: grey8)),
                          const SizedBox(width: 10),
                          Text('|', style: tParagraph.copyWith(color: black)),
                          const SizedBox(width: 10),
                          now.hour >= 12 && now.hour < 22
                              ? Text('Open',
                                  style: tParagraph.copyWith(color: green))
                              : Text('Closed',
                                  style: tParagraph.copyWith(color: red5)),
                        ],
                      ),
                      actions: <Widget>[
                        Column(children: [
                          //const SizedBox(height: 20),
                          ButtonTypeIcon(
                              text: 'Call 123-456-789',
                              icon: CupertinoIcons.phone,
                              color: red5,
                              type: 'primary',
                              onPressed: () =>
                                  launchUrlString("tel://123456789")),
                          const SizedBox(height: 20),
                          ButtonTypeIcon(
                              text: 'Open in Maps',
                              icon: CupertinoIcons.map,
                              color: blue7,
                              type: 'primary',
                              onPressed: () async => {
                                    latitude = 44.42908307233006,
                                    longitude = 26.03462240632193,
                                    googleUrl =
                                        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
                                    if (await canLaunchUrl(
                                        Uri.parse(googleUrl)))
                                      {await launchUrl(Uri.parse(googleUrl))}
                                    else
                                      {throw 'Could not open the map.'}
                                  })
                        ]),
                      ],
                    );
                  }),
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFB23A48), width: 1))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Droplet - Plaza Romania Mall',
                            style: tButton.copyWith(color: black)),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '(1.8 km)',
                          style: tParagraph.copyWith(color: grey8),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text('Monday - Sunday',
                            style: tParagraph.copyWith(color: grey8)),
                        const SizedBox(width: 20),
                        Text('12:00 - 22:00',
                            style: tParagraph.copyWith(color: grey8)),
                        const SizedBox(width: 20),
                        Text('|', style: tParagraph.copyWith(color: black)),
                        const SizedBox(width: 20),
                        now.hour >= 12 && now.hour < 22
                            ? Text('Open',
                                style: tParagraph.copyWith(color: green))
                            : Text('Closed',
                                style: tParagraph.copyWith(color: red5)),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                overlayColor: const Color.fromARGB(0, 255, 255, 255),
              ),
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    double latitude;
                    double longitude;
                    String googleUrl;

                    return AlertDialog(
                      insetPadding: const EdgeInsets.all(16),
                      backgroundColor: white1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      shadowColor: blue7dtrans,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(CupertinoIcons.xmark,
                                color: red5, size: 24),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                              width: context.width,
                              child: Text('Droplet\nUnirii Shopping Center',
                                  textAlign: TextAlign.center,
                                  style: h5.copyWith(color: black))),
                          //const SizedBox(height: 20),
                        ],
                      ),
                      content: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Monday - Sunday',
                              style: tParagraph.copyWith(color: grey8)),
                          const SizedBox(width: 10),
                          Text('10:00 - 22:00',
                              style: tParagraph.copyWith(color: grey8)),
                          const SizedBox(width: 10),
                          Text('|', style: tParagraph.copyWith(color: black)),
                          const SizedBox(width: 10),
                          now.hour >= 10 && now.hour < 22
                              ? Text('Open',
                                  style: tParagraph.copyWith(color: green))
                              : Text('Closed',
                                  style: tParagraph.copyWith(color: red5)),
                        ],
                      ),
                      actions: <Widget>[
                        Column(children: [
                          //const SizedBox(height: 20),
                          ButtonTypeIcon(
                              text: 'Call 123-456-789',
                              icon: CupertinoIcons.phone,
                              color: red5,
                              type: 'primary',
                              onPressed: () =>
                                  launchUrlString("tel://123456789")),
                          const SizedBox(height: 20),
                          ButtonTypeIcon(
                              text: 'Open in Maps',
                              icon: CupertinoIcons.map,
                              color: blue7,
                              type: 'primary',
                              onPressed: () async => {
                                    latitude = 44.42885121015347,
                                    longitude = 26.104513337008164,
                                    googleUrl =
                                        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
                                    if (await canLaunchUrl(
                                        Uri.parse(googleUrl)))
                                      {await launchUrl(Uri.parse(googleUrl))}
                                    else
                                      {throw 'Could not open the map.'}
                                  })
                        ]),
                      ],
                    );
                  }),
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFB23A48), width: 1))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Droplet - Unirii Shopping Center',
                            style: tButton.copyWith(color: black)),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '(5.2 km)',
                          style: tParagraph.copyWith(color: grey8),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text('Monday - Sunday',
                            style: tParagraph.copyWith(color: grey8)),
                        const SizedBox(width: 20),
                        Text('10:00 - 22:00',
                            style: tParagraph.copyWith(color: grey8)),
                        const SizedBox(width: 20),
                        Text('|', style: tParagraph.copyWith(color: black)),
                        const SizedBox(width: 20),
                        now.hour >= 10 && now.hour < 22
                            ? Text('Open',
                                style: tParagraph.copyWith(color: green))
                            : Text('Closed',
                                style: tParagraph.copyWith(color: red5)),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                overlayColor: const Color.fromARGB(0, 255, 255, 255),
              ),
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    double latitude;
                    double longitude;
                    String googleUrl;

                    return AlertDialog(
                      insetPadding: const EdgeInsets.all(16),
                      backgroundColor: white1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      shadowColor: blue7dtrans,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(CupertinoIcons.xmark,
                                color: red5, size: 24),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                              width: context.width,
                              child: Text('Droplet\nPromenada Mall',
                                  textAlign: TextAlign.center,
                                  style: h5.copyWith(color: black))),
                          //const SizedBox(height: 20),
                        ],
                      ),
                      content: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Monday - Sunday',
                              style: tParagraph.copyWith(color: grey8)),
                          const SizedBox(width: 10),
                          Text('11:00 - 22:00',
                              style: tParagraph.copyWith(color: grey8)),
                          const SizedBox(width: 10),
                          Text('|', style: tParagraph.copyWith(color: black)),
                          const SizedBox(width: 10),
                          now.hour >= 11 && now.hour < 22
                              ? Text('Open',
                                  style: tParagraph.copyWith(color: green))
                              : Text('Closed',
                                  style: tParagraph.copyWith(color: red5)),
                        ],
                      ),
                      actions: <Widget>[
                        Column(children: [
                          //const SizedBox(height: 20),
                          ButtonTypeIcon(
                              text: 'Call 123-456-789',
                              icon: CupertinoIcons.phone,
                              color: red5,
                              type: 'primary',
                              onPressed: () =>
                                  launchUrlString("tel://123456789")),
                          const SizedBox(height: 20),
                          ButtonTypeIcon(
                              text: 'Open in Maps',
                              icon: CupertinoIcons.map,
                              color: blue7,
                              type: 'primary',
                              onPressed: () async => {
                                    latitude = 44.478266850935945,
                                    longitude = 26.10345699101884,
                                    googleUrl =
                                        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
                                    if (await canLaunchUrl(
                                        Uri.parse(googleUrl)))
                                      {await launchUrl(Uri.parse(googleUrl))}
                                    else
                                      {throw 'Could not open the map.'}
                                  })
                        ]),
                      ],
                    );
                  }),
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFB23A48), width: 1))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Droplet - Promenada Mall',
                            style: tButton.copyWith(color: black)),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '(8.0 km)',
                          style: tParagraph.copyWith(color: grey8),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text('Monday - Sunday',
                            style: tParagraph.copyWith(color: grey8)),
                        const SizedBox(width: 20),
                        Text('11:00 - 22:00',
                            style: tParagraph.copyWith(color: grey8)),
                        const SizedBox(width: 20),
                        Text('|', style: tParagraph.copyWith(color: black)),
                        const SizedBox(width: 20),
                        now.hour >= 11 && now.hour < 22
                            ? Text('Open',
                                style: tParagraph.copyWith(color: green))
                            : Text('Closed',
                                style: tParagraph.copyWith(color: red5)),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                overlayColor: const Color.fromARGB(0, 255, 255, 255),
              ),
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    double latitude;
                    double longitude;
                    String googleUrl;

                    return AlertDialog(
                      insetPadding: const EdgeInsets.all(16),
                      backgroundColor: white1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      shadowColor: blue7dtrans,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(CupertinoIcons.xmark,
                                color: red5, size: 24),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                              width: context.width,
                              child: Text('Droplet\nSun Plaza Mall',
                                  textAlign: TextAlign.center,
                                  style: h5.copyWith(color: black))),
                          //const SizedBox(height: 20),
                        ],
                      ),
                      content: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Monday - Sunday',
                              style: tParagraph.copyWith(color: grey8)),
                          const SizedBox(width: 10),
                          Text('10:00 - 22:00',
                              style: tParagraph.copyWith(color: grey8)),
                          const SizedBox(width: 10),
                          Text('|', style: tParagraph.copyWith(color: black)),
                          const SizedBox(width: 10),
                          now.hour >= 10 && now.hour < 22
                              ? Text('Open',
                                  style: tParagraph.copyWith(color: green))
                              : Text('Closed',
                                  style: tParagraph.copyWith(color: red5)),
                        ],
                      ),
                      actions: <Widget>[
                        Column(children: [
                          //const SizedBox(height: 20),
                          ButtonTypeIcon(
                              text: 'Call 123-456-789',
                              icon: CupertinoIcons.phone,
                              color: red5,
                              type: 'primary',
                              onPressed: () =>
                                  launchUrlString("tel://123456789")),
                          const SizedBox(height: 20),
                          ButtonTypeIcon(
                              text: 'Open in Maps',
                              icon: CupertinoIcons.map,
                              color: blue7,
                              type: 'primary',
                              onPressed: () async => {
                                    latitude = 44.39593681277492,
                                    longitude = 26.12245247560829,
                                    googleUrl =
                                        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
                                    if (await canLaunchUrl(
                                        Uri.parse(googleUrl)))
                                      {await launchUrl(Uri.parse(googleUrl))}
                                    else
                                      {throw 'Could not open the map.'}
                                  })
                        ]),
                      ],
                    );
                  }),
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFB23A48), width: 1))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Droplet - Sun Plaza Mall',
                            style: tButton.copyWith(color: black)),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '(8.8 km)',
                          style: tParagraph.copyWith(color: grey8),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text('Monday - Sunday',
                            style: tParagraph.copyWith(color: grey8)),
                        const SizedBox(width: 20),
                        Text('10:00 - 22:00',
                            style: tParagraph.copyWith(color: grey8)),
                        const SizedBox(width: 20),
                        Text('|', style: tParagraph.copyWith(color: black)),
                        const SizedBox(width: 20),
                        now.hour >= 10 && now.hour < 22
                            ? Text('Open',
                                style: tParagraph.copyWith(color: green))
                            : Text('Closed',
                                style: tParagraph.copyWith(color: red5)),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                overlayColor: const Color.fromARGB(0, 255, 255, 255),
              ),
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    double latitude;
                    double longitude;
                    String googleUrl;

                    return AlertDialog(
                      insetPadding: const EdgeInsets.all(16),
                      backgroundColor: white1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      shadowColor: blue7dtrans,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(CupertinoIcons.xmark,
                                color: red5, size: 24),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                              width: context.width,
                              child: Text('Droplet\nMega Mall',
                                  textAlign: TextAlign.center,
                                  style: h5.copyWith(color: black))),
                          //const SizedBox(height: 20),
                        ],
                      ),
                      content: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Monday - Sunday',
                              style: tParagraph.copyWith(color: grey8)),
                          const SizedBox(width: 10),
                          Text('10:00 - 22:00',
                              style: tParagraph.copyWith(color: grey8)),
                          const SizedBox(width: 10),
                          Text('|', style: tParagraph.copyWith(color: black)),
                          const SizedBox(width: 10),
                          now.hour >= 10 && now.hour < 22
                              ? Text('Open',
                                  style: tParagraph.copyWith(color: green))
                              : Text('Closed',
                                  style: tParagraph.copyWith(color: red5)),
                        ],
                      ),
                      actions: <Widget>[
                        Column(children: [
                          ButtonTypeIcon(
                              text: 'Call 123-456-789',
                              icon: CupertinoIcons.phone,
                              color: red5,
                              type: 'primary',
                              onPressed: () =>
                                  launchUrlString("tel://123456789")),
                          const SizedBox(height: 20),
                          ButtonTypeIcon(
                              text: 'Open in Maps',
                              icon: CupertinoIcons.map,
                              color: blue7,
                              type: 'primary',
                              onPressed: () async => {
                                    latitude = 44.442460032030496,
                                    longitude = 26.15210379098955,
                                    googleUrl =
                                        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
                                    if (await canLaunchUrl(
                                        Uri.parse(googleUrl)))
                                      {await launchUrl(Uri.parse(googleUrl))}
                                    else
                                      {throw 'Could not open the map.'}
                                  })
                        ]),
                      ],
                    );
                  }),
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFB23A48), width: 1))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Droplet - Mega Mall',
                            style: tButton.copyWith(color: black)),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '(9.0 km)',
                          style: tParagraph.copyWith(color: grey8),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text('Monday - Sunday',
                            style: tParagraph.copyWith(color: grey8)),
                        const SizedBox(width: 20),
                        Text('10:00 - 22:00',
                            style: tParagraph.copyWith(color: grey8)),
                        const SizedBox(width: 20),
                        Text('|', style: tParagraph.copyWith(color: black)),
                        const SizedBox(width: 20),
                        now.hour >= 10 && now.hour < 22
                            ? Text('Open',
                                style: tParagraph.copyWith(color: green))
                            : Text('Closed',
                                style: tParagraph.copyWith(color: red5)),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                overlayColor: const Color.fromARGB(0, 255, 255, 255),
              ),
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    double latitude;
                    double longitude;
                    String googleUrl;

                    return AlertDialog(
                      insetPadding: const EdgeInsets.all(16),
                      backgroundColor: white1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      shadowColor: blue7dtrans,
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(CupertinoIcons.xmark,
                                color: red5, size: 24),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          SizedBox(
                              width: context.width,
                              child: Text('Droplet\nPark Lake Mall',
                                  textAlign: TextAlign.center,
                                  style: h5.copyWith(color: black))),
                          //const SizedBox(height: 20),
                        ],
                      ),
                      content: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Monday - Sunday',
                              style: tParagraph.copyWith(color: grey8)),
                          const SizedBox(width: 10),
                          Text('11:00 - 22:00',
                              style: tParagraph.copyWith(color: grey8)),
                          const SizedBox(width: 10),
                          Text('|', style: tParagraph.copyWith(color: black)),
                          const SizedBox(width: 10),
                          now.hour >= 11 && now.hour < 22
                              ? Text('Open',
                                  style: tParagraph.copyWith(color: green))
                              : Text('Closed',
                                  style: tParagraph.copyWith(color: red5)),
                        ],
                      ),
                      actions: <Widget>[
                        Column(children: [
                          //const SizedBox(height: 20),
                          ButtonTypeIcon(
                              text: 'Call 123-456-789',
                              icon: CupertinoIcons.phone,
                              color: red5,
                              type: 'primary',
                              onPressed: () =>
                                  launchUrlString("tel://123456789")),
                          const SizedBox(height: 20),
                          ButtonTypeIcon(
                              text: 'Open in Maps',
                              icon: CupertinoIcons.map,
                              color: blue7,
                              type: 'primary',
                              onPressed: () async => {
                                    latitude = 44.42122980572285,
                                    longitude = 26.149534021658777,
                                    googleUrl =
                                        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
                                    if (await canLaunchUrl(
                                        Uri.parse(googleUrl)))
                                      {await launchUrl(Uri.parse(googleUrl))}
                                    else
                                      {throw 'Could not open the map.'}
                                  })
                        ]),
                      ],
                    );
                  }),
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                        bottom:
                            BorderSide(color: Color(0xFFB23A48), width: 1))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Droplet - ParkLake Mall',
                            style: tButton.copyWith(color: black)),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          '(9.4 km)',
                          style: tParagraph.copyWith(color: grey8),
                        )
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text('Monday - Sunday',
                            style: tParagraph.copyWith(color: grey8)),
                        const SizedBox(width: 20),
                        Text('11:00 - 22:00',
                            style: tParagraph.copyWith(color: grey8)),
                        const SizedBox(width: 20),
                        Text('|', style: tParagraph.copyWith(color: black)),
                        const SizedBox(width: 20),
                        now.hour >= 11 && now.hour < 22
                            ? Text('Open',
                                style: tParagraph.copyWith(color: green))
                            : Text('Closed',
                                style: tParagraph.copyWith(color: red5)),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  overlayColor: const Color.fromARGB(0, 255, 255, 255),
                ),
                onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      double latitude;
                      double longitude;
                      String googleUrl;

                      return AlertDialog(
                        insetPadding: const EdgeInsets.all(16),
                        backgroundColor: white1,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        shadowColor: blue7dtrans,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(CupertinoIcons.xmark,
                                  color: red5, size: 24),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            SizedBox(
                                width: context.width,
                                child: Text('Droplet\nBaneasa Mall',
                                    textAlign: TextAlign.center,
                                    style: h5.copyWith(color: black))),
                            //const SizedBox(height: 20),
                          ],
                        ),
                        content: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Monday - Sunday',
                                style: tParagraph.copyWith(color: grey8)),
                            const SizedBox(width: 10),
                            Text('11:00 - 22:00',
                                style: tParagraph.copyWith(color: grey8)),
                            const SizedBox(width: 10),
                            Text('|', style: tParagraph.copyWith(color: black)),
                            const SizedBox(width: 10),
                            now.hour >= 11 && now.hour < 22
                                ? Text('Open',
                                    style: tParagraph.copyWith(color: green))
                                : Text('Closed',
                                    style: tParagraph.copyWith(color: red5)),
                          ],
                        ),
                        actions: <Widget>[
                          Column(children: [
                            //const SizedBox(height: 20),
                            ButtonTypeIcon(
                                text: 'Call 123-456-789',
                                icon: CupertinoIcons.phone,
                                color: red5,
                                type: 'primary',
                                onPressed: () =>
                                    launchUrlString("tel://123456789")),
                            const SizedBox(height: 20),
                            ButtonTypeIcon(
                                text: 'Open in Maps',
                                icon: CupertinoIcons.map,
                                color: blue7,
                                type: 'primary',
                                onPressed: () async => {
                                      latitude = 44.50854672800284,
                                      longitude = 26.0899935831031,
                                      googleUrl =
                                          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude',
                                      if (await canLaunchUrl(
                                          Uri.parse(googleUrl)))
                                        {await launchUrl(Uri.parse(googleUrl))}
                                      else
                                        {throw 'Could not open the map.'}
                                    })
                          ]),
                        ],
                      );
                    }),
                child: Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Color(0xFFB23A48), width: 1))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Droplet - Baneasa Mall',
                                  style: tButton.copyWith(color: black)),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                '(11.0 km)',
                                style: tParagraph.copyWith(color: grey8),
                              )
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Text('Monday - Sunday',
                                  style: tParagraph.copyWith(color: grey8)),
                              const SizedBox(width: 20),
                              Text('11:00 - 22:00',
                                  style: tParagraph.copyWith(color: grey8)),
                              const SizedBox(width: 20),
                              Text('|',
                                  style: tParagraph.copyWith(color: black)),
                              const SizedBox(width: 20),
                              now.hour >= 11 && now.hour < 22
                                  ? Text('Open',
                                      style: tParagraph.copyWith(color: green))
                                  : Text('Closed',
                                      style: tParagraph.copyWith(color: red5)),
                            ],
                          ),
                          const SizedBox(height: 12),
                        ])))
          ]))
        ])));
  }
}
