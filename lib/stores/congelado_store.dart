import 'package:controle_de_validade/api/congelado_api.dart';
import 'package:flutter/material.dart';
import '../repositores/congelado_model.dart';

class CongeladoStore extends ChangeNotifier {
  CongeladoStore(this._congeladoApi);
  final CongeladoApi _congeladoApi;
  List<CongeladoModel> _congelados = [];

  List<CongeladoModel> get congelados => List.unmodifiable(_congelados);

  Future<void> fetchCongelados() async {
    final congelados = await _congeladoApi.fetchCongelados();
    _congelados = congelados;
    _congelados.sort((a, b) => a.datavalidade.compareTo(b.datavalidade));
    notifyListeners();
  }

  void addCongelado(CongeladoModel congelado) {
    _congelados.add(congelado);
    _congelados.sort((a, b) => a.datavalidade.compareTo(b.datavalidade));
    notifyListeners();
  }
  
  void removerCongelado(CongeladoModel congelado) {
    _congelados.removeWhere((item) => item.id == congelado.id);
    notifyListeners();
  }  
}
