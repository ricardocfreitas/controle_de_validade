import 'package:controle_de_validade/api/congelado_api.dart';
import 'package:controle_de_validade/stores/congelado_store.dart';
import 'package:flutter/material.dart';

import 'cadastrar_item_page.dart';
import 'card_page.dart';

class ProdutosVencidosPage extends StatefulWidget {
  const ProdutosVencidosPage({super.key});

  @override
  State<ProdutosVencidosPage> createState() => _ProdutosVencidosPageState();
}

class _ProdutosVencidosPageState extends State<ProdutosVencidosPage> {
  final store = CongeladoStore(CongeladoApi());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    store.fetchCongelados();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: store,
      builder: (context, _) {
        final congelados = store.congelados;
        return Scaffold(
          appBar: AppBar(title: Text('Controle de Validade')),
          body: ListView.builder(
            itemCount: congelados.length,
            itemBuilder: (context, index) {
              final congelado = congelados[index];

              return Dismissible(
                key: Key(congelado.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  store.removerCongelado(congelado); // Você vai criar esse método na store
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${congelado.name} removido')),
                  );
                },
                child: ItemCard(
                  descricao: congelado.name,
                  localizacao: congelado.localizacao,
                  dataValidade: congelado.datavalidade,
              ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CadastroItemPage(store: store),
                ),
              );              
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}


// setState(() {
//                 store.addCongelado(
//                   CongeladoModel(
//                     id: '5',
//                     name: 'produto 5',
//                     localizacao: '05-A',
//                     dataproducao: DateTime(2025, 01, 05),
//                     datavalidade: DateTime(2025, 01, 05),
//                   ),
//                 );
//               });