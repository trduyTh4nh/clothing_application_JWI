import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuan08/app/data/api.dart';
import 'package:tuan08/app/model/payment.dart';
import 'package:tuan08/utils.dart';

class HisotryPage extends StatefulWidget {
  const HisotryPage({super.key});

  @override
  State<HisotryPage> createState() => _HisotryPageState();
}

class _HisotryPageState extends State<HisotryPage> {
  List<Payment> _histPay = [];

  Future<List<Payment>> getHistoryPayments() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("token")!;
    _histPay = await APIRepository().getHistoryPayment(token);

    return _histPay;
  }

  @override
  void initState() {
    super.initState();

    // getHistoryPayments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lịch sử mua hàng"),
        automaticallyImplyLeading: false,

      ),
      body: FutureBuilder<List<Payment>>(
        future: getHistoryPayments(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return snapshot.hasData
              ? Padding(
                  padding: const EdgeInsets.all(8),
                  child: ListView.separated(
                    itemCount: snapshot.data!.length,
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 18,
                    ),
                    itemBuilder: (context, index) {
                      final payment = snapshot.data![index];
                      return Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(17, 17, 26, 0.1),
                                blurRadius: 0,
                                spreadRadius: 0,
                                offset: Offset(
                                  0,
                                  1,
                                ),
                              ),
                            ]),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                "Hóa đơn: ${payment.id}",
                                style: const TextStyle(color: Colors.green),
                              ),
                            ),
                            const SizedBox(
                              height: 0,
                            ),
                            Text(
                              "Tên khách hàng: ${payment.fullName}",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 0,
                            ),
                            Text("Ngày tạo: ${payment.dateCreated}",
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(
                              height: 0,
                            ),
                            Text("Tổng hóa đơn: ${formatMoney(payment.total!)}",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 209, 31, 4)))
                          ],
                        ),
                      );
                    },
                  ),
                )
              : const Center(
                  child: const Text("Chưa có lịch sử mua hàng nào!?"),
                );
        },
      ),
    );
  }
}
