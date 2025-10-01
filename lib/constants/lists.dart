import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:simple_nav_bar/constants/images.dart';

const socialIconList = [icFacebookLogo, icGoogleLogo, icXLogo];

final iconMap = {
    "Électronique": "📱",
    "Mode": "👔",
    "Maison": "🏠",
    "Véhicules": "🚗",
    "Immobilier": "🛋️",
    "Loisirs": "⚽️",
    "Matériels": "💼",
    "Enfants": "🧸",
    "Autres": "❓",
  };

final List<Map<String, dynamic>> categoriesSelection = [
  {
    'subcategory': [
      'Fiat',
      'Renault',
      'Volkswagen',
      'Ford',
      'Opel',
      'Peugeot',
      'Accessoires',
      'Véhicules (İkinci El)',
      'Elektrik',
      'Motor & Mekanik',
      'Yürüyen & Direksiyon',
      'Isıtma & Havalandırma & Klima',
      'Şanzıman & Vites',
      'Ateşleme & Yakıt',
      'Fren & Debriyaj',
    ],
    'label': "Véhicules",
    'icon': "🚗",
  },
  {
    'subcategory': [
      'Smartphones',
      'Tablettes',
      'Ordinateurs portables',
      'Ordinateurs de bureau',
      'Téléviseurs',
      'Appareils photo',
      'Accessoires',
      'Consoles de jeux',
      'Casques audio',
      'Montres connectées',
      'Imprimantes',
      'Composants PC',
      'Objets connectés',
      'Électroménager',
    ],
    'label': "Électronique",
    'icon': "📱",
  },
  {'subcategory': null, 'label': "Maison", 'icon': "🏠"},
  {'subcategory': null, 'label': "Mode", 'icon': "👔"},
  {'subcategory': null, 'label': "Beauté", 'icon': "💄"},
  {'subcategory': null, 'label': "Enfants", 'icon': "🧸"},
  {'subcategory': null, 'label': "Sports", 'icon': "⚽"},
  {'subcategory': null, 'label': "Services", 'icon': "🛠️"},
  {'subcategory': null, 'label': "Emplois", 'icon': "💼"},
  {'subcategory': null, 'label': "Emplois", 'icon': "🛋️"},
];

