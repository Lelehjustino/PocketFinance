import 'package:flutter/material.dart';
import 'package:pocket/data/database_helper.dart';
import 'package:pocket/views/home_page.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Configurações',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.rocket_launch_rounded,
                              size: 70,
                              color: colorScheme.primary,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Bem-vindo!",
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Este aplicativo foi desenvolvido para tornar sua experiência "
                              "mais simples, rápida e personalizada.\n\n"
                              "Antes de começar, configure algumas preferências para que o "
                              "aplicativo funcione da melhor forma para você.",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(height: 24),
                            Divider(),
                            const SizedBox(height: 16),
                            ListTile(
                              leading: Icon(
                                Icons.security,
                                color: colorScheme.primary,
                              ),
                              title: const Text("Dados seguros"),
                              subtitle: const Text(
                                "Suas informações permanecem protegidas.",
                              ),
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.check_circle,
                                color: colorScheme.primary,
                              ),
                              title: const Text("Tudo pronto"),
                              subtitle: const Text(
                                "Após salvar, você poderá utilizar todos os recursos.",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                      ),
                      onPressed: () async {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Configurações salvas!")),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HomePage(),
                          ),
                        );
                      },
                      child: Text(
                        "Salvar configurações",
                        style: TextStyle(
                          color: colorScheme.surface,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}