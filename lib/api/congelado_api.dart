import '../repositores/congelado_model.dart';

class CongeladoApi {
  Future<List<CongeladoModel>> fetchCongelados() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      // CongeladoModel(
      //   id: '1',
      //   name: 'produto 1',
      //   localizacao: '01-A',
      //   dataproducao: DateTime(2025, 01, 01),
      //   datavalidade: DateTime(2025, 02, 01),
      // ),
      // CongeladoModel(
      //   id: '2',
      //   name: 'produto 2',
      //   localizacao: '02-A',
      //   dataproducao: DateTime(2025, 01, 02),
      //   datavalidade: DateTime(2025, 02, 02),
      // ),
      // CongeladoModel(
      //   id: '3',
      //   name: 'produto 3',
      //   localizacao: '03-A',
      //   dataproducao: DateTime(2025, 01, 03),
      //   datavalidade: DateTime(2025, 02, 03),
      // ),
      // CongeladoModel(
      //   id: '4',
      //   name: 'produto 4',
      //   localizacao: '04-A',
      //   dataproducao: DateTime(2025, 01, 03),
      //   datavalidade: DateTime(2025, 07, 04),
      // ),
    ];
  }
}
