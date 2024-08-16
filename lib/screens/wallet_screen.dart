import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nusainfra/controllers/wallet_controller.dart';

class WalletScreen extends StatelessWidget {
  final WalletController _walletController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallets'),
      ),
      body: Obx(() {
        if (_walletController.wallets.isEmpty) {
          return Center(child: Text('No wallets available'));
        }
        return ListView.builder(
          itemCount: _walletController.wallets.length,
          itemBuilder: (context, index) {
            final wallet = _walletController.wallets[index];
            return ListTile(
              title: Text(wallet.name),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  _walletController.deleteWallet(wallet.id);
                },
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    final TextEditingController nameController =
                        TextEditingController(text: wallet.name);
                    return AlertDialog(
                      title: Text('Update Wallet'),
                      content: TextField(
                        controller: nameController,
                        decoration: InputDecoration(labelText: 'Wallet Name'),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            _walletController.updateWallet(
                                wallet.id, nameController.text);
                            Get.back();
                          },
                          child: Text('Update'),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              final TextEditingController nameController =
                  TextEditingController();
              return AlertDialog(
                title: Text('Create Wallet'),
                content: TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Wallet Name'),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      _walletController.createWallet(nameController.text);
                      Get.back();
                    },
                    child: Text('Create'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
