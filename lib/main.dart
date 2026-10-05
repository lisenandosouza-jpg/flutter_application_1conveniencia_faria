import 'package:flutter/material.dart';

void main() {
  runApp(const ConvenienciaFariaApp());
}

// APLICAÇÃO

class ConvenienciaFariaApp extends StatelessWidget {
  const ConvenienciaFariaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Conveniência Faria',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      ),
      home: const LoginPage(),
    );
  }
}

// MODELO DO PRODUTO

class ProdutoInfo {
  final String nome;
  final String categoria;
  final double preco;
  int estoque;
  final String imagem;
  final List<String> aliases;

  ProdutoInfo({
    required this.nome,
    required this.categoria,
    required this.preco,
    required this.estoque,
    required this.imagem,
    required this.aliases,
  });
}

// DADOS DOS PRODUTOS

final List<ProdutoInfo> produtos = [
  ProdutoInfo(
    nome: 'Coca-Cola 2L',
    categoria: 'Refrigerante',
    preco: 12.00,
    estoque: 8,
    imagem: 'Assets/assets-imagens/cocacola.jpg',
    aliases: [
      'coca',
      'coca cola',
      'coca-cola',
      'refrigerante',
    ],
  ),
  ProdutoInfo(
    nome: 'Guaraná Antarctica 2L',
    categoria: 'Refrigerante',
    preco: 10.00,
    estoque: 15,
    imagem: 'Assets/assets-imagens/guaranaantartica.jpg',
    aliases: [
      'guarana',
      'guaraná',
      'antarctica',
    ],
  ),
  ProdutoInfo(
    nome: 'Red Bull 250ml',
    categoria: 'Energético',
    preco: 12.00,
    estoque: 4,
    imagem: 'Assets/assets-imagens/redbull.jpg',
    aliases: [
      'red bull',
      'redbull',
      'energetico',
      'energético',
    ],
  ),
  ProdutoInfo(
    nome: 'Água Mineral 500ml',
    categoria: 'Água',
    preco: 3.00,
    estoque: 25,
    imagem: 'Assets/assets-imagens/aguamineral.jpg',
    aliases: [
      'agua',
      'água',
      'agua mineral',
    ],
  ),
  ProdutoInfo(
    nome: 'Doritos 120g',
    categoria: 'Snack',
    preco: 9.00,
    estoque: 3,
    imagem: 'Assets/assets-imagens/doritos.jpg',
    aliases: [
      'doritos',
      'salgadinho',
      'snack',
    ],
  ),
];

// CARRINHO

class ItemCarrinho {
  final ProdutoInfo produto;
  int quantidade;

  ItemCarrinho({
    required this.produto,
    this.quantidade = 1,
  });

  double get subtotal => produto.preco * quantidade;
}

final List<ItemCarrinho> carrinho = [];

// FUNÇÕES AUXILIARES

String normalizar(String texto) {
  return texto
      .toLowerCase()
      .replaceAll('á', 'a')
      .replaceAll('à', 'a')
      .replaceAll('ã', 'a')
      .replaceAll('â', 'a')
      .replaceAll('é', 'e')
      .replaceAll('ê', 'e')
      .replaceAll('í', 'i')
      .replaceAll('ó', 'o')
      .replaceAll('ô', 'o')
      .replaceAll('õ', 'o')
      .replaceAll('ú', 'u')
      .replaceAll('ç', 'c');
}

