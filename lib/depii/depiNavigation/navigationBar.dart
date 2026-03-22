import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigationbar extends StatefulWidget {
  const Navigationbar({super.key});

  @override
  State<Navigationbar> createState() => _NavigationbarState();
}

class _NavigationbarState extends State<Navigationbar> {
 int cur=0;
final List<Widget>screen=[
  Call(),Camera(),
  Chat(),
];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: screen[cur],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: cur,
        elevation: 5,
        selectedFontSize: 20,
        selectedItemColor: Colors.green,
        unselectedFontSize: 14,
        unselectedItemColor: Colors.grey,

        onTap: (index){
          cur=index;
          setState(() {

          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.call), label: 'Call'),
          BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: 'Camera'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        ],
      ),
    );
  }
}
















class Call extends StatelessWidget {
  const Call({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> names = ['Father', 'Mother', 'Ziad'];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Call'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.info_outline_rounded),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: names.length,

        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${names[index]}'),
            subtitle: Text('Missed Call'),
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurpleAccent[100],
              child: Icon(Icons.person, size: 24, color: Colors.deepPurple),
            ),
            trailing: Icon(Icons.call, size: 24, color: Colors.green),
          );
        },
      ),
    );
  }
}


class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}
int count = 0;
class _CameraState extends State<Camera> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Camera'),actions: [Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.info_outline_rounded),
      )]),
      body: Center(
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt, size: 80, color: Colors.green),
            Text('Photos Taken: $count',style: TextStyle(fontSize: 30),),
            ElevatedButton(
              onPressed: () {
                count++;
                setState(() {});
              },
              child: Text('Take Photo',style: TextStyle(fontSize: 20),),
            ),
          ],
        ),
      ),
    );
  }
}












class Chat extends StatefulWidget {
  Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<String> groups = ['Flutter Dev Group', 'Project Team', 'John doe'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Chats'),actions: [Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.info_outline_rounded),
      )]),
      body: ListView.builder(
        itemCount: groups.length,

        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) {
                    return Secondchat(title: groups[index]);
                  },
                ),
              );
            },
            title: Text(groups[index]),
            subtitle: Text('Last Message Preview...'),
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurpleAccent[100],
              child: Icon(Icons.person, size: 24, color: Colors.deepPurple),
            ),
          );
        },
      ),
    );
  }
}










class Secondchat extends StatelessWidget {
  final String title;
  Secondchat({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$title')),
      body: Center(
        child: Text(
          'Chat With $title',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}



