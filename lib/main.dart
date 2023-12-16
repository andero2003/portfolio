import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:http/http.dart' as http;

import 'dart:math';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int currentPageIndex = 0;

  PageController _pageController = PageController();

  List<LinearGradient> _backgroundGradients = [
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color.fromARGB(255, 11, 26, 73), const Color.fromARGB(255, 20, 82, 133)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Color.fromARGB(255, 14, 78, 94), Color.fromARGB(255, 5, 94, 79)],
    ),
    LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.blueGrey.shade800, Colors.blueGrey.shade400],
    ),
  ];
  var views = <Widget>[HomeScreen(), AboutScreen(), ProjectsScreen()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue, textTheme: GoogleFonts.ptMonoTextTheme()),
      darkTheme:
          ThemeData.dark(useMaterial3: true).copyWith(textTheme: Typography().white.apply(fontFamily: GoogleFonts.ptMono().fontFamily)),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 250),
              decoration: BoxDecoration(
                gradient: _backgroundGradients[currentPageIndex],
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color.fromARGB(255, 146, 146, 146), width: 2),
                          borderRadius: BorderRadius.circular(16)),
                    ),
                    PageView(
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            currentPageIndex = index;
                          });
                        },
                        children: views),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                _pageController.animateToPage(
                                  0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Text("Home",
                                  style: TextStyle(
                                      color: currentPageIndex == 0 ? const Color.fromARGB(255, 59, 104, 228) : Colors.white,
                                      fontSize: 24))),
                          SizedBox(width: 16),
                          TextButton(
                              onPressed: () {
                                _pageController.animateToPage(
                                  1,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Text("About",
                                  style: TextStyle(
                                      color: currentPageIndex == 1 ? const Color.fromARGB(255, 59, 104, 228) : Colors.white,
                                      fontSize: 24))),
                          SizedBox(width: 16),
                          TextButton(
                              onPressed: () {
                                _pageController.animateToPage(
                                  2,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: Text("Projects",
                                  style: TextStyle(
                                      color: currentPageIndex == 2 ? const Color.fromARGB(255, 59, 104, 228) : Colors.white,
                                      fontSize: 24))),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isTallDevice = MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;
    return isTallDevice
        ? Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
            MyAvatar(),
            const SizedBox(height: 40),
            MyInformation(
              isTallDevice: isTallDevice,
            )
          ])
        : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MyAvatar(),
            const SizedBox(width: 40),
            MyInformation(
              isTallDevice: isTallDevice,
            )
          ]);
  }
}

class MyInformation extends StatelessWidget {
  final bool isTallDevice;
  const MyInformation({
    super.key,
    required this.isTallDevice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: isTallDevice ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          'Andero Lavrinenko',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Software Engineer',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          'Game Developer',
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 8),
        Row(
          //social media buttons
          mainAxisAlignment: isTallDevice ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(FontAwesomeIcons.github),
              onPressed: () async {
                final Uri params = Uri(
                  scheme: 'https',
                  host: 'github.com',
                  path: '/andero2003',
                );

                if (await canLaunchUrl(params)) {
                  await launchUrl(params);
                }
              },
            ),
            IconButton(
              icon: const Icon(FontAwesomeIcons.linkedin),
              onPressed: () async {
                //open linkedin
                final Uri params = Uri(
                  scheme: 'https',
                  host: 'www.linkedin.com',
                  path: '/in/andero-l-97a327269/',
                );

                if (await canLaunchUrl(params)) {
                  await launchUrl(params);
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.mail),
              onPressed: () async {
                //open mail app
                final Uri params = Uri(
                  scheme: 'mailto',
                  path: 'andero2003@gmail.com',
                );

                if (await canLaunchUrl(params)) {
                  await launchUrl(params);
                }
              },
            ),
          ],
        )
      ],
    );
  }
}

