void cargarImagenes() {
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
}
void cargarGifs(){
  myGif = new Gif(this, "Assets/Gif/prueba.gif");
  myGif.loop(); // Hace que el GIF se reproduzca en bucle
  FondoNiv_1 = new Gif(this, "Assets/Gif/FondoNiv_1.gif");
  FondoNiv_1.loop();
  FondoMenuNiv = new Gif(this, "Assets/Gif/Fondo_Menu_Niveles.gif");
  FondoMenuNiv.loop();
  FondoPunt = new Gif(this, "Assets/Gif/Fondo_Puntuaciones.gif");
  FondoPunt.loop();
}
