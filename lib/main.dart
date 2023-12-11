import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

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
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              stops: [0.0, 1],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 19, 19, 19),
                Color.fromARGB(255, 14, 3, 53),
              ],
              tileMode: TileMode.repeated,
            ),
          ),
          child: Padding(
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
                                    color: currentPageIndex == 0 ? const Color.fromARGB(255, 59, 104, 228) : Colors.white, fontSize: 24))),
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
                                    color: currentPageIndex == 1 ? const Color.fromARGB(255, 59, 104, 228) : Colors.white, fontSize: 24))),
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
                                    color: currentPageIndex == 2 ? const Color.fromARGB(255, 59, 104, 228) : Colors.white, fontSize: 24))),
                      ],
                    ),
                  ),
                ],
              )),
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
    return Center(child: Text("TBD"));
  }
}
