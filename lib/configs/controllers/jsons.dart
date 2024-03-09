  List<Map<String, dynamic>> specialtyData = [
            {
              'Specialty': 'Cardiologista',
              'imageAsset': 'assets/imgs/Cardiologista.png',
              'content': 'O cardiologista é um médico especializado em cuidar do sistema cardiovascular, tratando condições como doenças cardíacas, hipertensão e insuficiência cardíaca.',
              'search' : 'c'
            },
            {
              'Specialty': 'Dermatologista',
              'imageAsset': 'assets/imgs/Dermatologista.png',
              'content': 'O dermatologista é um especialista em doenças da pele, cabelo e unhas, podendo tratar condições como acne, eczema, psoríase e câncer de pele.',
              'search' : 'D'
            },
            {
              'Specialty': 'Ortopedista',
              'imageAsset': 'assets/imgs/Ortopedista.png',
              'content': 'O ortopedista é um médico que se dedica ao tratamento de lesões e doenças relacionadas aos ossos, articulações, músculos, ligamentos e tendões.',
              'search' : 'o'
            },
            {
              'Specialty': 'Oftalmologista',
              'imageAsset': 'assets/imgs/Oftamologista.png',
              'content': 'O oftalmologista é responsável pelo diagnóstico e tratamento de condições oculares, como miopia, astigmatismo, catarata e glaucoma.',
              'search' : 'o'
            },
            {
              'Specialty': 'Ginecologista',
              'imageAsset': 'assets/imgs/Ginecologista.png',
              'content': 'O ginecologista é um médico especializado em saúde da mulher, abordando questões relacionadas ao sistema reprodutivo, contracepção e cuidados ginecológicos.',
              'search' : 'g'
            },
            {
              'Specialty': 'Dentista',
              'imageAsset': 'assets/imgs/Dentista.png',
              'content': 'O dentista é um médico especializado em saúde da mulher, abordando questões relacionadas ao sistema reprodutivo, contracepção e cuidados ginecológicos.',
              'search' : 'd'
            },
      ];
  List<Map<String, dynamic>> specialistData = [
      {
        'title': 'Dr. João Silva',
        'imageAsset': 'assets/imgs/agendar.png',
        'content': 'Dr. João Silva é um médico cardiologista com vasta experiência em cuidados cardíacos. Ele se especializou no tratamento de doenças cardíacas, hipertensão e insuficiência cardíaca.',
        'Id' : 'asde5tshdy'
      },
      {
        'title': 'Dra. Maria Souza',
        'imageAsset': 'assets/imgs/agendar.png',
        'content': 'Dra. Maria Souza é uma dermatologista renomada, especializada no tratamento de doenças da pele, cabelo e unhas. Sua experiência inclui o tratamento de acne, eczema, psoríase e câncer de pele.',
        'Id' : 'asksakitsh'
      },
      {
        'title': 'Dr. Roberto Santos',
        'imageAsset': 'assets/imgs/agendar.png',
        'content': 'Dr. Roberto Santos é um ortopedista altamente qualificado, dedicado ao tratamento de lesões e doenças relacionadas aos ossos, articulações, músculos, ligamentos e tendões.',
        'Id' : '54iaakitsh'
      },
      {
        'title': 'Dra. Carla Lima',
        'imageAsset': 'assets/imgs/agendar.png',
        'content': 'Dra. Carla Lima é uma oftalmologista experiente, especializada no diagnóstico e tratamento de condições oculares, incluindo miopia, astigmatismo, catarata e glaucoma.',
        'Id' : 'asks548ash'
      },
      {
        'title': 'Dr. Marcos Oliveira',
        'imageAsset': 'assets/imgs/agendar.png',
        'content': 'Dr. Marcos Oliveira é um ginecologista dedicado ao cuidado da saúde da mulher. Ele aborda questões relacionadas ao sistema reprodutivo, contracepção e cuidados ginecológicos.',
        'Id' : 'aksy76s5d2'
      },
  ];

   List<Map<String, dynamic>> availableDates = [
    {
      'Date' : DateTime.utc(2024, 3, 14),
    },
    {
      'Date' : DateTime.utc(2024, 3, 15),
    },
    {
      'Date' : DateTime.utc(2024, 3, 26),
    }
  ];

  List<Map<String, dynamic>> availableHours = [
    {
      'Hour' : DateTime.utc(2024, 3, 14, 9, 0),
    },
    {
      'Hour' : DateTime.utc(2024, 3, 14, 15, 0),
    },
    {
      'Hour' : DateTime.utc(2024, 3, 14, 18, 0),
    }
  ];

  List<Map<String,dynamic>> userInfo = [
    {
      'E-mail': 'millerallan17@gmail.com',
      'Name': 'Miller Allan',
      'CPF': '12678032400',
      'CEP': '50100000',
      'Phone': '8199868565',
      'Street': 'Rua',
      'Number': '123',
      'Locale': 'Bairro',
      'City': 'Cidade',
      'State': 'SP',
      'Birthdate': DateTime.now(),
      'Type': 'user',
      'Data': true
    },
  ];

 

  Map<String,dynamic> a = {
    'Specialist' : specialistData,
    'Specialty' : specialtyData,
    'Dates': availableDates,
    'Hours': availableHours,
    'User_info':  userInfo,
    'All_specialist': allSpecialist,
    'Consultas': consultas
  };


