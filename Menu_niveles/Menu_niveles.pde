SubMenuLVL MenuNiveles; // Instancia del objeto SubMenuLVL
Niveles Nivel_1; // Instancia del objeto Niveles
int nivel=0;
char teclaPresionada;
PImage fondo;

void setup() {
  // Configuración inicial
  //fullScreen();
  size(1280, 720);
  frameRate(30);
  
  noCursor();
  // Inicializa el objeto SubMenuLVL con 2 filas y 3 columnas
  MenuNiveles = new SubMenuLVL(2, 3);
  
  //Fondo del nivel 1
  fondo=loadImage("Assets/img/Nivel_1/Fondo.jpg");
  fondo.resize(width,height);
}

void draw() {
  // Color de fondo
  color bg = color(227, 247, 255);
  background(bg);
  if(nivel==0){
    // Color de los rectángulos
    color rectangulosC = color(150, 200, 255);
    color rectSeleccionado = color(255, 180, 120);
    
    // Dibuja la cuadrícula usando el método de la clase
    MenuNiveles.dibujarCuadricula(0.05, 0.2, rectangulosC, rectSeleccionado);
    
    Nivel_1= new Niveles(2 ,height,width,fondo,"Nivel_1/",this,1);
  }
  
  if(nivel==1){
    
    nivel = Nivel_1.interfazNivel();
  }
  
}

// Manejo de teclas
void keyPressed() {
  teclaPresionada = key;
  switch(teclaPresionada){
    /*Paso una letra respecto a la tecla presionada*/
    case 'a':
      if(nivel==0)
        MenuNiveles.moverSeleccion(teclaPresionada);
      
      if(nivel!=0){
        if(nivel==1){
          Nivel_1.tecla_v='a';
        }
      }
      
      break;
      
    case 's':
      if(nivel==0)
        MenuNiveles.moverSeleccion(teclaPresionada);
        
      if(nivel!=0){
        if(nivel==1){
          Nivel_1.tecla_v='s';
        }
      }
      break;
    case 'd':
      if(nivel==0)
        MenuNiveles.moverSeleccion(teclaPresionada);
      
      if(nivel!=0){
        if(nivel==1){
          Nivel_1.tecla_v='d';
        }
      }
        
      break;
    case 'w':
      if(nivel==0)
        MenuNiveles.moverSeleccion(teclaPresionada);
      
      if(nivel!=0){
        if(nivel==1){
          Nivel_1.tecla_v='w';
        }
      }
      break;
    case 'l':
     if(nivel==0){
      nivel=MenuNiveles.moverSeleccion(teclaPresionada);
     }
     if(nivel!=0){
      if(nivel==1){
        Nivel_1.tecla_v='l';
      }
    }
      break;
    case 'k':
    if(nivel!=0){
      if(nivel==1){
        Nivel_1.tecla_v='k';
        Nivel_1.interfazNivel();
      }

    }
    if(nivel==0)
      nivel=MenuNiveles.moverSeleccion(teclaPresionada);

      break;
  }
  
}
