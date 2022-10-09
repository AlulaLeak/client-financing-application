import 'package:flutter/material.dart';
import '../providers/userinfo_provider.dart';
import 'package:provider/provider.dart';

import '../config/utils.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late PageController _pageController;
  int activePage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Scaffold(
        backgroundColor: primary,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 400),
                child: Container(
                  height: 700,
                  color: scaffoldbg,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Hello, \n ${context.watch<UserInformation>().name.toString()}!",
                          style: const TextStyle(
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: white,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          child: PageView.builder(
                              itemCount: images.length,
                              pageSnapping: true,
                              controller: _pageController,
                              onPageChanged: (page) {
                                setState(() {
                                  activePage = page;
                                });
                              },
                              itemBuilder: (context, pagePosition) {
                                bool active = pagePosition == activePage;
                                return slider(images, pagePosition, active);
                              }),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: indicators(images.length, activePage))
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      height: 350.0,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 4,
                            blurRadius: 5,
                            offset: const Offset(0, 7),
                          ),
                        ],
                        color: white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            16.0,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '🗓 Performa Bulan Ini',
                            style: TextStyle(
                              color: black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              top: 15,
                            ),
                            width: double.infinity,
                            height: 90,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: secondary,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  12.0,
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: const [
                                    Text("Kamu udah keluarin",
                                        style: TextStyle(
                                            color: black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text("Rp89rb",
                                        style: TextStyle(
                                            color: black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  children: const [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        "Yuk, Bikin budget biar enggak overspend!",
                                        style: TextStyle(
                                            color: grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10),
                                      child: Text(
                                        '+ Buat Budget',
                                        style: TextStyle(
                                          color: primary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            width: double.infinity,
                            height: 90,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: secondary,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  12.0,
                                ),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                RichText(
                                  text: const TextSpan(
                                    style: TextStyle(fontSize: 28),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Dikit lagi ',
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.w500)),
                                      TextSpan(
                                          text: 'cash flow ',
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              color: black,
                                              fontWeight: FontWeight.w500)),
                                      TextSpan(
                                          text: 'kamu sehat\n',
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.w500)),
                                      TextSpan(
                                        text: 'Cek cara tingkatin skornya',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: grey,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  textScaleFactor: 0.5,
                                ),
                                const Spacer(),
                                CircleAvatar(
                                  backgroundColor: Colors.red[100],
                                  child: const Center(
                                    child: Text(
                                      "28",
                                      style: TextStyle(
                                          color: red,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 18,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            width: double.infinity,
                            height: 70,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 2,
                                color: secondary,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  12.0,
                                ),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  "Belum ada tagihan",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: grey,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spacer(),
                                Text(
                                  '+ Buat Tagihan',
                                  style: TextStyle(
                                    color: primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      height: 200.0,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 4,
                            blurRadius: 5,
                            offset: const Offset(0, 7),
                          ),
                        ],
                        color: white,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            16.0,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '💙 Fitur Menarik',
                            style: TextStyle(
                              color: black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 100.0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Stack(
                                  children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 26,
                                          backgroundColor: secondary,
                                          child: const Text(
                                            '🏆',
                                            style: TextStyle(fontSize: 26),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        const Text(
                                          'Capaian',
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    const Positioned(
                                      left: 33,
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: red,
                                        child: Text(
                                          '1',
                                          style: TextStyle(
                                              color: white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 26,
                                          backgroundColor: Colors.grey[200],
                                          child: const Text(
                                            '🎁',
                                            style: TextStyle(fontSize: 26),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        const Text(
                                          'Ajak Teman',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    const Positioned(
                                      left: 46,
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.red,
                                        child: Text(
                                          '1',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Stack(
                                  children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 26,
                                          backgroundColor: secondary,
                                          child: const Text(
                                            '🤔',
                                            style: TextStyle(fontSize: 26),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        const Text(
                                          'Insight\nKamu',
                                          style: TextStyle(
                                              color: black,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    const Positioned(
                                      left: 52,
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: red,
                                        child: Text(
                                          '1',
                                          style: TextStyle(
                                              color: white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      radius: 26,
                                      backgroundColor: secondary,
                                      child: const Text(
                                        '🧾',
                                        style: TextStyle(fontSize: 26),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    const Text(
                                      'Bayar\nTagihan',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: black,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(15),
                      height: 100.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.grey,
                        ),
                        color: Colors.grey,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(
                            16.0,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Gimana sih cara pake Finku?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: const [
                              Text(
                                'Pelajari bareng Fin-E!',
                                style: TextStyle(
                                  color: primary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: primary,
                                size: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
