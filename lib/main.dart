import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

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
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      CircleAvatar(
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
      ),
      const SizedBox(width: 40),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Andero Lavrinenko',
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
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
      )
    ]);
  }
}

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
                  "My academic path at the Gustav Adolf Grammar School laid the foundation for my technical pursuits, culminating in a gold medal for academic excellence. Currently, I am enriching my knowledge and skills at the University of Portsmouth, pursuing a BSc in Computer Science.",
              image: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/1c/47/e3/ef/gunwharf-quays.jpg?w=500&h=400&s=1&",
            ),
            CircleTextRow(
              imageRight: true,
              title: "Professional Path",
              text:
                  "Since 2016, I have been actively involved in freelance Roblox game development, founding Obby Empire Productions, a studio that has garnered over 200M plays. I am the lead programmer of Balloon Simulator and the creator of Spaceship Simulator, projects that reflect my commitment to engaging and innovative game design.",
              image: "https://tr.rbxcdn.com/45dfdb60b5f99e2ce1891d2e10d84d4c/420/420/Image/Png",
            ),
          ],
        ),
      ),
    );
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
    return Expanded(
      child: Row(
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
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.5,
          child: Text(
            text,
            style: TextStyle(fontSize: 16),
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
    return Center(
      child: FractionallySizedBox(
          widthFactor: 0.65,
          heightFactor: 0.75,
          alignment: Alignment.topCenter,
          child: GridView.count(
              crossAxisCount: 3,
              childAspectRatio: 1.25,
              clipBehavior: Clip.none,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              children: [
                ProjectCard(
                  title: 'Balloon Simulator',
                  description: 'Balloon Simulator',
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
                  description: 'Bouncy Castle Obby!',
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
                  description: 'Spaceship Simulator',
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
                  description: 'Hacker Simulator',
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
                  description: 'Monte Carlo Simulation Engine',
                  mediaWidget: VideoPlayerWidget(videoUrl: 'video/simulationapp.mp4'),
                  icon: FontAwesomeIcons.github,
                  onTap: () async {
                    final Uri params = Uri(
                      scheme: 'https',
                      host: 'www.github.com',
                      path: '/andero2003/simulations',
                    );

                    if (await canLaunchUrl(params)) {
                      await launchUrl(params);
                    }
                  },
                ),
                ProjectCard(
                  title: 'Roblox Integrated Project Management Tool',
                  description: 'Roblox Integrated Project Management Tool',
                  mediaWidget: VideoPlayerWidget(videoUrl: 'video/projecttoolapp.mp4'),
                  icon: FontAwesomeIcons.github,
                  onTap: () async {
                    final Uri params = Uri(
                      scheme: 'https',
                      host: 'www.github.com',
                      path: '/andero2003/coursework',
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

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          )
        : Container();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
              width: min((mediaWidget is VideoPlayerWidget) ? 1000 : 600, MediaQuery.of(context).size.width),
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
                    child: Stack(
                      children: [
                        Column(
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
                              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                              child: Material(
                                color: Colors.transparent,
                                child: Text(
                                  description,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 83, 83, 83)),
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
                        )
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
