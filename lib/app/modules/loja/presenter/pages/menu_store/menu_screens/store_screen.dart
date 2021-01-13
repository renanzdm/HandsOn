import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handson/app/infra/dependency_injection/injection.dart';
import 'package:handson/app/modules/loja/domain/entities/product.dart';
import 'package:handson/app/modules/loja/presenter/pages/add_product_store/add_screen/add_product.dart';
import 'package:handson/app/modules/loja/presenter/pages/controller/product_operations_controller.dart';
import 'package:handson/app/shared/widgets/app_bar.dart';
import 'package:handson/app/shared/widgets/dashed_button.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final controller = inject.get<ProductOperationsController>();

  @override
  void initState() {
    controller.getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarCustom(
        height: 150,
      ),
      body: Container(
        width: sizes.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Column(
            children: [
              Text(
                'Padaria da Amélia',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey.shade600,
                ),
              ),
              Text(
                'Rua Antonio de Godói, 88, Centro/SP',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 18,
                  ),
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '5.0 ',
                          style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                        TextSpan(
                          text: ' (63 avaliações)',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 16.0),
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                width: sizes.width,
                height: 60,
                color: Colors.grey.shade100,
                child: DashedButton(
                  icon: Icons.add,
                  label: 'Adicionar novo produto',
                  color: Colors.red,
                  gap: 3.0,
                  strokeWidth: 1.0,
                  onPressed: () {
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => AddProduct()));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      'Pães',
                      style: TextStyle(color: Colors.red),
                    ),
                    Spacer(),
                    Text(
                      'Ativar no cardápio',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
              ValueListenableBuilder(
                  valueListenable: controller.listProducts,
                  builder: (_, value, child) {
                    if (controller.state.value == ProductState.loading) {
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      );
                    } else if (controller.state.value == ProductState.loaded) {
                      return Expanded(
                        child: ListView.separated(
                            separatorBuilder: (_, __) {
                              return Divider(
                                color: Colors.black45,
                              );
                            },
                            itemCount: controller.listProducts.value.length,
                            itemBuilder: (_, index) {
                              return _buildItemMenu(
                                  product:
                                      controller.listProducts.value[index]);
                            }),
                      );
                    }
                    return Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }

  _buildItemMenu({Product product}) {
    print(product.id);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  product.title.toUpperCase(),
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
                onPressed: () {
                  controller.deleteProduct(product);
                },
              )
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  product.description,
                  style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(
                Icons.edit,
                color: Colors.red,
              )
            ],
          ),
          Text(
            'R\$ ${product.price}'.toUpperCase(),
            style: TextStyle(fontSize: 18, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
