import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:search_your_profile/model/user_profile_model.dart';
import 'package:search_your_profile/services/repository.dart';
import 'package:url_launcher/link.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _loginUserNameController =
      TextEditingController();
  bool textFieldError = false;
  Future<UserProfileModel> userProfileData =
      Repository().fetchUserProfileData(loginName: "");
  final Repository repository = Repository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0XFF000408),
        toolbarHeight: 60,
        title: const Text(
          "Search your GitHub profile",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: IconButton(
              onPressed: () {
                _loginUserNameController.clear();
              },
              icon: const Icon(
                Iconsax.refresh,
                color: Colors.white,
                size: 19,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "asset/GitHub_Invertocat_Logo.svg.png",
              fit: BoxFit.cover,
              width: 150,
              height: 150,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(217, 12, 17, 23),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 30,
                bottom: 16,
              ),
              child: Column(
                children: [
                  _buildSearchArea(),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: _buildUserProfileData(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserProfileData() {
    return FutureBuilder(
      future: userProfileData,
      builder: (context, snap) {
        var state = snap.connectionState;

        if (state == ConnectionState.done) {
          if (snap.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Image.network(
                    snap.data!.avatarUrl!,
                    fit: BoxFit.scaleDown,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  snap.data!.name!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      snap.data!.login!,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 138, 138, 138),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "|",
                      style: TextStyle(
                        color: Color.fromARGB(255, 138, 138, 138),
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Iconsax.location,
                      color: Color.fromARGB(255, 138, 138, 138),
                      size: 19,
                    ),
                    Text(
                      " ${snap.data!.location!}",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 138, 138, 138),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  snap.data!.bio!,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Iconsax.book,
                      color: Colors.white,
                      size: 19,
                    ),
                    const Text(
                      " Repositórios público: ",
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      snap.data!.publicRepos!.toString() ?? "0",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 53, 162, 46),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Icon(
                      Iconsax.people5,
                      color: Colors.white,
                      size: 19,
                    ),
                    Text(
                      " ${snap.data!.followers ?? "0"} Seguidores | Seguindo ${snap.data!.following ?? "0"}",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Iconsax.link,
                      color: Colors.white,
                      size: 19,
                    ),
                    Link(
                      uri: Uri.parse(snap.data!.htmlUrl!),
                      target: LinkTarget.blank,
                      builder: (BuildContext ctx, FollowLink? openLink) {
                        return TextButton.icon(
                          onPressed: openLink,
                          label: const Text(
                            'Visite o perfil do meu GitHub',
                            style: TextStyle(
                              color: Color.fromARGB(255, 48, 156, 243),
                            ),
                          ),
                          icon: Text(""),
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          }
          if (snap.data == null) {
            return const Text(
              "Sem dados",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 13,
              ),
            );
          }
        }
        if (state == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: Colors.blue[400],
            strokeWidth: 4,
          );
        }

        if (snap.hasError) {
          return Text(
            snap.error.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          );
        }

        return const Text("");
      },
    );
  }

  Widget _buildSearchArea() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextFormField(
            controller: _loginUserNameController,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              helperText: textFieldError ? "Preencha o campo" : "",
              hintText: "Ex.: PedroFrancoDev",
              labelText: "GitHub login name",
              labelStyle: const TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 183, 183, 183),
                fontSize: 17,
              ),
              counterStyle: const TextStyle(color: Colors.red),
              helperStyle: const TextStyle(
                color: Color.fromARGB(255, 255, 79, 66),
                fontSize: 17,
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(style: BorderStyle.none),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    5,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 54,
          width: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: IconButton(
            onPressed: () => getUserProfileData(),
            icon: const Icon(
              Icons.search,
              size: 30,
              color: Colors.black,
              weight: 900,
            ),
          ),
        ),
      ],
    );
  }

  getUserProfileData() {
    if (_loginUserNameController.text.isEmpty) {
      setState(() {
        textFieldError = true;
      });
    } else {
      setState(
        () {
          textFieldError = false;
          final loginName = _loginUserNameController.text.toString();

          userProfileData =
              repository.fetchUserProfileData(loginName: loginName);

          _loginUserNameController.clear();
        },
      );
    }
  }
}
