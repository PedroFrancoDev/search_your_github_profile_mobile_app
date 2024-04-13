import 'package:flutter/material.dart';
import 'package:search_your_profile/bloc/bloc.dart';
import 'package:search_your_profile/model/user_profile_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _loginUserNameController = TextEditingController();
  late Stream<UserProfileModel> userProfiledata;
  final bloc = UserProfileDataBloc();
  bool? isLoaging;

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
            color: Color.fromARGB(217, 12, 17, 23),
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
    return StreamBuilder<UserProfileModel>(
      stream: bloc.userProfileData,
      builder: (context, snap) {
        if (snap.hasData) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
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
                Text(
                  snap.data!.login!,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 138, 138, 138),
                    fontSize: 14,
                  ),
                ),
                SizedBox(
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
                    const Text(
                      "Repositórios publico: ",
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
                )
              ],
            ),
          );
        } else if (snap.hasError) {
          return Text("tt");
        }
        if (isLoaging != null) {
          if (isLoaging! == true) {
            return CircularProgressIndicator(
              color: Colors.blue[400],
              strokeWidth: 4,
            );
          }
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
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 10,
              ),
              //   helperText: "Preencha o campo",
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
    setState(() {
      isLoaging = true;
    });
    Future.delayed(
      const Duration(seconds: 2),
      () {
        try {
          final loginUserName = _loginUserNameController.text.toString();
          bloc.fetchUserProfileData(loginName: loginUserName);
          userProfiledata = bloc.userProfileData;

          _loginUserNameController.clear();
        } finally {
          setState(() {
            isLoaging = false;
          });
        }
      },
    );
  }
}
