// Imagenes
  PImage cartelNiveles, cartelSelecNiv, cartelPuntuaciones, cartelSelecPunt, cartelSalir, cartelSelecSalir;
  PImage cartelVolver, cartelTitulo, fondoMenu, cartelExit, cartelExitNo, cartelExitSi, selecExitNo, selecExitSi;
  PImage tablaPunt;

void cargarSetup(){
  // Cargar todas las imágenes
  //Carteles menu
    cartelNiveles = loadImage("Assets/img/Menu/Cartel Niveles.png");
    cartelSelecNiv = loadImage("Assets/img/Menu/Cartel Selec Niveles.png");
    cartelPuntuaciones = loadImage("Assets/img/Menu/Cartel Puntuaciones.png");
    cartelSelecPunt = loadImage("Assets/img/Menu/Cartel Selec Puntuaciones.png");
    cartelSalir = loadImage("Assets/img/Menu/Cartel Salir.png");
    cartelSelecSalir = loadImage("Assets/img/Menu/Cartel Selec Salir.png");
    
  //Volver
    cartelVolver = loadImage("Assets/img/Menu/Cartel Volver.png");
    
  //Cartel Titulo
    cartelTitulo = loadImage("Assets/img/Menu/Cartel Titulo.png");
    
  //Fondo
    fondoMenu = loadImage("Assets/img/Menu/Fondo Menu.png");
    
  //Cartel ¿Estas seguro?
    cartelExit = loadImage("Assets/img/Menu/Cartel Exit.png");
    cartelExitNo = loadImage("Assets/img/Menu/Cartel Exit No.png");
    cartelExitSi = loadImage("Assets/img/Menu/Cartel Exit Si.png");
    selecExitNo = loadImage("Assets/img/Menu/Selec Exit No.png");
    selecExitSi = loadImage("Assets/img/Menu/Selec Exit Si.png");
  
  //Puntuaciones
    tablaPunt = loadImage("Assets/img/Puntuaciones/Tabla_Punt.png");
    
  //Inicializa las imagenes de los niveles
    PImage Nivel_1_i,Nivel_2_i, Nivel_2_i_bloqueado , Nivel_3_i , Nivel_3_i_bloqueado, Coming_Soon;
    Nivel_1_i=loadImage("Assets/img/Menu_Niveles/Nivel_1.jpg");
    
    Nivel_2_i=loadImage("Assets/img/Menu_Niveles/Nivel_2.jpg");
    Nivel_2_i_bloqueado=loadImage("Assets/img/Menu_Niveles/Nivel_2_Bloq.jpg");
    
    Nivel_3_i=loadImage("Assets/img/Menu_Niveles/Nivel_3.jpg");
    Nivel_3_i_bloqueado=loadImage("Assets/img/Menu_Niveles/Nivel_3_Bloq.jpg");
    
    Coming_Soon=loadImage("Assets/img/Menu_Niveles/Coming_Soon.jpg");
    
    Nivel_1_i.resize(width, height);
    Nivel_2_i.resize(width, height);
    Nivel_2_i_bloqueado.resize(width, height);
    Nivel_3_i.resize(width, height);
    Nivel_3_i_bloqueado.resize(width, height);
    Coming_Soon.resize(width, height);
    
    
  // Inicializa el objeto SubMenuLVL con 2 filas y 3 columnas
    MenuNiveles = new Menu_LVL(2, 3,Nivel_1_i,Nivel_2_i, Nivel_2_i_bloqueado,Nivel_3_i,Nivel_3_i_bloqueado,Coming_Soon);
    
  //Comunicación con arduino
    Serial myPort;// Declara el objeto Serial
    String portName = Serial.list()[0];//Inicializar en el puerto adecuado
    myPort = new Serial(this, portName, 9600);//Configuración del puerto
    
  // Configurar el puerto serie para lecturas
    myPort.bufferUntil('\n');
    
  // Fondo de los niveles
    PImage fondo = loadImage("Assets/img/Nivel_1/Fondo.jpg");
    PImage fondo_2=loadImage("Assets/img/Nivel_2/Fondo.jpg");
    fondo.resize(width, height);
    fondo_2.resize(width, height);
    
  //Inicializacion de los objetos de los niveles
    Nivel_1 = new Niveles(8, height, width, fondo, "Nivel_1/", this, 2, myPort);
    Nivel_2 = new Niveles(8, height, width, fondo_2,"Nivel_2/",this, 3, myPort);
}
