import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pocket/controllers/transacoes_controller.dart';
import 'package:pocket/views/configuracoes_page.dart';
import 'package:pocket/views/estatisticas_page.dart';
import 'package:pocket/views/home_page.dart';
import 'package:pocket/views/nova_transacao_page.dart';

class TransacoesPage extends StatefulWidget {
  const TransacoesPage({super.key});

  @override
  State<TransacoesPage> createState() => _TransacoesPageState();
}

class _TransacoesPageState extends State<TransacoesPage> {
  final transacoesController = Get.find<TransacoesController>();
  DateTime? dataSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Transações',
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ConfiguracoesPage(),
                ),
              );
            },
            icon: Icon(Icons.settings),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                // FILTRO DE DATA
                GestureDetector(
                  onTap: () {
                    
                  },
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Color(0xFFE0E0E0),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today, size: 18),
                  
                                SizedBox(width: 10),
                  
                                Text(
                                  dataSelecionada == null
                                    ? 'Todas as datas'
                                    : '${dataSelecionada!.day.toString().padLeft(2, '0')}/'
                                      '${dataSelecionada!.month.toString().padLeft(2, '0')}/'
                                      '${dataSelecionada!.year}',
                                ),
                              ],
                            ),
                          ),
                        ),
                  
                        if (dataSelecionada != null)
                          IconButton(
                            onPressed: () {
                              setState(() {
                                dataSelecionada = null;
                              });
                            },
                            icon: Icon(Icons.close),
                          ),
                      ],
                    ),
                  ),
                ),

                // LISTA
                Expanded(
                  child: Obx(() {
                      final transacoes = transacoesController.transacoes.where((transacao) {
                      if (dataSelecionada == null) {
                        return true;
                      }

                      return transacao.data.year == dataSelecionada!.year &&
                          transacao.data.month == dataSelecionada!.month &&
                          transacao.data.day == dataSelecionada!.day;
                    }).toList();

                    if (transacoes.isEmpty) {
                      return Center(
                        child: Text(
                          'Nenhuma transação encontrada.',
                        ),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      itemCount: transacoes.length,
                      itemBuilder: (context, index) {
                        final transacao = transacoes[index];

                        return Card(
                          margin: EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: transacao.receita
                                  ? Colors.green.shade100
                                  : Colors.red.shade100,
                              child: Icon(
                                transacao.receita
                                    ? Icons.arrow_downward
                                    : Icons.arrow_upward,
                                color: transacao.receita
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),

                            title: Text(
                              transacao.nome,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            subtitle: Text(
                              '${transacao.data.day.toString().padLeft(2, '0')}/'
                              '${transacao.data.month.toString().padLeft(2, '0')}/'
                              '${transacao.data.year}',
                            ),

                            trailing: Text(
                              'R\$ ${transacao.valor.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: transacao.receita
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
           Container(
            height: 58,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Color(0xFFE0E0E0),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _bottomItem(
                  icon: Icons.home,
                  texto: 'Início',
                  selecionado: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HomePage()
                      ),
                    );
                  },
                ),

                _bottomItem(
                  icon: Icons.swap_horiz,
                  texto: 'Transações',
                  selecionado: true,
                  onTap: () {
                  
                  },
                ),

                _bottomItem(
                  icon: Icons.bar_chart,
                  texto: 'Estatísticas',
                  selecionado: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EstatisticasPage (),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 60),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,MaterialPageRoute(
                builder: (_) => NovaTransacaoPage(),
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  // ITEM DO MENU INFERIOR
  Widget _bottomItem({
    required IconData icon,
    required String texto,
    required bool selecionado,
    required Function? onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        onTap?.call();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 20,
            color: selecionado
                ? colorScheme.primary
                : colorScheme.onSurfaceVariant,
          ),
      
          SizedBox(height: 2),
      
          Text(
            texto,
            style: TextStyle(
              fontSize: 9,
              color: selecionado
                  ? colorScheme.primary
                  : colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}