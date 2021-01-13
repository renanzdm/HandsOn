import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:handson/app/infra/dependency_injection/injection.dart';
import 'package:handson/app/modules/loja/presenter/pages/controller/product_operations_controller.dart';

class AddProduct extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var sizes = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.grey.shade600),
        ),
        title: Text(
          'Editar Produto',
          style: TextStyle(color: Colors.grey.shade600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 1100,
          child: DefaultTabController(
            length: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Imagem de capa',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    width: sizes.width,
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/loja.jpg'),
                        colorFilter:
                            ColorFilter.mode(Colors.black26, BlendMode.darken),
                      ),
                    ),
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.white,
                      ),
                      label: Text(
                        'Alterar foto',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TabBar(
                    indicatorColor: Colors.red,
                    labelColor: Colors.red,
                    unselectedLabelColor: Colors.grey.shade600,
                    tabs: [
                      Tab(
                        child: Text(
                          'Informações',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Ingredientes',
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Rendimento',
                        ),
                      )
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ProductInformation(),
                        Container(
                          color: Colors.purple,
                        ),
                        Container(color: Colors.pink),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductInformation extends StatefulWidget {
  @override
  _ProductInformationState createState() => _ProductInformationState();
}

class _ProductInformationState extends State<ProductInformation> {
  final controller = inject.get<ProductOperationsController>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            'Título',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Campo Obrigatorio';
              }
              return null;
            },
            onChanged: (title) {
              controller.title = title;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Categoria do produto',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          ValueListenableBuilder(
            valueListenable: controller.dropDownMenuValueCategory,
            builder: (context, String value, child) {
              return DropdownButton<String>(
                isExpanded: true,
                hint:Text(value),
                items: controller.listOfCategory
                    .map<DropdownMenuItem<String>>(
                        (String e) => DropdownMenuItem<String>(
                              child: Text(e),
                          value: e,
                            ))
                    .toList(),
                onChanged: (v) {
                controller.dropDownMenuValueCategory.value = v;
                print(v);

                },
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Descrição do produto',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Campo Obrigatorio';
              }
              return null;
            },
            onChanged: (description) {
              controller.description = description;
            },
            maxLines: 5,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Valor',
            style: TextStyle(color: Colors.grey.shade600),
          ),
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Campo Obrigatorio';
              }
              return null;
            },
            onChanged: (price) {
              controller.price = double.parse(price);
            },
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(12),
            alignment: Alignment.center,
            height: 40,
            child: Text(
              'Aplicar desconto sobre o total',
              style: TextStyle(color: Colors.red),
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 1.5),
                borderRadius: BorderRadius.circular(8)),
          ),
          InkWell(
            onTap: () {
              if (_formKey.currentState.validate()) {
                controller.createProduct();
                controller.getProducts();

                Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Salvando')));
              }
            },
            child: Container(
              margin: const EdgeInsets.all(12),
              alignment: Alignment.center,
              height: 40,
              child: Text(
                'Salvar Informações',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          )
        ],
      ),
    );
  }
}
