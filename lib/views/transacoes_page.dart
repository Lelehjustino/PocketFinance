import 'package:flutter/material.dart';
import 'package:pocket/views/estatisticas_page.dart';
import 'package:pocket/views/home_page.dart';
import 'package:pocket/views/nova_transacao_page.dart';

class TransacoesPage extends StatefulWidget {
  const TransacoesPage({super.key});

  @override
  State<TransacoesPage> createState() => _TransacoesPageState();
}

class _TransacoesPageState extends State<TransacoesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transações"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [

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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => NovaTransacaoPage(),
            ),
          );
        },
        child: Icon(Icons.add),
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