// Variables para almacenar las imágenes
PImage cartelNiveles, cartelSelecNiv, cartelPuntuaciones, cartelSelecPunt, cartelSalir, cartelSelecSalir;
PImage cartelVolver, cartelTitulo, fondoMenu, cartelExit, cartelExitNo, cartelExitSi, selecExitNo, selecExitSi;
PImage tablaPunt;

void cargarSetup() {
  // Cargar todas las imágenes
  // Carteles del menú
  cartelNiveles = loadImage("Assets/img/Menu/Cartel Niveles.png");
  cartelSelecNiv = loadImage("Assets/img/Menu/Cartel Selec Niveles.png");
  cartelPuntuaciones = loadImage("Assets/img/Menu/Cartel Puntuaciones.png");
  cartelSelecPunt = loadImage("Assets/img/Menu/Cartel Selec Puntuaciones.png");
  cartelSalir = loadImage("Assets/img/Menu/Cartel Salir.png");
  cartelSelecSalir = loadImage("Assets/img/Menu/Cartel Selec Salir.png");

  // Imagen del cartel Volver
  cartelVolver = loadImage("Assets/img/Menu/Cartel Volver.png");

  // Imagen del cartel Título
  cartelTitulo = loadImage("Assets/img/Menu/Cartel Titulo.png");

  // Fondo del menú
  fondoMenu = loadImage("Assets/img/Menu/Fondo Menu.png");

  // Carteles del mensaje ¿Estás seguro?
  cartelExit = loadImage("Assets/img/Menu/Cartel Exit.png");
  cartelExitNo = loadImage("Assets/img/Menu/Cartel Exit No.png");
  cartelExitSi = loadImage("Assets/img/Menu/Cartel Exit Si.png");
  selecExitNo = loadImage("Assets/img/Menu/Selec Exit No.png");
  selecExitSi = loadImage("Assets/img/Menu/Selec Exit Si.png");

  // Tabla de puntuaciones
  tablaPunt = loadImage("Assets/img/Puntuaciones/Tabla_Punt.png");

  // Inicializa las imágenes de los niveles
  PImage Nivel_1_i, Nivel_2_i, Nivel_2_i_bloqueado, Nivel_3_i, Nivel_3_i_bloqueado, Coming_Soon;
  Nivel_1_i = loadImage("Assets/img/Menu_Niveles/Nivel_1.jpg");
  Nivel_2_i = loadImage("Assets/img/Menu_Niveles/Nivel_2.jpg");
  Nivel_2_i_bloqueado = loadImage("Assets/img/Menu_Niveles/Nivel_2_Bloq.jpg");
  Nivel_3_i = loadImage("Assets/img/Menu_Niveles/Nivel_3.jpg");
  Nivel_3_i_bloqueado = loadImage("Assets/img/Menu_Niveles/Nivel_3_Bloq.jpg");
  Coming_Soon = loadImage("Assets/img/Menu_Niveles/Coming_Soon.jpg");

  // Ajusta el tamaño de las imágenes al tamaño de la pantalla
  Nivel_1_i.resize(width, height);
  Nivel_2_i.resize(width, height);
  Nivel_2_i_bloqueado.resize(width, height);
  Nivel_3_i.resize(width, height);
  Nivel_3_i_bloqueado.resize(width, height);
  Coming_Soon.resize(width, height);

  // Inicializa el objeto SubMenuLVL con 2 filas y 3 columnas además de las imagenes correspondientes a los niveles bloqueados y desbloqueados
  MenuNiveles = new Menu_LVL(2, 3, Nivel_1_i, Nivel_2_i, Nivel_2_i_bloqueado, Nivel_3_i, Nivel_3_i_bloqueado, Coming_Soon);

  // Comunicación con Arduino
  Serial myPort; // Declara el objeto Serial
  
  /*Serial.list()[x] es un método de la clase Serial que devuelve un arreglo Strings con el nombre de todos los puertos seriales*/
  String portName = Serial.list()[0]; // Inicializa en el puerto adecuado
  
  /*"new Serial" hace referencia al constructor de la clase Serial, se le pasa this para referenciar al sketch ectual de Processing*/
  myPort = new Serial(this, portName, 9600); // Configuración del puerto
    
  // Configurar el puerto serie para lecturas
    myPort.bufferUntil('\n');
    
  // Fondo de los niveles
    PImage fondo = loadImage("Assets/img/Nivel_1/Fondo.jpg");
    PImage fondo_2=loadImage("Assets/img/Nivel_2/Fondo.jpg");
    fondo.resize(width, height);//se redimenciona el fono de los niveles para adecuarlos a los cambios de pantalla.
    fondo_2.resize(width, height);
    
  //Inicializacion de los objetos de los niveles
  
  /*
  Los objetos Niveles inicializados con el construcrtor reciben los parametros en el orden respectivo:
  
    1) - int velocidad, es la cantidad de pixeles por segundos que de desplazan las imagenes de la esquina superior derecha.
    
    2) y 3) -float Al y float An, "hieght" y "width" respectivamente, recibe floats abraviados Al (alto) y An (ancho) para
    trabajar en el programa con los tamaños del alto y ancho del sketch para redimencionar imagenes y sacar proporciones.
    
    4) - PImage Fondo, recibe un objeto del tipo PImage con la imagen de fondo del nivel.
    
    5) - String Nivel, recibe el string referido a trabajar dentro del objeto con las imagenes de la carpeta de cada nivel
    
    6) - PApplet parent, PApplet es la clase base de todos los sketches, y el término parent se refiere a una instancia de
    esa clase que actúa como el "padre" de un objeto. Es decir, PApplet parent es una forma de referirse al sketch principal
    desde un objeto o clase auxiliar que necesite interactuar con el. En el programa es el constructor de la libería Minim
    quien requiere de este parametro.
    
    7) int nivel, la variable nivel hace referencia al valor de retorono al sketch que utilizamos para seguir dibujando constantemente
    la escena referida al nivel, puede ser ajustada a convenienncia, en nuestro caso, decidimos utilizar un valor que hace referencia
    al número del nivel + 1, es decir, nivel 1 será referenciado con el 2, nivel 2 con 3 ... Esto lo hicimos por como se dió la distribución
    de escenas siendo que el valor de 1 lo coupamos para dibujar la escena referida al menu de los niveles
    
    8) Serial myPort, recibe el objeto Serial del sketch pincipal, podría haber trabajado con la intancia parent para inicializar el puerto
    al hacer ya la referencia al puerto serial, pero preferí pasarle el puerto ya inicializado por una cuestión de comodidad en el orden.
    
  */
    Nivel_1 = new Niveles(6, height, width, fondo, "Nivel_1/", this, 2, myPort);
    Nivel_2 = new Niveles(6, height, width, fondo_2,"Nivel_2/",this, 3, myPort);
}

// Función para cambiar la posición de las coordenadas
int cambiarPosicion(int valor, int tamañoOriginal, int tamañoNuevo) {
  return (valor * tamañoNuevo) / tamañoOriginal;
}

// Función para actualizar las posiciones de las imágenes según la resolución
void actualizarPosiciones() {
  for (int i = 0; i < numImagenes; i++) {
    int nuevoX = cambiarPosicion(posiciones[i][0], anchoOriginal, anchoNuevo);
    int nuevoY = cambiarPosicion(posiciones[i][1], altoOriginal, altoNuevo);
    posiciones[i][0] = nuevoX;
    posiciones[i][1] = nuevoY;
    println("Índice " + i + ": Nueva X = " + nuevoX + ", Nueva Y = " + nuevoY);
  }
}
