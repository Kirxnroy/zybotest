import 'package:flutter/material.dart';
import 'package:zybotest/profilepg.dart';

class Homepage1 extends StatefulWidget {
  const Homepage1({super.key});

  @override
  State<Homepage1> createState() => _Homepage1State();
}

class _Homepage1State extends State<Homepage1> {
  // Sample data for profiles
  final List<ProfileData> profiles = [
    ProfileData("Terry Windler", "हिंदी",
        "https://randomuser.me/api/portraits/women/1.jpg"),
    ProfileData("Gina Deckow", "മലയാളം",
        "https://randomuser.me/api/portraits/women/2.jpg"),
    ProfileData("Naomi Bradtke", "हिंदी",
        "https://randomuser.me/api/portraits/women/3.jpg"),
    ProfileData("Terrence Bauch", "മലയാളം",
        "https://randomuser.me/api/portraits/men/1.jpg"),
    ProfileData("Levi Buckridge", "हिंदी",
        "https://randomuser.me/api/portraits/men/2.jpg"),
    ProfileData("Phil Wunsch", "മലയാളം",
        "https://randomuser.me/api/portraits/men/3.jpg"),
    ProfileData("Earl Reilly", "हिंदी",
        "https://randomuser.me/api/portraits/men/4.jpg"),
    ProfileData("Jenny Donnelly", "മലയാളം",
        "https://randomuser.me/api/portraits/women/4.jpg"),
    ProfileData("Harold Johnston", "हिंदी",
        "https://randomuser.me/api/portraits/men/5.jpg"),
    ProfileData("Jonathan Bode", "हिंदी",
        "https://randomuser.me/api/portraits/men/6.jpg"),
    ProfileData("Bobbie Wilkinson", "മലയാളം",
        "https://randomuser.me/api/portraits/women/5.jpg"),
    ProfileData("Doreen Koelpin", "हिंदी",
        "https://randomuser.me/api/portraits/women/6.jpg"),
  ];

  // All letters for the alphabetical index
  final List<String> alphabet = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
    '#'
  ];

  late ScrollController _scrollController;
  String _selectedLetter = 'A';
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    // Sort profiles alphabetically
    profiles.sort((a, b) => a.name.compareTo(b.name));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _scrollToLetter(String letter) {
    setState(() {
      _selectedLetter = letter;
    });

    // Find the first profile that starts with the selected letter
    int index = profiles
        .indexWhere((profile) => profile.name[0].toUpperCase() == letter);
    if (index != -1) {
      double position = index * 100.0;
      _scrollController.animateTo(
        position,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // App Bar with Logo and User Info
          Container(
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16, bottom: 10),
            color: const Color(0xFF3F51B5),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        height: 80,
                        width: 80,
                        child: Image.asset(
                            '/Users/kirxnroy/zybotest/assets/Logo.png')),
                    Row(
                      children: [
                        Container(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.monetization_on,
                                  color: Colors.amber, size: 20),
                              SizedBox(width: 4),
                              Text("134",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            // Navigate to profile page when avatar is tapped
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ProfilePage(), // Your profile page widget
                              ),
                            );
                          },
                          child: const CircleAvatar(
                            backgroundImage: NetworkImage(
                                "https://randomuser.me/api/portraits/men/7.jpg"),
                            radius: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.blue[400],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.check_circle,
                              color: Colors.amber, size: 16),
                          SizedBox(width: 5),
                          Text("Active",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 15),
                    Row(
                      children: [
                        const Text("Premium",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 5),
                        Icon(Icons.diamond,
                            color: Colors.lightBlue[100], size: 18),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            color: Colors.grey[100],
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),

          // Profiles Grid with Alphabetical Index
          Expanded(
            child: Stack(
              children: [
                // Profiles Grid
                GridView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 10, 40, 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: profiles.length,
                  itemBuilder: (context, index) {
                    return ProfileCard(
                      profile: profiles[index],
                      onTap: () {
                        // Navigate to profile details or start chat
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProfileDetailPage(profile: profiles[index]),
                          ),
                        );
                      },
                    );
                  },
                ),

                // Alphabetical Index
                Positioned(
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 20,
                    color: Colors.transparent,
                    child: ListView.builder(
                      itemCount: alphabet.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => _scrollToLetter(alphabet[index]),
                          child: Container(
                            height: 20,
                            alignment: Alignment.center,
                            color: _selectedLetter == alphabet[index]
                                ? Colors.blue.withOpacity(0.1)
                                : Colors.transparent,
                            child: Text(
                              alphabet[index],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: _selectedLetter == alphabet[index]
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final ProfileData profile;
  final VoidCallback onTap;

  const ProfileCard({required this.profile, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(profile.imageUrl),
          ),
          const SizedBox(height: 5),
          Text(
            profile.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: profile.language == "हिंदी"
                  ? Colors.blue.withOpacity(0.1)
                  : Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "A",
                  style: TextStyle(
                    color: profile.language == "हिंदी"
                        ? Colors.blue
                        : Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 3),
                Text(
                  profile.language,
                  style: TextStyle(
                    color: profile.language == "हिंदी"
                        ? Colors.blue
                        : Colors.green,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileData {
  final String name;
  final String language;
  final String imageUrl;

  ProfileData(this.name, this.language, this.imageUrl);
}

class ProfileDetailPage extends StatelessWidget {
  final ProfileData profile;

  const ProfileDetailPage({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(profile.name),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(profile.imageUrl),
            ),
            const SizedBox(height: 20),
            Text(
              profile.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: profile.language == "हिंदी"
                    ? Colors.blue.withOpacity(0.1)
                    : Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "Language: ${profile.language}",
                style: TextStyle(
                  color:
                      profile.language == "हिंदी" ? Colors.blue : Colors.green,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                // Start chat functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Chat with ${profile.name} started")),
                );
              },
              icon: const Icon(Icons.chat),
              label: const Text("Start Chat"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
