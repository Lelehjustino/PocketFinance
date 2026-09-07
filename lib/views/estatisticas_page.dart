import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:pocket/controllers/estatisticas_controller.dart';
import 'package:pocket/views/configuracoes_page.dart';
import 'package:pocket/views/home_page.dart';
import 'package:pocket/views/transacoes_page.dart';

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

                        return Card(
                          child: ListTile(
                            title: Text(categoria['nome']),
                            trailing: Text(
                              "R\$ ${(categoria['total'] as num).toStringAsFixed(2)}",
                            ),
                          ),
                        );

                      })

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
                  selecionado: false,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TransacoesPage (),
                      ),
                    );
                  },
                ),

                _bottomItem(
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