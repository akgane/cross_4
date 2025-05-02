import 'package:flutter/material.dart';
import 'package:rental/data/data.dart';

import '../models/Users.dart';
import '../widgets/chats/chat_list.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ChatsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late List<Chat> chats;

  @override
  void initState() {
    super.initState();
    chats = exampleChats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.p_chats, style: Theme.of(context).textTheme.titleLarge),
      ),
      body: ChatList(chats: chats),
    );
  }
}