final List<Map<String, dynamic>> categories1 = [
  {
    'label': 'Tous',
    'icon': LucideIcons.layoutGrid,
    'color': Colors.grey,
    'subcategory': null,
  },
  {
    'label': 'Véhicules',
    'icon': LucideIcons.car,
    'color': Colors.blue,
    'subcategory': [
      'Fiat',
      'Renault',
      'Volkswagen',
      'Ford',
      'Opel',
      'Peugeot',
      'Accessoires',
      'Véhicules (İkinci El)',
      'Elektrik',
      'Motor & Mekanik',
      'Yürüyen & Direksiyon',
      'Isıtma & Havalandırma & Klima',
      'Şanzıman & Vites',
      'Ateşleme & Yakıt',
      'Fren & Debriyaj',
    ],
  },
  {
    'label': 'Immobilier',
    'icon': LucideIcons.home,
    'color': Colors.green,
    'subcategory': null,
  },
  {
    'label': 'Électronique',
    'icon': LucideIcons.smartphone,
    'color': Colors.purple,
    'subcategory': [
      'Smartphones',
      'Tablettes',
      'Ordinateurs portables',
      'Ordinateurs de bureau',
      'Téléviseurs',
      'Appareils photo',
      'Accessoires',
      'Consoles de jeux',
      'Casques audio',
      'Montres connectées',
      'Imprimantes',
      'Composants PC',
      'Objets connectés',
      'Électroménager',
    ],
  },
  {
    'label': 'Mode',
    'icon': LucideIcons.shirt,
    'color': Colors.pink,
    'subcategory': null,
  },
  {
    'label': 'Meubles',
    'icon': LucideIcons.sofa,
    'color': Colors.amber,
    'subcategory': null,
  },
  {
    'label': 'Emplois',
    'icon': LucideIcons.briefcase,
    'color': Colors.blue,
    'subcategory': null,
  },
  {
    'label': 'Services',
    'icon': LucideIcons.wrench,
    'color': Colors.grey,
    'subcategory': null,
  },
  {
    'label': 'Loisirs',
    'icon': LucideIcons.gamepad,
    'color': Colors.indigo,
    'subcategory': null,
  },
  {
    'label': 'Animaux',
    'icon': LucideIcons.heart,
    'color': Colors.pinkAccent,
    'subcategory': null,
  },
  {
    'label': 'Livres',
    'icon': LucideIcons.bookOpen,
    'color': Colors.green,
    'subcategory': null,
  },
  {
    'label': 'Sports',
    'icon': LucideIcons.dumbbell,
    'color': Colors.orange,
    'subcategory': null,
  },
  {
    'label': 'Musique',
    'icon': LucideIcons.music,
    'color': Colors.deepPurple,
    'subcategory': null,
  },
  {
    'label': 'Art',
    'icon': LucideIcons.paintbrush,
    'color': Colors.yellow,
    'subcategory': null,
  },
  {
    'label': 'Jouets',
    'icon': LucideIcons.baby,
    'color': Colors.cyan,
    'subcategory': null,
  },
  {
    'label': 'Jardin',
    'icon': LucideIcons.flower,
    'color': Colors.green,
    'subcategory': null,
  },
  {
    'label': 'Beauté',
    'icon': LucideIcons.scissors,
    'color': Colors.pink,
    'subcategory': null,
  },
  {
    'label': 'Santé',
    'icon': LucideIcons.stethoscope,
    'color': Colors.red,
    'subcategory': null,
  },
  {
    'label': 'Alimentation',
    'icon': LucideIcons.apple,
    'color': Colors.lime,
    'subcategory': null,
  },
  {
    'label': 'Voyage',
    'icon': LucideIcons.plane,
    'color': Colors.lightBlue,
    'subcategory': null,
  },
  {
    'label': 'Éducation',
    'icon': LucideIcons.graduationCap,
    'color': Colors.blue,
    'subcategory': null,
  },
  {
    'label': 'Technologie',
    'icon': LucideIcons.laptop,
    'color': Colors.indigo,
    'subcategory': null,
  },
  {
    'label': 'Antiquités',
    'icon': LucideIcons.clock,
    'color': Colors.amber,
    'subcategory': null,
  },
  {
    'label': 'Bijoux',
    'icon': LucideIcons.diamond,
    'color': Colors.purple,
    'subcategory': null,
  },
  {
    'label': 'Photographie',
    'icon': LucideIcons.camera,
    'color': Colors.grey,
    'subcategory': null,
  },
  {
    'label': 'Outils',
    'icon': LucideIcons.hammer,
    'color': Colors.orange,
    'subcategory': null,
  },
  {
    'label': 'Bébé',
    'icon': LucideIcons.baby,
    'color': Colors.pink,
    'subcategory': null,
  },
  {
    'label': 'Bureau',
    'icon': LucideIcons.printer,
    'color': Colors.blue,
    'subcategory': null,
  },
  {
    'label': 'Extérieur',
    'icon': LucideIcons.tent,
    'color': Colors.green,
    'subcategory': null,
  },
  {
    'label': 'Bricolage',
    'icon': LucideIcons.hammer,
    'color': Colors.yellow,
    'subcategory': null,
  },
];

