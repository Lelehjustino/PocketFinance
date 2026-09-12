import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pocket/controllers/transacoes_controller.dart';
import 'package:pocket/views/configuracoes_page.dart';
import 'package:pocket/views/estatisticas_page.dart';
import 'package:pocket/views/home_page.dart';
import 'package:pocket/views/nova_transacao_page.dart';
import 'package:pocket/widgets/_bottomItem.dart';

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
    final colorScheme = Theme.of(context).colorScheme;
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
                /*GestureDetector(
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
                ),*/

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

                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListView.builder(
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
                      
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'R\$ ${transacao.valor.toStringAsFixed(2)}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: transacao.receita
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),

                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async {
                                        final confirmar = await showDialog<bool>(
                                          context: context,
                                          builder: (_) => AlertDialog(
                                            title: const Text('Excluir transação'),
                                            content: const Text(
                                              'Deseja realmente excluir esta transação?',
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: colorScheme.primary,
                                                ),
                                                onPressed: () => Navigator.pop(context, false),
                                                child: Text(
                                                  'Cancelar',
                                                  style: TextStyle(
                                                    color: colorScheme.onPrimary,
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: colorScheme.error,
                                                ),
                                                onPressed: () => Navigator.pop(context, true),
                                                child: Text(
                                                  'Excluir',
                                                  style: TextStyle(
                                                    color: colorScheme.onPrimary,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );

                                        if (confirmar == true) {
                                          await transacoesController.deletarTransacao(transacao.id);

                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(
                                              content: Text('Transação excluída.'),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                            ),
                          );
                        },
                      ),
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
                BottomItem(
                  icon: Icons.home,
                  texto: 'Início',
                  selecionado: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => HomePage(),
                        transitionDuration: Duration(milliseconds: 150),
                        reverseTransitionDuration: Duration(milliseconds: 150),
                        transitionsBuilder: (_, animation, __, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                ),

                BottomItem(
                  icon: Icons.swap_horiz,
                  texto: 'Transações',
                  selecionado: true,
                  onTap: () {
                  
                  },
                ),

                BottomItem(
                  icon: Icons.bar_chart,
                  texto: 'Estatísticas',
                  selecionado: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => EstatisticasPage(),
                        transitionDuration: Duration(milliseconds: 150),
                        reverseTransitionDuration: Duration(milliseconds: 150),
                        transitionsBuilder: (_, animation, __, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
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
}