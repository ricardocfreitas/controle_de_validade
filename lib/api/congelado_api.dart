import '../repositores/congelado_model.dart';

class CongeladoApi {
  Future<List<CongeladoModel>> fetchCongelados() async {
    await Future.delayed(Duration(seconds: 2));
    return [
      CongeladoModel(
        id: '1',
        name: 'Acem',
        localizacao: '01-A',
        dataproducao: DateTime(2025, 07, 01),
        datavalidade: DateTime(2025, 07, 31),
      ),
      CongeladoModel(
        id: '2',
        name: 'Patinho',
        localizacao: '01-B',
        dataproducao: DateTime(2025, 06, 03),
        datavalidade: DateTime(2025, 07, 03),
      ),
      CongeladoModel(
        id: '3',
        name: 'Picanha',
        localizacao: '03-A',
        dataproducao: DateTime(2025, 06, 01),
        datavalidade: DateTime(2025, 06, 30),
      ),
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
