import 'package:flutter/material.dart';
import 'package:pocket/views/configuracoes_page.dart';
import 'package:pocket/views/home_page.dart';
import 'package:pocket/views/transacoes_page.dart';

class EstatisticasPage extends StatefulWidget {
  const EstatisticasPage({super.key});

  @override
  State<EstatisticasPage> createState() => _EstatisticasPageState();
}

class _EstatisticasPageState extends State<EstatisticasPage> {
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