import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:migu/presentation/auth/Addpet_Screen.dart';
import 'package:migu/presentation/views/home_view.dart';
import 'package:migu/presentation/views/vet_view.dart';
import 'package:migu/widgets/shared/custom_bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  final int pageIndex;
  const HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = const [
    HomeView(),
    // SizedBox(),
    VetView()
  ];
  @override
  Widget build(BuildContext context) {
  return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return Center(
            //   child: CircularProgressIndicator(),
            // );
          }
          final showBottomNav = snapshot.hasData && snapshot.data!.exists;
          return Stack(
            children: [
              IndexedStack(
                index: showBottomNav ? 1 : 0,
                children: [
                  const AddPet(),
                  IndexedStack(
                    index: pageIndex,
                    children: viewRoutes,
                  ),
                ],
              ),
              Visibility(
                visible: showBottomNav,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomBottomNavigation(currentIndex: pageIndex),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ); }
}
