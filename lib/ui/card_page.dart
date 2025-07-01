import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String descricao;
  final String localizacao;
  final DateTime dataValidade;
  final VoidCallback? onTap;

  const ItemCard({
    Key? key,
    required this.descricao,
    required this.localizacao,
    required this.dataValidade,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DateTime agora = DateTime.now();
    final bool isVencido = agora.isAfter(dataValidade);
    final bool isVencendoEm7Dias =
        !isVencido &&
        dataValidade.difference(agora).inDays <= 7 &&
        dataValidade.difference(agora).inDays >= 0;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color:
              isVencido
                  ? Colors.red.shade300
                  : isVencendoEm7Dias
                  ? Colors.orange.shade600
                  : Colors.transparent,
          width: (isVencido || isVencendoEm7Dias) ? 2 : 0,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Descrição
              Text(
                descricao,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color:
                      isVencido
                          ? Colors.red.shade700
                          : isVencendoEm7Dias
                          ? Colors.orange.shade700
                          : null,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              // Localização
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      localizacao,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Data de validade
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color:
                        isVencido
                            ? Colors.red.shade600
                            : isVencendoEm7Dias
                            ? Colors.orange.shade600
                            : Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Válido até: ${_formatarData(dataValidade)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color:
                          isVencido
                              ? Colors.red.shade600
                              : isVencendoEm7Dias
                              ? Colors
                                  .orange
                                  .shade600 // ALTERAÇÃO
                              : Colors.grey.shade600,
                      fontWeight:
                          (isVencido || isVencendoEm7Dias)
                              ? FontWeight.bold
                              : FontWeight.normal, // ALTERAÇÃO
                    ),
                  ),
                  if (isVencido) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'VENCIDO',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ),
                  ] else if (isVencendoEm7Dias) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text( 
                        'VENCE EM ${dataValidade.difference(agora).inDays} DIAS',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade700,
                        ),
                      ), 
                    ), 
                  ], 
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatarData(DateTime data) {
    return '${data.day.toString().padLeft(2, '0')}/${data.month.toString().padLeft(2, '0')}/${data.year}';
  }
}
