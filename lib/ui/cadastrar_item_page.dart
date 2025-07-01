import 'package:flutter/material.dart';

import '../repositores/congelado_model.dart' show CongeladoModel;
import '../stores/congelado_store.dart';

class CadastroItemPage extends StatefulWidget {
//  const CadastroItemPage({Key? key}) : super(key: key);
  final CongeladoStore store;
  
  const CadastroItemPage({Key? key, required this.store}) : super(key: key);

  @override
  State<CadastroItemPage> createState() => _CadastroItemPageState();
}

class _CadastroItemPageState extends State<CadastroItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _descricaoController = TextEditingController();
  final _localizacaoController = TextEditingController();

  late DateTime _dataProducao;
  late DateTime _dataValidade;

  @override
  void initState() {
    super.initState();
    _dataProducao = DateTime.now();
    _dataValidade = _dataProducao.add(const Duration(days: 30));
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    _localizacaoController.dispose();
    super.dispose();
  }

  Future<void> _selecionarDataProducao() async {
    final dataSelecionada = await showDatePicker(
      context: context,
      initialDate: _dataProducao,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (dataSelecionada != null) {
      setState(() {
        _dataProducao = dataSelecionada;
        _dataValidade = _dataProducao.add(const Duration(days: 30));
      });
    }
  }

  Future<void> _selecionarDataValidade() async {
    final dataSelecionada = await showDatePicker(
      context: context,
      initialDate: _dataValidade,
      firstDate: _dataProducao,
      lastDate: DateTime(2100),
    );
    if (dataSelecionada != null) {
      setState(() {
        _dataValidade = dataSelecionada;
      });
    }
  }

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Novo Item')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _descricaoController,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe a descrição' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _localizacaoController,
                decoration: const InputDecoration(
                  labelText: 'Localização',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe a localização' : null,
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _selecionarDataProducao,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Data de Produção',
                      border: const OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(
                      text: _formatarData(_dataProducao),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _selecionarDataValidade,
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Data de Validade',
                      border: const OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.calendar_today),
                    ),
                    controller: TextEditingController(
                      text: _formatarData(_dataValidade),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text('Salvar'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Aqui você pode salvar os dados se quiser
                        final novoItem = CongeladoModel(
                          id: UniqueKey().toString(), // ou use outro método para gerar id
                          name: _descricaoController.text,
                          localizacao: _localizacaoController.text,
                          dataproducao: _dataProducao,
                          datavalidade: _dataValidade,
                        );
                        widget.store.addCongelado(novoItem);
                        Navigator.pop(context); // Retorna para a página anterior
                      }
                    },
                  ),
                  OutlinedButton.icon(
                    icon: const Icon(Icons.cancel),
                    label: const Text('Cancelar'),
                    onPressed: () {
                      Navigator.pop(context); // Retorna para a página anterior
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}