// LOGIN

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  bool mostrarSenha = false;

  void entrar() {
    final email = emailController.text.trim();
    final senha = senhaController.text.trim();

    if (email == 'admin@faria.com' && senha == '123456') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomePage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'E-mail ou senha incorretos.',
          ),
        ),
      );
    }
  }

  void visitante() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 420,
              ),
              child: Column(
                children: [
                  Image.asset(
                    'Assets/assets-imagens/convenienciafaria.png',
                    height: 150,
                    errorBuilder: (_, __, ___) {
                      return const Icon(
                        Icons.store,
                        size: 100,
                        color: Colors.amber,
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Conveniência Faria',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Sistema de gestão e atendimento inteligente',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 35),

                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: senhaController,
                    obscureText: !mostrarSenha,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                      ),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            mostrarSenha = !mostrarSenha;
                          });
                        },
                        icon: Icon(
                          mostrarSenha
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: entrar,
                      icon: const Icon(Icons.login),
                      label: const Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: visitante,
                      icon: const Icon(
                        Icons.person_outline,
                      ),
                      label: const Text(
                        'Acessar como visitante',
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text(
                    'Projeto Integrado - Desenvolvimento Mobile',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// HOME

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void abrirProdutos() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ProdutosPage(),
      ),
    ).then((_) {
      setState(() {});
    });
  }

  void abrirCarrinho() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const CarrinhoPage(),
      ),
    ).then((_) {
      setState(() {});
    });
  }

  void abrirIA() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const IaPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Conveniência Faria',
        ),
        actions: [
          IconButton(
            tooltip: 'Carrinho',
            onPressed: abrirCarrinho,
            icon: Badge(
              isLabelVisible: carrinho.isNotEmpty,
              label: Text(
                carrinho.length.toString(),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
          ),
          IconButton(
            tooltip: 'Sair para o Login',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => const LoginPage(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 15),

            Image.asset(
              'Assets/assets-imagens/convenienciafaria.png',
              height: 130,
              errorBuilder: (_, __, ___) {
                return const Icon(
                  Icons.store,
                  size: 100,
                  color: Colors.amber,
                );
              },
            ),

            const SizedBox(height: 20),

            const Text(
              'Bem-vindo à Conveniência Faria!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Produtos, estoque, compras e atendimento inteligente em um só lugar.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            // PRODUTOS
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.shopping_bag_outlined,
                        size: 45,
                        color: Colors.amber,
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'Catálogo de Produtos',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Consulte produtos, preços e estoque.',
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: abrirProdutos,
                          child: const Text(
                            'Ver Produtos',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // CARRINHO
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.shopping_cart_outlined,
                        size: 45,
                        color: Colors.green,
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'Meu Carrinho',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        carrinho.isEmpty
                            ? 'Seu carrinho está vazio.'
                            : '${carrinho.length} item(ns) no carrinho.',
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: abrirCarrinho,
                          child: const Text(
                            'Abrir Carrinho',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // IA
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.smart_toy_outlined,
                        size: 45,
                        color: Colors.blue,
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        'Faria IA',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        'Converse com o assistente inteligente da conveniência.',
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: abrirIA,
                          icon: const Icon(
                            Icons.chat_outlined,
                          ),
                          label: const Text(
                            'Conversar com Faria IA',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Projeto Integrado • Desenvolvimento Mobile',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// PRODUTOS

class ProdutosPage extends StatefulWidget {
  const ProdutosPage({super.key});

  @override
  State<ProdutosPage> createState() => _ProdutosPageState();
}

class _ProdutosPageState extends State<ProdutosPage> {
  void adicionarAoCarrinho(ProdutoInfo produto) {
    final existente = carrinho.where(
      (item) => item.produto.nome == produto.nome,
    );

    if (existente.isNotEmpty) {
      final item = existente.first;

      if (item.quantidade < produto.estoque) {
        setState(() {
          item.quantidade++;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${produto.nome} adicionado ao carrinho.',
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Quantidade máxima disponível em estoque.',
            ),
          ),
        );
      }
    } else {
      if (produto.estoque > 0) {
        setState(() {
          carrinho.add(
            ItemCarrinho(
              produto: produto,
            ),
          );
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${produto.nome} adicionado ao carrinho.',
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar ao Menu',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Produtos',
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CarrinhoPage(),
                ),
              ).then((_) {
                setState(() {});
              });
            },
            icon: Badge(
              isLabelVisible: carrinho.isNotEmpty,
              label: Text(
                carrinho.length.toString(),
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
              ),
            ),
          ),
        ],
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: produtos.length,
        itemBuilder: (context, index) {
          final produto = produtos[index];

          return ProdutoCard(
            produto: produto,
            onAdicionar: () {
              adicionarAoCarrinho(produto);
            },
          );
        },
      ),
    );
  }
}

// CARTÃO DO PRODUTO

class ProdutoCard extends StatelessWidget {
  final ProdutoInfo produto;
  final VoidCallback onAdicionar;

  const ProdutoCard({
    super.key,
    required this.produto,
    required this.onAdicionar,
  });

  @override
  Widget build(BuildContext context) {
    final estoqueBaixo = produto.estoque <= 5;

    return Card(
      margin: const EdgeInsets.only(
        bottom: 12,
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                produto.imagem,
                width: 90,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Container(
                    width: 90,
                    height: 90,
                    color: Colors.grey.shade200,
                    child: const Icon(
                      Icons.image_not_supported_outlined,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    produto.nome,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    produto.categoria,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 7),

                  Text(
                    'R\$ ${produto.preco.toStringAsFixed(2).replaceAll('.', ',')}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Row(
                    children: [
                      Icon(
                        estoqueBaixo
                            ? Icons.warning_amber
                            : Icons.inventory_2_outlined,
                        size: 17,
                        color: estoqueBaixo ? Colors.red : Colors.green,
                      ),

                      const SizedBox(width: 5),

                      Text(
                        'Estoque: ${produto.estoque}',
                        style: TextStyle(
                          color: estoqueBaixo ? Colors.red : Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),

                  if (estoqueBaixo)
                    const Text(
                      'Estoque baixo',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(width: 5),

            IconButton(
              tooltip: 'Adicionar ao carrinho',
              onPressed: onAdicionar,
              style: IconButton.styleFrom(
                backgroundColor: Colors.amber,
              ),
              icon: const Icon(
                Icons.add_shopping_cart,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// CARRINHO

class CarrinhoPage extends StatefulWidget {
  const CarrinhoPage({super.key});

  @override
  State<CarrinhoPage> createState() => _CarrinhoPageState();
}

class _CarrinhoPageState extends State<CarrinhoPage> {
  double get total {
    return carrinho.fold(
      0,
      (soma, item) => soma + item.subtotal,
    );
  }

  void aumentar(ItemCarrinho item) {
    if (item.quantidade < item.produto.estoque) {
      setState(() {
        item.quantidade++;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Não há mais unidades disponíveis.',
          ),
        ),
      );
    }
  }

  void diminuir(ItemCarrinho item) {
    setState(() {
      if (item.quantidade > 1) {
        item.quantidade--;
      } else {
        carrinho.remove(item);
      }
    });
  }

  void finalizarPedido() {
    if (carrinho.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Seu carrinho está vazio.',
          ),
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Pedido simulado',
          ),
          content: Text(
            'Pedido realizado com sucesso!\n\n'
            'Total: R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}\n\n'
            'Esta é uma demonstração acadêmica. '
            'Nenhuma cobrança foi realizada.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);

                setState(() {
                  carrinho.clear();
                });
              },
              child: const Text(
                'OK',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar ao Menu',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Meu Carrinho',
        ),
      ),

      body: carrinho.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.shopping_cart_outlined,
                      size: 80,
                      color: Colors.grey,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      'Seu carrinho está vazio.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      'Adicione produtos para continuar.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 25),

                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.home),
                      label: const Text('Voltar ao Menu Principal'),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: carrinho.length,
                    itemBuilder: (context, index) {
                      final item = carrinho[index];

                      return Card(
                        margin: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Image.asset(
                                item.produto.imagem,
                                width: 65,
                                height: 65,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) {
                                  return const Icon(
                                    Icons.image,
                                    size: 55,
                                  );
                                },
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.produto.nome,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      'R\$ ${item.produto.preco.toStringAsFixed(2).replaceAll('.', ',')} cada',
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      'Subtotal: R\$ ${item.subtotal.toStringAsFixed(2).replaceAll('.', ',')}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Column(
                                children: [
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          diminuir(item);
                                        },
                                        icon: const Icon(
                                          Icons.remove_circle_outline,
                                        ),
                                      ),

                                      Text(
                                        '${item.quantidade}',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      IconButton(
                                        onPressed: () {
                                          aumentar(item);
                                        },
                                        icon: const Icon(
                                          Icons.add_circle_outline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // RESUMO
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 8,
                        color: Colors.black.withOpacity(0.08),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total do pedido',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'R\$ ${total.toStringAsFixed(2).replaceAll('.', ',')}',
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 15),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton.icon(
                            onPressed: finalizarPedido,
                            icon: const Icon(Icons.check_circle_outline),
                            label: const Text(
                              'Finalizar Pedido',
                              style: TextStyle(fontSize: 16),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              foregroundColor: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

// FARIA IA

class IaPage extends StatefulWidget {
  const IaPage({super.key});

  @override
  State<IaPage> createState() => _IaPageState();
}

class _IaPageState extends State<IaPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _mensagens = [
    {
      'remetente': 'ia',
      'texto': 'Olá! Sou o assistente Faria IA. Como posso te ajudar hoje?'
    }
  ];

  void _enviarMensagem() {
    final texto = _controller.text.trim();
    if (texto.isEmpty) return;

    setState(() {
      _mensagens.add({'remetente': 'user', 'texto': texto});
      _controller.clear();
    });

    // Resposta simulada simples
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() {
        _mensagens.add({
          'remetente': 'ia',
          'texto':
              'Entendi! Em breve poderei consultar nosso estoque em tempo real para te ajudar.'
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Voltar ao Menu',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Faria IA'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _mensagens.length,
              itemBuilder: (context, index) {
                final msg = _mensagens[index];
                final isUser = msg['remetente'] == 'user';

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.amber.shade200 : Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.05),
                        )
                      ],
                    ),
                    child: Text(msg['texto'] ?? ''),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Digite sua mensagem...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.amber),
                  onPressed: _enviarMensagem,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}