final List<Map<String, String>> featuredAds = [
  {
    'image':
        'https://cdn.pixabay.com/photo/2016/11/20/09/06/laptop-1842297_1280.jpg',
    'name': 'Adam_djiane',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '160 €',
    'location': "N'Djamena /\nN'Djamena-Centre",
    'date': 'HIER',
  },
  {
    'image':
        'https://cdn.pixabay.com/photo/2015/05/15/02/07/computer-767781_1280.jpg',
    'name': 'LP ⭐ 5 (253)',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '2540 €',
    'location': 'Moundou /\nBébalem',
    'date': "AUJOUR'DHUI",
  },
  {
    'image':
        'https://cdn.pixabay.com/photo/2020/02/20/06/24/sofa-4864034_1280.jpg',
    'name': 'L82 ⭐ 5 (41)',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '3330 €',
    'location': 'Sarh /\nDanamadji',
    'date': '2024-06-10',
  },
  {
    'image':
        'https://media.istockphoto.com/id/949087660/tr/foto%C4%9Fraf/%C3%A7e%C5%9Fmede-kompleks-daire-konut-%C3%BC%C3%A7-ayl%C4%B1k-d%C3%B6nem.jpg?s=1024x1024&w=is&k=20&c=IZ_ItMYQqPL8Neosuu9Rnh23bA6BFPyor8Cka_XppN8=',
    'name': 'Nelle',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '10250 €',
    'location': 'Abeché /\nBiltine',
    'date': '2024-06-10',
  },
  {
    'image':
        'https://media.istockphoto.com/id/949087660/tr/foto%C4%9Fraf/%C3%A7e%C5%9Fmede-kompleks-daire-konut-%C3%BC%C3%A7-ayl%C4%B1k-d%C3%B6nem.jpg?s=1024x1024&w=is&k=20&c=IZ_ItMYQqPL8Neosuu9Rnh23bA6BFPyor8Cka_XppN8=',
    'name': 'Nelle',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '599 €',
    'location': 'Mongo /\nBitkine',
    'date': '2024-06-10',
  },
  {
    'image':
        'https://media.istockphoto.com/id/949087660/tr/foto%C4%9Fraf/%C3%A7e%C5%9Fmede-kompleks-daire-konut-%C3%BC%C3%A7-ayl%C4%B1k-d%C3%B6nem.jpg?s=1024x1024&w=is&k=20&c=IZ_ItMYQqPL8Neosuu9Rnh23bA6BFPyor8Cka_XppN8=',
    'name': 'Nelle',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '799 €',
    'location': 'Am-Timan /\nHaraze Mangueigne',
    'date': '2024-06-10',
  },
];

