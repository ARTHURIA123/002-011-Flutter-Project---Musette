import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final FirebaseAuth auth = FirebaseAuth.instance;


  Future signOut(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    await _auth.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Login()),
            (route) => false);
  }
  List musicList = [
    {
      //"index":0,
      "image":"0.jpg",
      "song_name":"One",
      "artist":"Aimer",
      "lyricist":"aimerrhythm",
      "composer":"Rui Momota",
      "producer":"Kenji Tamai",
      "label": "SME Records",
      "isMonetize":"Unavailable",
    },
    {
      //"index":1,
      "image":"1.jpg",
      "song_name":"Scatman (Ski-Ba-Bop-Ba-Dop-Bop)",
      "artist":"Scatman John",
      "lyricist":"John Larkin, Antonio Nunzio Catania",
      "composer":"John Larkin, Antonio Nunzio Catania",
      "producer":"Antonio Nunzio Catania ,Tony Catania ,Catania Music Studios",
      "label":"RCA",
      "isMonetize":"Shared",
    },
    {
      //"index":2,
      "image":"2.jpg",
      "song_name":"Enter Sandman",
      "artist":"Metallica",
      "lyricist":"Kirk Hammett, James Hetfield, Lars Ulrich",
      "composer":"Kirk Hammett, James Hetfield, Lars Ulrich",
      "producer":"James Hetfield, Bob Rock, Lars Ulrich",
      "label":"Elektra",
      "isMonetize":"Available",
    },
    {
      //"index":3,
      "image":"3.jpg",
      "song_name":"The Only Thing I Know For Real",
      "artist":"Jamie Christopherson",
      "lyricist":"Jamie Christopherson",
      "composer":"Jamie Christopherson",
      "producer ":"Konami Digital Entertainment",
      "label":"Sumthing Else Music, Konami Digital Entertainment",
      "isMonetize":"Available",
    },
    {
      //"index":4,
      "image":"4.jpg",
      "song_name":"Let's Dance",
      "artist":"David Bowie",
      "lyricist":"David Bowie, Nile Rodgers",
      "composer":"David Bowie, Nile Rodgers",
      "producer":"David Bowie, Nile Rodgers",
      "label":"EMI America",
      "isMonetize":"Shared",
    },
    {
      //"index":5,
      "image":"5.jpg",
      "song_name":"Here I Go Again",
      "artist":"Whitesnake",
      "lyricist ":"David Coverdale, Bernie Marsden",
      "composer ":"David Coverdale, Bernie Marsden",
      "producer ":"Martin Birch",
      "label ":"Geffen",
      "isMonetize":"Available",
    },
    {
      //"index":6,
      "image":"6.jpg",
      "song_name":"The 7th Element",
      "artist":"Vitas",
      "lyricist":"Vitaly Vladasovich Grachev",
      "composer":"Vitaly Vladasovich Grachev",
      "producer":"Eduard Izmestyev",
      "label":"Iceberg",
      "isMonetize":"Available",
    },
    {
      //"index":7,
      "image":"7.jpg",
      "song_name":"Rasputin",
      "artist":"Boney M.",
      "lyricist ":"Frank Farian, George Reyam, Fred Jay",
      "composer ":"Frank Farian, George Reyam, Fred Jay",
      "producer ":"Farian",
      "label ":"Hansa, Sire, Atlantic",
      "isMonetize":"Available",
    },
    {
      //"index":8,
      "image":"8.jpg",
      "song_name":"Sheer Heart Attack",
      "artist":"Queen",
      "lyricist":"Freddie Mercury",
      "composer":"Queen",
      "producer":"Roy Thomas Baker, Queen",
      "label":"EMI, Elektra",
      "isMonetize":"Available",
    },
    {
      //"index":9,
      "image":"9.jpg",
      "song_name":"Eat The Rich",
      "artist":"Aerosmith",
      "lyricist":"Aerosmith",
      "composer":"Aerosmith",
      "producer":"Bruce Fairbairn",
      "label":"Geffen",
      "isMonetize":"Available",
    },
    {
      //"index":10,
      "image":"10.jpg",
      "song_name":"Megalovania",
      "artist":"Toby Fox",
      "lyricist":"-",
      "composer":"Toby Fox",
      "producer":"Toby Fox",
      "label":"Materia Collective",
      "isMonetize":"Unavailable",
    },
    {
      //"index":11,
      "image":"11.jpg",
      "song_name":" ətˈæk 0N tάɪtn ＜WMId＞",
      "artist":"SawanoHiroyuki[nZk]",
      "lyricist":"Rie",
      "composer":"SawanoHiroyuki[nZk]",
      "producer":"SawanoHiroyuki[nZk]",
      "label":"Sony Music Japan",
      "isMonetize":"Shared",
    },
    {
      //"index":12,
      "image":"12.jpg",
      "song_name":"Bury the Light",
      "artist":"Casey Edwards",
      "lyricist":"Casey Edwards",
      "composer":"Casey Edwards",
      "producer":"Casey Edwards",
      "label":"Capcom",
      "isMonetize":"Available",
    },
    {
      //"index":13,
      "image":"13.jpg",
      "song_name":"Glory",
      "artist":"Band-Maid",
      "lyricist":"Miku Kobato, Band-Maid",
      "composer":"Miku Kobato, Band-Maid",
      "producer":"Band-Maid",
      "label":"Crown Stones",
      "isMonetize":"Available",
    },
    {
      //"index":14,
      "image":"14.jpg",
      "song_name":"Baka Mitai",
      "artist":"-",
      "lyricist":"Ryosuke Horii",
      "composer":"Mitsuharu Fukuyama",
      "producer":"Sega",
      "label":"Sega",
      "isMonetize":"Available",
    },
    {
      //"index":15,
      "image":"15.jpg",
      "song_name":"Mixed Nuts",
      "artist":"HIGE DANdism",
      "lyricist":"Satoshi Fujihara",
      "composer":"Satoshi Fujihara",
      "producer":"Official Hige Dandism",
      "label":"Irori Records",
      "isMonetize":"Available",
    }
  ];

  List resultList = [];

  @override
  void initState() {
    // at the beginning, all recipes are shown
    resultList = musicList;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      results = musicList;
    } else {
      results = musicList
          .where((music) =>
          music["song_name"].toLowerCase().contains(enteredKeyword.toLowerCase()) || music["artist"].toLowerCase().contains(enteredKeyword.toLowerCase()) || music["isMonetize"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      resultList = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music List", style: TextStyle(fontFamily: "Tomorrow", color: Colors.white),),
        elevation: 0,
        backgroundColor: Colors.blue,
        leading: IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              signOut(context);
            }),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search',
                  suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: resultList.isNotEmpty
                  ? ListView.builder(
                itemCount: resultList.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(resultList[index]["id"]),
                  color: Colors.white,
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 44,
                        minHeight: 44,
                        maxWidth: 64,
                        maxHeight: 64,
                      ),
                      child: Image.asset("assets/${resultList[index]["image"]}", fit: BoxFit.cover),
                    ),
                    onTap: () {
                      print('Tap');
                    },
                    title: Text("\n" + resultList[index]['song_name']),
                    subtitle: Text("\nArtist: " + resultList[index]['artist'] + "\nMonetize Status: " + resultList[index]['isMonetize'] + "\n"),
                  ),
                ),
              )
                  : const Text(
                'No results',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}