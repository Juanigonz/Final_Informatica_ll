void cargarImagenes() {
  //Carteles menu
    cartelNiveles = loadImage("Assets/img/Cartel Niveles.png");
    cartelSelecNiv = loadImage("Assets/img/Cartel Selec Niveles.png");
    cartelPuntuaciones = loadImage("Assets/img/Cartel Puntuaciones.png");
    cartelSelecPunt = loadImage("Assets/img/Cartel Selec Puntuaciones.png");
    cartelSalir = loadImage("Assets/img/Cartel Salir.png");
    cartelSelecSalir = loadImage("Assets/img/Cartel Selec Salir.png");
    
  //Volver
    cartelVolver = loadImage("Assets/img/Cartel Volver.png");
    
  //Cartel Titulo
    cartelTitulo = loadImage("Assets/img/Cartel Titulo.png");
    
  //Fondo
    fondoMenu = loadImage("Assets/img/Fondo Menu.png");
    
  //Cartel ¿Estas seguro?
    cartelExit = loadImage("Assets/img/Cartel Exit.png");
    cartelExitNo = loadImage("Assets/img/Cartel Exit No.png");
    cartelExitSi = loadImage("Assets/img/Cartel Exit Si.png");
    selecExitNo = loadImage("Assets/img/Selec Exit No.png");
    selecExitSi = loadImage("Assets/img/Selec Exit Si.png");
}
void cargarGifs(){
  myGif = new Gif(this, "Assets/Gif/prueba.gif");
  myGif.loop(); // Hace que el GIF se reproduzca en bucle
}