final List<Map<String, dynamic>> productsList = [
  {
    'image': [
      'https://cdn.pixabay.com/photo/2016/11/20/09/06/laptop-1842297_1280.jpg',
      'https://media.istockphoto.com/id/636878304/tr/foto%C4%9Fraf/womans-hands-on-a-computer-keyboard.jpg?s=1024x1024&w=is&k=20&c=8T9e6lRWJMWpuIMWwEdYAkFx6YPvh14w2BGpnnRaiX8=',
      'https://cdn.pixabay.com/photo/2015/05/15/02/07/computer-767781_1280.jpg',
      'https://media.istockphoto.com/id/895053440/tr/foto%C4%9Fraf/eller-klavyede-yazmak-yak%C4%B1n-%C3%A7ekim.jpg?s=1024x1024&w=is&k=20&c=4Z1k6XScoNukla51s3AYDpCoGKVCN7l345JiYEbZsck=',
      'https://media.istockphoto.com/id/1327291540/tr/foto%C4%9Fraf/close-up-hands-of-unrecognizable-business-woman-working-typing-on-laptop-notebook-keyboard.jpg?s=1024x1024&w=is&k=20&c=-Qic87Gg5Y6letWsE0YkDF4kl-40A-r6g4G6fpqipPE=',
      'https://cdn.pixabay.com/photo/2016/11/20/09/06/laptop-1842297_1280.jpg',
      'https://cdn.pixabay.com/photo/2023/07/28/02/00/model-8154290_1280.png',
    ],
    'name': 'Adam_djiane',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '160 €',
    'location': "N'Djamena /\nN'Djamena-Centre",
    'date': 'HIER',
  },
  {
    'image': [
      'https://cdn.pixabay.com/photo/2015/05/15/02/07/computer-767781_1280.jpg',
      'https://cdn.pixabay.com/photo/2016/11/20/09/06/laptop-1842297_1280.jpg',
    ],
    'name': 'LP ⭐ 5 (253)',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '2540 €',
    'location': 'Moundou /\nBébalem',
    'date': "AUJOUR'DHUI",
  },
  {
    'image': [
      'https://cdn.pixabay.com/photo/2020/02/20/06/24/sofa-4864034_1280.jpg',
    ],
    'name': 'L82 ⭐ 5 (41)',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '3330 €',
    'location': 'Sarh /\nDanamadji',
    'date': '2024-06-10',
  },
  {
    'image': [
      'https://media.istockphoto.com/id/949087660/tr/foto%C4%9Fraf/%C3%A7e%C5%9Fmede-kompleks-daire-konut-%C3%BC%C3%A7-ayl%C4%B1k-d%C3%B6nem.jpg?s=1024x1024&w=is&k=20&c=IZ_ItMYQqPL8Neosuu9Rnh23bA6BFPyor8Cka_XppN8=',
    ],
    'name': 'Nelle',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '10250 €',
    'location': 'Abeché /\nBiltine',
    'date': '2024-06-10',
  },
  {
    'image': [
      'https://media.istockphoto.com/id/949087660/tr/foto%C4%9Fraf/%C3%A7e%C5%9Fmede-kompleks-daire-konut-%C3%BC%C3%A7-ayl%C4%B1k-d%C3%B6nem.jpg?s=1024x1024&w=is&k=20&c=IZ_ItMYQqPL8Neosuu9Rnh23bA6BFPyor8Cka_XppN8=',
    ],
    'name': 'Nelle',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '599 €',
    'location': 'Mongo /\nBitkine',
    'date': '2024-06-10',
  },
  {
    'image': [
      'https://media.istockphoto.com/id/949087660/tr/foto%C4%9Fraf/%C3%A7e%C5%9Fmede-kompleks-daire-konut-%C3%BC%C3%A7-ayl%C4%B1k-d%C3%B6nem.jpg?s=1024x1024&w=is&k=20&c=IZ_ItMYQqPL8Neosuu9Rnh23bA6BFPyor8Cka_XppN8=',
    ],
    'name': 'Nelle',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '799 €',
    'location': 'Am-Timan /\nHaraze Mangueigne',
    'date': "AUJOUR'DHUI",
  },
  {
    'image': [
      'https://cdn.pixabay.com/photo/2016/11/20/09/06/laptop-1842297_1280.jpg',
    ],
    'name': 'Adam_djiane',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '160 €',
    'location': "N'Djamena /\nN'Djamena-Centre",
    'date': 'HIER',
  },
  {
    'image': [
      'https://cdn.pixabay.com/photo/2015/05/15/02/07/computer-767781_1280.jpg',
    ],
    'name': 'LP ⭐ 5 (253)',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '2540 €',
    'location': 'Moundou /\nBébalem',
    'date': "AUJOUR'DHUI",
  },
  {
    'image': [
      'https://cdn.pixabay.com/photo/2020/02/20/06/24/sofa-4864034_1280.jpg',
    ],
    'name': 'L82 ⭐ 5 (41)',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '3330 €',
    'location': 'Sarh /\nDanamadji',
    'date': '2024-06-10',
  },
  {
    'image': [
      'https://media.istockphoto.com/id/949087660/tr/foto%C4%9Fraf/%C3%A7e%C5%9Fmede-kompleks-daire-konut-%C3%BC%C3%A7-ayl%C4%B1k-d%C3%B6nem.jpg?s=1024x1024&w=is&k=20&c=IZ_ItMYQqPL8Neosuu9Rnh23bA6BFPyor8Cka_XppN8=',
    ],
    'name': 'Nelle',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '10250 €',
    'location': 'Abeché /\nBiltine',
    'date': '2024-06-10',
  },
  {
    'image': [
      'https://media.istockphoto.com/id/949087660/tr/foto%C4%9Fraf/%C3%A7e%C5%9Fmede-kompleks-daire-konut-%C3%BC%C3%A7-ayl%C4%B1k-d%C3%B6nem.jpg?s=1024x1024&w=is&k=20&c=IZ_ItMYQqPL8Neosuu9Rnh23bA6BFPyor8Cka_XppN8=',
    ],
    'name': 'Nelle',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '599 €',
    'location': 'Mongo /\nBitkine',
    'date': '2024-06-10',
  },
  {
    'image': [
      'https://media.istockphoto.com/id/949087660/tr/foto%C4%9Fraf/%C3%A7e%C5%9Fmede-kompleks-daire-konut-%C3%BC%C3%A7-ayl%C4%B1k-d%C3%B6nem.jpg?s=1024x1024&w=is&k=20&c=IZ_ItMYQqPL8Neosuu9Rnh23bA6BFPyor8Cka_XppN8=',
    ],
    'name': 'Nelle',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '799 €',
    'location': 'Am-Timan /\nHaraze Mangueigne',
    'date': '2024-06-10',
  },
  {
    'image': [
      'https://cdn.pixabay.com/photo/2016/11/20/09/06/laptop-1842297_1280.jpg',
    ],
    'name': 'Adam_djiane',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '160 €',
    'location': "N'Djamena /\nN'Djamena-Centre",
    'date': 'HIER',
  },
  {
    'image': [
      'https://cdn.pixabay.com/photo/2015/05/15/02/07/computer-767781_1280.jpg',
    ],
    'name': 'LP ⭐ 5 (253)',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '2540 €',
    'location': 'Moundou /\nBébalem',
    'date': "AUJOUR'DHUI",
  },
  {
    'image': [
      'https://cdn.pixabay.com/photo/2020/02/20/06/24/sofa-4864034_1280.jpg',
    ],
    'name': 'L82 ⭐ 5 (41)',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '3330 €',
    'location': 'Sarh /\nDanamadji',
    'date': '2024-06-10',
  },
  {
    'image': [
      'https://media.istockphoto.com/id/949087660/tr/foto%C4%9Fraf/%C3%A7e%C5%9Fmede-kompleks-daire-konut-%C3%BC%C3%A7-ayl%C4%B1k-d%C3%B6nem.jpg?s=1024x1024&w=is&k=20&c=IZ_ItMYQqPL8Neosuu9Rnh23bA6BFPyor8Cka_XppN8=',
    ],
    'name': 'Nelle',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '10250 €',
    'location': 'Abeché /\nBiltine',
    'date': '2024-06-10',
  },
  {
    'image': [
      'https://media.istockphoto.com/id/949087660/tr/foto%C4%9Fraf/%C3%A7e%C5%9Fmede-kompleks-daire-konut-%C3%BC%C3%A7-ayl%C4%B1k-d%C3%B6nem.jpg?s=1024x1024&w=is&k=20&c=IZ_ItMYQqPL8Neosuu9Rnh23bA6BFPyor8Cka_XppN8=',
    ],
    'name': 'Nelle',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '599 €',
    'location': 'Mongo /\nBitkine',
    'date': '2024-06-10',
  },
  {
    'image': [
      'https://media.istockphoto.com/id/949087660/tr/foto%C4%9Fraf/%C3%A7e%C5%9Fmede-kompleks-daire-konut-%C3%BC%C3%A7-ayl%C4%B1k-d%C3%B6nem.jpg?s=1024x1024&w=is&k=20&c=IZ_ItMYQqPL8Neosuu9Rnh23bA6BFPyor8Cka_XppN8=',
    ],
    'name': 'Nelle',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '799 €',
    'location': 'Am-Timan /\nHaraze Mangueigne',
    'date': '2024-06-10',
  },
  {
    'image': [
      'https://cdn.pixabay.com/photo/2016/11/20/09/06/laptop-1842297_1280.jpg',
    ],
    'name': 'Adam_djiane',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '160 €',
    'location': "N'Djamena /\nN'Djamena-Centre",
    'date': 'HIER',
  },
  {
    'image': [
      'https://cdn.pixabay.com/photo/2015/05/15/02/07/computer-767781_1280.jpg',
    ],
    'name': 'LP ⭐ 5 (253)',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '2540 €',
    'location': 'Moundou /\nBébalem',
    'date': "AUJOUR'DHUI",
  },
  {
    'image': [
      'https://cdn.pixabay.com/photo/2020/02/20/06/24/sofa-4864034_1280.jpg',
    ],
    'name': 'L82 ⭐ 5 (41)',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '3330 €',
    'location': 'Sarh /\nDanamadji',
    'date': '2024-06-10',
  },
  {
    'image': [
      'https://media.istockphoto.com/id/949087660/tr/foto%C4%9Fraf/%C3%A7e%C5%9Fmede-kompleks-daire-konut-%C3%BC%C3%A7-ayl%C4%B1k-d%C3%B6nem.jpg?s=1024x1024&w=is&k=20&c=IZ_ItMYQqPL8Neosuu9Rnh23bA6BFPyor8Cka_XppN8=',
    ],
    'name': 'Nelle',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '10250 €',
    'location': 'Abeché /\nBiltine',
    'date': '2024-06-10',
  },
  {
    'image': [
      'https://media.istockphoto.com/id/949087660/tr/foto%C4%9Fraf/%C3%A7e%C5%9Fmede-kompleks-daire-konut-%C3%BC%C3%A7-ayl%C4%B1k-d%C3%B6nem.jpg?s=1024x1024&w=is&k=20&c=IZ_ItMYQqPL8Neosuu9Rnh23bA6BFPyor8Cka_XppN8=',
    ],
    'name': 'Nelle',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '599 €',
    'location': 'Mongo /\nBitkine',
    'date': '2024-06-10',
  },
  {
    'image': [
      'https://media.istockphoto.com/id/949087660/tr/foto%C4%9Fraf/%C3%A7e%C5%9Fmede-kompleks-daire-konut-%C3%BC%C3%A7-ayl%C4%B1k-d%C3%B6nem.jpg?s=1024x1024&w=is&k=20&c=IZ_ItMYQqPL8Neosuu9Rnh23bA6BFPyor8Cka_XppN8=',
    ],
    'name': 'Nelle',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '799 €',
    'location': 'Am-Timan /\nHaraze Mangueigne',
    'date': '2024-06-10',
  },
  {
    'image': [
      'https://media.istockphoto.com/id/949087660/tr/foto%C4%9Fraf/%C3%A7e%C5%9Fmede-kompleks-daire-konut-%C3%BC%C3%A7-ayl%C4%B1k-d%C3%B6nem.jpg?s=1024x1024&w=is&k=20&c=IZ_ItMYQqPL8Neosuu9Rnh23bA6BFPyor8Cka_XppN8=',
    ],
    'name': 'Nelle',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '599 €',
    'location': 'Mongo /\nBitkine',
    'date': '2024-06-10',
  },
  {
    'image': [
      'https://media.istockphoto.com/id/949087660/tr/foto%C4%9Fraf/%C3%A7e%C5%9Fmede-kompleks-daire-konut-%C3%BC%C3%A7-ayl%C4%B1k-d%C3%B6nem.jpg?s=1024x1024&w=is&k=20&c=IZ_ItMYQqPL8Neosuu9Rnh23bA6BFPyor8Cka_XppN8=',
    ],
    'name': 'Nelle',
    'description':
        'The iPhone 16 Pro and iPhone 16 Pro Max are high-end smartphones developed and marketed by Apple Inc. Alongside the iPhone 16 and iPhone 16 Plus, they form the eighteenth generation of the iPhone, succeeding the iPhone 15 Pro and iPhone 15 Pro Max, and were announced on September 9, 2024, and released on September 22, 2024.',
    'price': '799 €',
    'location': 'Am-Timan /\nHaraze Mangueigne',
    'date': '2024-06-10',
  },
];
