import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:pocket/controllers/estatisticas_controller.dart';
import 'package:pocket/views/configuracoes_page.dart';
import 'package:pocket/views/home_page.dart';
import 'package:pocket/views/transacoes_page.dart';
import 'package:pocket/widgets/_bottomItem.dart';

class EstatisticasPage extends StatefulWidget {
  const EstatisticasPage({super.key});

  @override
  State<EstatisticasPage> createState() => _EstatisticasPageState();
}

class _EstatisticasPageState extends State<EstatisticasPage> {

  double receitas = 0;
  double despesas = 0;
  int quantidade = 0;

  List<Map<String, dynamic>> categorias = [];
  final EstatisticasController estatisticasController = Get.find<EstatisticasController>();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  Future<void> carregarDados() async {
    final totalReceitas = await estatisticasController.totalReceitas();
    final totalDespesas = await estatisticasController.totalDespesas();
    final totalTransacoes = await estatisticasController.quantidadeTransacoes();
    final gastos = await estatisticasController.gastosPorCategoria();

    if (!mounted) return;

    setState(() {
      receitas = totalReceitas;
      despesas = totalDespesas;
      quantidade = totalTransacoes;
      categorias = gastos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove a seta de voltar
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Estatísticas',
        ),
        centerTitle: true, // Centraliza o título
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
                SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [

                      Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.trending_up,
                            color: Colors.green,
                          ),
                          title: Text("Receitas"),
                          trailing: Text(
                            "R\$ ${receitas.toStringAsFixed(2)}",
                          ),
                        ),
                      ),

                      SizedBox(height: 12),

                      Card(
                        child: ListTile(
                          leading: Icon(
                            Icons.trending_down,
                            color: Colors.red,
                          ),
                          title: Text("Despesas"),
                          trailing: Text(
                            "R\$ ${despesas.toStringAsFixed(2)}",
                          ),
                        ),
                      ),

                      SizedBox(height: 12),

                      Card(
                        child: ListTile(
                          leading: Icon(Icons.receipt_long),
                          title: Text("Transações"),
                          trailing: Text(
                            quantidade.toString(),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Gastos por categoria",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      SizedBox(height: 12),

                      ...categorias.map((categoria) {
                      final double total = (categoria['total'] as num).toDouble();

                      double porcentagem = 0;

                      if (despesas > 0) {
                        porcentagem = total * 100 / despesas;
                      }

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      categoria['nome'],
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    const SizedBox(height: 10),

                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: LinearProgressIndicator(
                                        value: (porcentagem / 100).clamp(0.0, 1.0),
                                        minHeight: 6,
                                        backgroundColor: Colors.grey.withOpacity(0.15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 20),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "R\$ ${total.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    "${porcentagem.toStringAsFixed(0)}%",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    ],
                  ),
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
                  selecionado: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (_, __, ___) => TransacoesPage(),
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
                  icon: Icons.bar_chart,
                  texto: 'Estatísticas',
                  selecionado: true,
                  onTap: () {
                    
                  },
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}