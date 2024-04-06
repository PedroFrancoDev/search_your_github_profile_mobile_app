import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 29, 29, 29),
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
            color: const Color.fromARGB(197, 0, 0, 0),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 30,
                bottom: 16,
              ),
              child: Column(
                children: [
                  _buildTextInputContainer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextInputContainer() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
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
              // helperText: "Preencha o campo",
              hintText: "Ex.: PedroFrancoDev",
              labelText: "GitHub user name",
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
            onPressed: () {},
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
}