class MyAvatar extends StatelessWidget {
  const MyAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 140,
      backgroundColor: Colors.transparent,
      child: ClipOval(
        child: Image.network(
          'https://cdn.discordapp.com/attachments/701919732563181679/1183444071012913272/image.png?ex=65885b2d&is=6575e62d&hm=93d85978bd512c76d661ccf3077b4586b7a38e247c0191945b974abf1f7e8912&',
          width: 280,
          height: 280,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    SizedBox(height: 64),
                    CircleTextRow(
                      imageRight: true,
                      title: "About Me",
                      text:
                          "I'm a passionate software engineer and an innovative Roblox game developer. My journey in technology began early and has since evolved into a thriving career marked by creativity, problem-solving, and a relentless pursuit of learning.",
                      image:
                          "https://cdn.discordapp.com/attachments/729246776443273217/1027696439461171313/unknown.png?ex=6584b064&is=65723b64&hm=2ab70059afc4553ce2ccc4bfb5f55cfac4cdf0cd49c4c94c011297e89b790487&",
                    ),
                    CircleTextRow(
                      title: "Education",
                      text:
                          "I'm an alumnus of Gustav Adolf Grammar School in Tallinn, Estonia, where I graduated with a gold medal in 2022. Currently, I'm expanding my tech expertise at the University of Portsmouth, working towards a BSc in Computer Science, set to complete in 2026.",
                      image: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/47/e3/ef/gunwharf-quays.jpg?w=500&h=400&s=1&",
                    ),
                    CircleTextRow(
                        imageRight: true,
                        title: 'Skills',
                        text:
                            'My main toolkit includes Lua, Dart/Flutter, Firestore, Python, C#, pSQL, and JavaScript/TypeScript. As the technical lead in most projects, I\'ve demonstrated a keen ability for making critical technical decisions, managing team dynamics, and fostering effective communication. I also excel in problem solving, and find myself mentoring peers and helping them navigate coding issues efficiently.',
                        image: 'https://cdn.discordapp.com/attachments/701919732563181679/1184943174536417450/image.png'),
                    CircleTextRow(
                      title: "Roblox Career",
                      text:
                          "Since 2016, I have been actively involved in freelance Roblox game development, founding Obby Empire Productions, a studio that has garnered over 200M plays. I am the lead programmer of the newly-released Balloon Simulator. I'm also interested in combining Roblox development with external tools and languages to innovate new solutions for game devs.",
                      image: "https://tr.rbxcdn.com/45dfdb60b5f99e2ce1891d2e10d84d4c/420/420/Image/Png",
                    ),
                    CircleTextRow(
                      imageRight: true,
                      title: "Me Outside of Tech",
                      text:
                          "When I'm not coding, you'll find me experimenting with recipes in the kitchen, exploring new destinations, strumming my guitar, or engaging in a friendly match of tennis or football. I also have a deep interest in mathematics, which often intersects with my professional pursuits.",
                      image:
                          "https://cdn.discordapp.com/attachments/701919732563181679/1184490087749275648/IMG-20230911-WA0020.jpg?ex=658c295b&is=6579b45b&hm=2e5bd819010e6eb48be040e9bb2d9b818ae7f86e3f3dda7c8f8ea3a7ab5d470d&",
                    ),
                  ],
                ),
              ),
            ),
            ScrollDownIndicator(
              controller: _scrollController,
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollDownIndicator extends StatefulWidget {
  final ScrollController controller;

  ScrollDownIndicator({required this.controller});

  @override
  State<ScrollDownIndicator> createState() => _ScrollDownIndicatorState();
}

class _ScrollDownIndicatorState extends State<ScrollDownIndicator> {
  bool _showIndicator = true;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_scrollListener);
  }

  _scrollListener() {
    if (widget.controller.position.atEdge) {
      if (widget.controller.position.pixels == 0) {
        // You're at the top.
      } else {
        // You're at the bottom.
        setState(() {
          _showIndicator = false;
        });
      }
    } else {
      setState(() {
        _showIndicator = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _showIndicator
        ? Positioned(
            bottom: 20.0,
            left: 0.0,
            right: 0.0,
            child: Center(
              child: IconButton(
                onPressed: () {
                  widget.controller.animateTo(
                    widget.controller.position.maxScrollExtent,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                icon: Icon(
                  FontAwesomeIcons.arrowDown,
                  color: Colors.white,
                  size: 36.0,
                ),
              ),
            ),
          )
        : Container();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.controller.removeListener(_scrollListener);
    super.dispose();
  }
}

class CircleTextRow extends StatelessWidget {
  final String title;
  final String text;
  final String image;
  final bool imageRight;

  const CircleTextRow({super.key, required this.title, required this.text, required this.image, this.imageRight = false});

  @override
  Widget build(BuildContext context) {
    final isTallDevice = MediaQuery.of(context).size.height > MediaQuery.of(context).size.width;

    return Expanded(
      child: isTallDevice
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildCircleAvatar(),
                const SizedBox(height: 40),
                buildTextColumn(context),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: imageRight
                  ? <Widget>[
                      buildTextColumn(context),
                      const SizedBox(width: 40),
                      buildCircleAvatar(),
                    ]
                  : <Widget>[
                      buildCircleAvatar(),
                      const SizedBox(width: 40),
                      buildTextColumn(context),
                    ],
            ),
    );
  }

  Widget buildCircleAvatar() {
    return CircleAvatar(
      radius: 140,
      backgroundColor: Colors.transparent,
      child: ClipOval(
        child: Image.network(
          image,
          width: 240,
          height: 240,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget buildTextColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? 2.5 : 1.25),
          height: MediaQuery.of(context).size.width > MediaQuery.of(context).size.height ? null : 200,
          child: Text(
            text,
            style: TextStyle(fontSize: 15),
          ),
        )
      ],
    );
  }
}

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ratio = MediaQuery.of(context).size.height / MediaQuery.of(context).size.width;
    return Center(
      child: FractionallySizedBox(
          widthFactor: 0.65,
          heightFactor: 0.75,
          alignment: Alignment.topCenter,
          child: GridView.count(
              crossAxisCount: ratio > 1 ? 1 : (ratio > 0.75 ? 2 : 3),
              childAspectRatio: 1.25,
              clipBehavior: Clip.none,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                ProjectCard(
                  title: 'Balloon Simulator',
                  description:
                      'My most recent successful project, I made this game in about 10 days in the summer of 2023. Afterwards we kept updating and polishing it over the course of a few months, and it has now reached 30M+ visits.',
                  mediaWidget: Image.network(
                      'https://cdn.discordapp.com/attachments/990339971040821258/1130589877600276540/Ball_Earth_Thumb.jpg?ex=6589df60&is=65776a60&hm=0f63336d7cf73f857bad504533a7302ed628c51678b944e16bcf3bc58c00d5ff',
                      width: double.infinity),
                  onTap: () async {
                    final Uri params = Uri(
                      scheme: 'https',
                      host: 'www.roblox.com',
                      path: '/games/13814171092/',
                    );

                    if (await canLaunchUrl(params)) {
                      await launchUrl(params);
                    }
                  },
                ),
                ProjectCard(
                  title: 'Bouncy Castle Obby!',
                  description: 'My first game that truly took off in 2021, reaching 100M+ visits in a few months.',
                  mediaWidget:
                      Image.network('https://tr.rbxcdn.com/1d3a1721a2d606ddbfa4d4c0a4c604f9/768/432/Image/Png', width: double.infinity),
                  onTap: () async {
                    final Uri params = Uri(
                      scheme: 'https',
                      host: 'www.roblox.com',
                      path: '/games/6944713557/',
                    );

                    if (await canLaunchUrl(params)) {
                      await launchUrl(params);
                    }
                  },
                ),
                ProjectCard(
                  title: 'Spaceship Simulator',
                  description: 'One of my earlier projects.',
                  mediaWidget:
                      Image.network('https://tr.rbxcdn.com/db25d76d4d1c8288ea1dc103a00d7218/768/432/Image/Png', width: double.infinity),
                  onTap: () async {
                    final Uri params = Uri(
                      scheme: 'https',
                      host: 'www.roblox.com',
                      path: '/games/3132870038/',
                    );

                    if (await canLaunchUrl(params)) {
                      await launchUrl(params);
                    }
                  },
                ),
                ProjectCard(
                  title: 'Hacker Simulator',
                  description:
                      'A side project I made together with AlvinBlox. For now, the game is still pretty far from done, as we both had other commitments come up. We\'ll hopefully get back to it eventually though, as the gameplay is pretty exciting and has a lot of potential.',
                  mediaWidget:
                      Image.network('https://tr.rbxcdn.com/9a511620bd22757abe7efccd566c6a0d/768/432/Image/Png', width: double.infinity),
                  onTap: () async {
                    final Uri params = Uri(
                      scheme: 'https',
                      host: 'www.roblox.com',
                      path: '/games/13006516178/',
                    );

                    if (await canLaunchUrl(params)) {
                      await launchUrl(params);
                    }
                  },
                ),
                ProjectCard(
                  title: 'Monte Carlo Simulation Engine',
                  description:
                      'Making a ton of Excel sheets to balance my Roblox games was getting tedious, and they don\'t account for randomness. So I made this simulation framework that allows me to the model the game logic and economy in a simple way. It is designed to simulate the activities of any number of players over varying durations, ensuring a more efficient and realistic representation of in-game dynamics',
                  mediaWidget: Image.network('https://cdn.discordapp.com/attachments/729246776443273217/1183769846052311130/image.png',
                      width: double.infinity),
                  icon: FontAwesomeIcons.youtube,
                  onTap: () async {
                    final Uri params = Uri(
                      scheme: 'https',
                      host: 'www.youtube.com',
                      path: '/watch',
                      queryParameters: {'v': '08wo9UIDsjU'},
                    );

                    if (await canLaunchUrl(params)) {
                      await launchUrl(params);
                    }
                  },
                ),
                ProjectCard(
                  title: 'Roblox Integrated Project Management Tool',
                  description:
                      'Something I made as part of my university coursework. It uses the Roblox OAuth 2.0 service and Roblox APIs to seamlessly fetch user\'s games and set up projects for them. Uses Firestore to store the project data, keeping it in sync for all team members.',
                  mediaWidget: Image.network('https://cdn.discordapp.com/attachments/701919732563181679/1184963876496887889/image.png',
                      width: double.infinity),
                  icon: FontAwesomeIcons.youtube,
                  onTap: () async {
                    final Uri params = Uri(
                      scheme: 'https',
                      host: 'www.youtube.com',
                      path: '/watch',
                      queryParameters: {'v': 'M93K2t38zc0'},
                    );

                    if (await canLaunchUrl(params)) {
                      await launchUrl(params);
                    }
                  },
                ),
              ])),
    );
  }
}

class ClickableCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const ClickableCard({Key? key, required this.child, required this.onTap}) : super(key: key);

  @override
  _ClickableCardState createState() => _ClickableCardState();
}

class _ClickableCardState extends State<ClickableCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: MaterialStateMouseCursor.clickable,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          transformAlignment: Alignment.center,
          transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
          child: widget.child,
        ),
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget mediaWidget;
  final IconData icon;
  final VoidCallback onTap;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.mediaWidget,
    required this.onTap,
    this.icon = FontAwesomeIcons.gamepad,
  });

  @override
  Widget build(BuildContext context) {
    return ClickableCard(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            opaque: false,
            barrierDismissible: true,
            pageBuilder: (BuildContext context, _, __) {
              return ProjectScreen(
                title: title,
                mediaWidget: mediaWidget,
                description: description,
                icon: icon,
                onTap: onTap,
              );
            }));
      },
      child: Card(
        elevation: 10,
        color: Color.fromARGB(255, 9, 6, 29),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(16)),
              child: Hero(tag: 'hero-$title', child: mediaWidget),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 4),
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({
    super.key,
    required this.title,
    required this.mediaWidget,
    required this.description,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final Widget mediaWidget;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black.withOpacity(0.8),
        child: Center(
          child: Hero(
            tag: "hero-$title",
            child: Container(
              width: min(600, MediaQuery.of(context).size.width),
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 39, 39, 39),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.75,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12)),
                            child: mediaWidget),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              title,
                              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16),
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              description,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(icon == FontAwesomeIcons.youtube
                                      ? Color.fromARGB(255, 162, 0, 0)
                                      : Color.fromARGB(255, 59, 104, 228)),
                                ),
                                onPressed: onTap,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        icon,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(width: 20),
                                      const Material(
                                        color: Colors.transparent,
                                        child: Text(
                                          "Open",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // child: Image.network(
            //   image,
            //   width: 500,
            //   fit: BoxFit.contain,
            // ),
          ),
        ),
      ),
    );
  }
}
