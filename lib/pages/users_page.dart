import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final userService = UsuariosService();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<User> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    final user = authService.user;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            user.name,
            style: const TextStyle(color: Colors.black54),
          ),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              socketService.disconnect();
              Navigator.pushReplacementNamed(context, 'login');
              AuthService.deleteToken();
            },
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.black54,
            ),
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: socketService.serverStatus == ServerStatus.Online
                  ? Icon(
                      Icons.check_circle,
                      color: Colors.blue[400],
                    )
                  : const Icon(
                      Icons.offline_bolt,
                      color: Colors.red,
                    ),
            )
          ],
        ),
        body: SmartRefresher(
          enablePullDown: true,
          onRefresh: _loadUsers,
          header: WaterDropHeader(
            waterDropColor: Colors.blue[400]!,
            complete: Icon(
              Icons.check,
              color: Colors.blue[400],
            ),
          ),
          controller: _refreshController,
          child: _listViewUsers(),
        ));
  }

  ListView _listViewUsers() {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, i) => _userListTile(users[i]),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: users.length);
  }

  ListTile _userListTile(User user) {
    return ListTile(
      onTap: (){
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.userFor = user;
        Navigator.pushNamed(context, 'chat');
      },
      title: Text(user.name),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(user.name.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: user.online ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _loadUsers() async {
    users = await userService.getUsers();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}
