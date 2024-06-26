import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:migu/domain/entities/vaccine.dart';
import 'package:migu/presentation/views/home_view.dart';

final editvaccineProvider = StateProvider<bool>((ref) {
  return false;
});

final infoeditvaccineProvider = StateProvider<Vaccine>((ref) {
  return Vaccine(
      type: "",
      brand: "",
      vaccination: "",
      date: DateTime.now(),
      nextdose: DateTime.now(),
      photovaccinelabel: "",
      photocertificate: "",
      id: "");
});

class IntoVaccine extends ConsumerWidget {
  const IntoVaccine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nn = ref.watch(sightinProvider);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: screenHeight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(
                onPressed: () {
                  ref
                      .read(editvaccineProvider.notifier)
                      .update((state) => false);
                  ref
                      .read(pressVaccineIntoProvider.notifier)
                      .update((state) => false);
                },
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                label: const Text(
                  "Atras",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.share),
                label: const Text("Compartir"),
              ),
            ],
          ),
          Container(
            height: screenHeight * 0.1,
            width: screenWidth * 0.7,
            padding: EdgeInsets.all(screenWidth * 0.03),
            color: Colors.grey[200],
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (nn.brand != "Rabguard" &&
                        nn.brand != "Canigen" &&
                        nn.brand != "Nobivac")
                      Icon(Icons.image, size: screenHeight * 0.07),
                    if (nn.brand == "Rabguard")
                      Image.asset(
                        'assets/Frame1000004649.png',
                        height: screenHeight * 0.07,
                        width: screenHeight * 0.07,
                      ),
                    if (nn.brand == "Canigen")
                      Image.asset(
                        'assets/Frame13336.png',
                        height: screenHeight * 0.07,
                        width: screenHeight * 0.07,
                      ),
                    if (nn.brand == "Nobivac")
                      Image.asset(
                        'assets/Frame1000004650.png',
                        width: screenHeight * 0.07,
                        height: screenHeight * 0.07,
                      ),
                  ],
                ),
                SizedBox(width: screenWidth * 0.05),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${nn.type}",
                      style: TextStyle(
                          fontSize: screenWidth * 0.04,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      "${nn.brand}",
                      style: TextStyle(
                          fontSize: screenWidth * 0.035, color: Colors.black),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.2),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Ultima dosis: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text:
                        "${nn.date.day} ${getShortMonthName(nn.date.month)} ${nn.date.year}",
                    style: TextStyle(
                        color: Colors.black, fontSize: screenWidth * 0.035),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Padding(
            padding: EdgeInsets.only(right: screenWidth * 0.2),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Proxima dosis: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w500),
                  ),
                  TextSpan(
                    text:
                        "${nn.nextdose.day} ${getShortMonthName(nn.nextdose.month)} ${nn.nextdose.year}",
                    style: TextStyle(
                        color: Colors.black, fontSize: screenWidth * 0.035),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.02),
          Container(
            height: screenHeight * 0.1,
            width: screenWidth * 0.7,
            padding: EdgeInsets.all(screenWidth * 0.03),
            color: Colors.grey[200],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Etiqueta Vacuna"),
                const Icon(Icons.help),
                nn.photocertificate == ""
                    ? const Text("no-Image")
                    : GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Etiqueta Vacuna"),
                                content: Image.network(
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      // Si la imagen ya se ha cargado, simplemente muestra la imagen
                                      return child;
                                    } else {
                                      // Si la imagen aún se está cargando, muestra un indicador de progreso
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      );
                                    }
                                  },
                                  nn.photovaccinelabel,
                                  width: 20,
                                ),
                              );
                            },
                          );
                        },
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text("Etiqueta Vacuna"),
                                  content: Image.network(
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        // Si la imagen ya se ha cargado, simplemente muestra la imagen
                                        return child;
                                      } else {
                                        // Si la imagen aún se está cargando, muestra un indicador de progreso
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.black,
                                          ),
                                        );
                                      }
                                    },
                                    nn.photovaccinelabel,
                                    width: 20,
                                  ),
                                );
                              },
                            );
                          },
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Certificado"),
                                    content: Image.network(
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          // Si la imagen ya se ha cargado, simplemente muestra la imagen
                                          return child;
                                        } else {
                                          // Si la imagen aún se está cargando, muestra un indicador de progreso
                                          return const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                            ),
                                          );
                                        }
                                      },
                                      nn.photovaccinelabel,
                                      width: 20,
                                    ),
                                  );
                                },
                              );
                            },
                            child: GestureDetector(
                              
                              onTap: () {
                                showDialog(
                                  
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Etiqueta Vacuna:") ,
                                      content: Image.network(
                                        loadingBuilder: (context, child,
                                            loadingProgress) {
                                          if (loadingProgress == null) {
                                            // Si la imagen ya se ha cargado, simplemente muestra la imagen
                                            return child;
                                          } else {
                                            // Si la imagen aún se está cargando, muestra un indicador de progreso
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(
                                                color: Colors.black,
                                              ),
                                            );
                                          }
                                        },
                                        nn.photovaccinelabel,
                                        width: 20,
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                width: screenWidth * 0.2,
                                height: screenWidth * 0.2,
                                child: Image.network(
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      // Si la imagen ya se ha cargado, simplemente muestra la imagen
                                      return child;
                                    } else {
                                      // Si la imagen aún se está cargando, muestra un indicador de progreso
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      );
                                    }
                                  },
                                  nn.photovaccinelabel,
                                  width: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                 return AlertDialog(
                  title: const Text("Certificado:"),
                                        content: Image.network(
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              // Si la imagen ya se ha cargado, simplemente muestra la imagen
                                              return child;
                                            } else {
                                              // Si la imagen aún se está cargando, muestra un indicador de progreso
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.black,
                                                ),
                                              );
                                            }
                                          },
                                          nn.photocertificate,
                                          width: 20,
                                        ),
                                      );
                },
              );
            },
            child: Container(
              
              height: screenHeight * 0.1,
              width: screenWidth * 0.7,
              padding: EdgeInsets.all(screenWidth * 0.03),
              color: Colors.grey[200],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Certificado"),
                  const Icon(Icons.help),
                  nn.photocertificate == ""
                      ? const Text("no-Image")
                      : Container(
                          width: screenWidth * 0.2,
                          height: screenWidth * 0.2,
                          child: Image.network(
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                // Si la imagen ya se ha cargado, simplemente muestra la imagen
                                return child;
                              } else {
                                // Si la imagen aún se está cargando, muestra un indicador de progreso
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                );
                              }
                            },
                            nn.photocertificate,
                            width: 20,
                          ),
                        ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              context.push("/addvaccine");
              ref.read(editvaccineProvider.notifier).update((state) => true);
              ref.read(infoeditvaccineProvider.notifier).update((state) => nn);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.4, vertical: screenHeight * 0.02),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.05),
                side: BorderSide(color: Colors.green),
              ),
            ),
            child: const Text(
              'Editar',
              style: TextStyle(color: Colors.black),
            ),
          ),
          TextButton(
            onPressed: () {
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection("vaccine")
                  .doc(nn.id)
                  .delete()
                  .then((value) =>
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Vacuna borrada!'),
                      )))
                  .then((value) => ref
                      .read(pressVaccineIntoProvider.notifier)
                      .update((state) => false));
            },
            child: const Text("Eliminar", style: TextStyle(color: Colors.red)),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
