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
  final TextEditingController _loginUserNameController = TextEditingController();
  bool? isLoaging;
  late Future<UserProfileModel> userProfileData;

  @override
  void initState() {
    super.initState();
    final repo = Repository();

    userProfileData = repo.fetchUserProfileData(loginName: "PedroFrancodev");
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildSearchArea(),
                      const SizedBox(
                        height: 20,
                      ),
                      _buildUserProfileData(),
                    ],
                  ),
                )),
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
                Image.network(
                  snap.data!.avatarUrl!,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  snap.data!.name!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
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
                    fontSize: 13,
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
                      snap.data!.publicRepos!.toString(),
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
                      " ${snap.data!.followers} Seguidores | Seguindo ${snap.data!.following}",
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
                      uri: Uri.parse("https://pub.dev"),
                      target: LinkTarget.blank,
                      builder: (BuildContext ctx, FollowLink? openLink) {
                        return TextButton.icon(
                          onPressed: openLink,
                          label: const Text('Visite o perfil do meu GitHub'),
                          icon: const Icon(
                            Iconsax.link,
                            color: Colors.white,
                            size: 19,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            );
          } else {
            const Text("Sem perfil");
          }
        }

        if (snap.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(
            color: Colors.blue[400],
            strokeWidth: 4,
          );
        }
        if (snap.hasError) {
          return const Text(
            "Erro na requisição",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          );
        }
        return Container();
      },
    );
  }

  Widget _buildSearchArea() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: _loginUserNameController,
            keyboardType: TextInputType.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              //   helperText: "Preencha o campo",
              hintText: "Ex.: PedroFrancoDev",
              labelText: "GitHub login name",
              labelStyle: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
              hintStyle: TextStyle(
                color: Color.fromARGB(255, 183, 183, 183),
                fontSize: 17,
              ),
              counterStyle: TextStyle(color: Colors.red),
              helperStyle: TextStyle(
                color: Color.fromARGB(255, 255, 79, 66),
                fontSize: 17,
              ),
              border: OutlineInputBorder(
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
    setState(
      () {
        final loginName = _loginUserNameController.text.toString();
        final Repository repository = Repository();
        userProfileData = repository.fetchUserProfileData(loginName: loginName);

        _loginUserNameController.clear();
      },
    );
  }
}
