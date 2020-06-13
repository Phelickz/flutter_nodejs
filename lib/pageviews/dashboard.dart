import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_node_js/state/noteState.dart';
import 'package:flutter_node_js/utils/colors.dart';
import 'package:flutter_node_js/utils/strings.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  final _uid;
  DashBoard(this._uid);
  @override
  _DashBoardState createState() => _DashBoardState(this._uid);
}

class _DashBoardState extends State<DashBoard> {
  bool _darkTheme = true;
  final _uid;

  String username;

  DateTime dateTime = DateTime.now();
  _DashBoardState(this._uid);

  NoteProvider noteProvider = NoteProvider();

  @override
  void initState() {
    getUserDetails();
    super.initState();
  }

  void getUserDetails() async {
    noteProvider.getUser().then((user) {
      if (user != null) {
        setState(() {
          username = user.name;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff171719),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Container(),
                    Spacer(),
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          '${days[this.dateTime.weekday]} ${this.dateTime.day} ${months[this.dateTime.month]}',
                          style: TextStyle(
                              color: GlobalColors.redColor,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),

            
              SizedBox(
                height: 20,
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  height: 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Hi ${username ?? ''}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Here is a list of schedule',
                        style: TextStyle(color: Colors.white70),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'you need to check...',
                        style: TextStyle(color: Colors.white70),
                      )
                    ],
                  )),

              /// CHats
              ///
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: _darkTheme ? Colors.black87 : Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Recent",
                                style: TextStyle(
                                    color: _darkTheme
                                        ? Colors.white
                                        : Colors.black45,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              Spacer(),
                              Icon(
                                Icons.more_vert,
                                color: Colors.black45,
                              )
                            ],
                          ),
                        ),
                        // StreamBuilder<List<ConversationSnippet>>(
                        //   stream: _authState.userConversations(_uid),
                        //   builder: (context, _snapshot) {
                        //     var _data = _snapshot.data;
                        //     return _snapshot.hasData
                        //         ? ListView.builder(
                        //             itemCount: _data.length,
                        //             shrinkWrap: true,
                        //             physics: ClampingScrollPhysics(),
                        //             itemBuilder: (context, index) {
                        //               return InkWell(
                        //                 onTap: () {
                        //                   Navigator.push(
                        //                     context,
                        //                     MaterialPageRoute(
                        //                       builder: (context) =>
                        //                           ChatScreen(
                        //                         _uid,
                        //                         _data[index].conversationID,
                        //                         _data[index].id,
                        //                         _data[index].image,
                        //                         _data[index].name,
                        //                       ),
                        //                     ),
                        //                   );
                        //                 },
                        //                 child: ChatTile(
                        //                   imgUrl: _data[index].image,
                        //                   name: _data[index].name,
                        //                   lastMessage: _data[index].type ==
                        //                           MessageType.Text
                        //                       ? _data[index].lastMessage
                        //                       : _data[index].type ==
                        //                               MessageType.Image
                        //                           ? 'Attachment: Photo'
                        //                           : 'Attachment: Video',
                        //                   haveunreadmessages: false,
                        //                   unreadmessages: 1,
                        //                   lastSeenTime: timeago.format(
                        //                       _data[index]
                        //                           .timestamp
                        //                           .toDate()),
                        //                   conversationID:
                        //                       _data[index].conversationID,
                        //                   id: _data[index].id,
                        //                   uid: _uid,
                        //                 ),
                        //               );
                        //             })
                        //         : CircularProgressIndicator();
                        //   },
                        // ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  // getUserId() async {
  //   final uid = await Provider.of<AuthenticationState>(context, listen: false)
  //       .currentUserId();
  //   setState(() {
  //     _uid = uid;
  //   });
  //   return uid;
  // }
}

class StoryTile extends StatelessWidget {
  final String imgUrl;
  final String username;
  StoryTile({@required this.imgUrl, @required this.username});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: Image.network(
              imgUrl,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            username,
            style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

// class ChatTile extends StatelessWidget {
//   var _darkTheme;
//   final String uid;
//   final String id;
//   final String conversationID;
//   final String imgUrl;
//   final String name;
//   final String lastMessage;
//   final bool haveunreadmessages;
//   final int unreadmessages;
//   final String lastSeenTime;
//   ChatTile(
//       {@required this.unreadmessages,
//       @required this.uid,
//       @required this.id,
//       @required this.conversationID,
//       @required this.haveunreadmessages,
//       @required this.lastSeenTime,
//       @required this.lastMessage,
//       @required this.imgUrl,
//       @required this.name});
//   @override
//   Widget build(BuildContext context) {
//     final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
//     _darkTheme = (themeNotifier.getTheme() == darkTheme);
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => ChatScreen(
//                       uid,
//                       conversationID,
//                       id,
//                       imgUrl,
//                       name,
//                     )));
//       },
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 16),
//         child: Row(
//           children: <Widget>[
//             ClipRRect(
//               borderRadius: BorderRadius.circular(60),
//               child: Image.network(
//                 imgUrl,
//                 height: 60,
//                 width: 60,
//                 fit: BoxFit.cover,
//                 // color: _darkTheme ? Colors.white : Colors.black,
//               ),
//             ),
//             SizedBox(
//               width: 16,
//             ),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     name,
//                     style: TextStyle(
//                         color: _darkTheme ? Colors.white : Colors.black87,
//                         fontSize: 17,
//                         fontWeight: FontWeight.w600),
//                   ),
//                   SizedBox(
//                     height: 8,
//                   ),
//                   Text(
//                     lastMessage.length >= 30
//                         ? lastMessage.substring(0, 25) + '...'
//                         : lastMessage,
//                     style: TextStyle(
//                         color: _darkTheme ? Colors.white : Colors.black54,
//                         fontSize: 15,
//                         fontFamily: "Neue Haas Grotesk"),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: 14,
//             ),
//             Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Text(lastSeenTime),
//                   SizedBox(
//                     height: 16,
//                   ),
//                   haveunreadmessages
//                       ? Container(
//                           width: 30,
//                           height: 30,
//                           alignment: Alignment.center,
//                           padding: EdgeInsets.all(8),
//                           decoration: BoxDecoration(
//                               color: Color(0xffff410f),
//                               borderRadius: BorderRadius.circular(12)),
//                           child: Text(
//                             "$unreadmessages",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600),
//                           ))
//                       : Container()
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