List<Map<String, dynamic>> allSpecialist = [
  {
    'Name': 'Dr. João Silva Alencar Soares',
    'Specialty': 'Cardiologista',
    'CRM' : '359558-PE',
    'Phone': '819986258785',
    'E-mail':'joao_silva@gmail.com',
    'Search' : 'J'
  },
  {
    'Name': 'Dra. Maria Oliveira Santos',
    'Specialty': 'Dermatologista',
    'CRM' : '452112-SP',
    'Phone': '119827456321',
    'E-mail':'maria_oliveira@gmail.com',
    'Search' : 'M'
  },
  {
    'Name': 'Dr. Carlos Roberto Mendes',
    'Specialty': 'Ortopedista',
    'CRM' : '275889-RJ',
    'Phone': '219923214587',
    'E-mail':'carlos_mendes@gmail.com',
    'Search' : 'C'
  },
  {
    'Name': 'Dra. Juliana Costa Lima',
    'Specialty': 'Ginecologista',
    'CRM' : '701234-MG',
    'Phone': '31333234455',
    'E-mail':'juliana_costa@gmail.com',
    'Search' : 'J'
  },
  {
    'Name': 'Dr. André Luiz Pereira',
    'Specialty': 'Otorrinolaringologista',
    'CRM' : '180987-BA',
    'Phone': '71992887766',
    'E-mail':'andre_pereira@gmail.com',
    'Search' : 'A'
  },
  {
    'Name': 'Dra. Fernanda Oliveira Costa',
    'Specialty': 'Endocrinologista',
    'CRM' : '509876-SP',
    'Phone': '119726543210',
    'E-mail':'fernanda_costa@gmail.com',
    'Search' : 'F'
  },
];


List<Map<String, dynamic>> consultas = [
  {
    'Specialist': 'Dr. João Silva',
    'Date': DateTime.utc(2024, 3, 14, 9, 0),
    'Specialty': 'Cardiologista',
    'Query_id': 'asde5tshdy',
    'UserName': 'Allan Miller Silva Lima',
    'Usercpf': '12678032400',
    'Status': 'Concluída',
  },
  {
    'Specialist': 'Dra. Maria Oliveira',
    'Date': DateTime.utc(2024, 3, 15, 10, 30),
    'Specialty': 'Dermatologista',
    'Query_id': 'qwe78ghytr',
    'UserName': 'Carla Santos',
    'Usercpf': '23456789012',
    'Status': 'Concluída',
  },
  {
    'Specialist': 'Dr. Ricardo Santos',
    'Date': DateTime.utc(2024, 3, 16, 11, 15),
    'Specialty': 'Ortopedista',
    'Query_id': 'zxcvbnm123',
    'UserName': 'Pedro Oliveira',
    'Usercpf': '34567890123',
    'Status': 'Aberta',
  },
  {
    'Specialist': 'Dra. Ana Souza',
    'Date': DateTime.utc(2024, 3, 17, 14, 45),
    'Specialty': 'Ginecologista',
    'Query_id': 'poiuytrewq',
    'UserName': 'Fernanda Lima',
    'Usercpf': '45678901234',
    'Status': 'Concluída',
  },
  {
    'Specialist': 'Dr. Marcos Pereira',
    'Date': DateTime.utc(2024, 3, 18, 16, 0),
    'Specialty': 'Pediatria',
    'Query_id': 'lkjhgfdsa',
    'UserName': 'Lucas Oliveira',
    'Usercpf': '56789012345',
    'Status': 'Aberta',
  },
];

