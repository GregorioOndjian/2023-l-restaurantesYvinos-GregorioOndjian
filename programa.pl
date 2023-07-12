% Aquí va el código.
restaurante(panchoMayo, 2, barracas).
restaurante(finoli, 3, villaCrespo).
restaurante(superFinoli, 5, villaCrespo).

restauranteActivo(Restaurante):-
    menu(Restaurante,_).

restauranteActivo(superFinoli).

menu(panchoMayo, carta(1000, pancho)).
menu(panchoMayo, carta(200, hamburguesa)).
menu(finoli, carta(2000, hamburguesa)).
menu(finoli, pasos(15, 15000, [chateauMessi, francescoliSangiovese, susanaBalboaMalbec], 6)).
menu(finoli, pasos(15, 1000, [chateauMessi, francescoliSangiovese, susanaBalboaMalbec], 6)).
menu(noTanFinoli, pasos(2, 3000, [guinoPin, juanaDama],3)).

vino( chateauMessi, francia, 5000).
vino( francescoliSangiovese, italia, 1000).
vino( susanaBalboaMalbec, argentina, 1200).
vino( christineLagardeCabernet, argentina, 5200).
vino( guinoPin, argentina, 500).
vino( juanaDama, argentina, 1000).

restaurantesPorLaZona(Restaurante,Estrellas,Zona):-
    restaurante(Restaurante,CantEstrellas,Zona),
    CantEstrellas > Estrellas.

restauranteSinEstrellas(Restaurante):-
    restauranteActivo(Restaurante),
    not(restaurante(Restaurante,_,_)).

malOrganizado(Restaurante):-
    menu(Restaurante,Menu),
    malaOrganizacionDeMenu(Restaurante,Menu).

malaOrganizacionDeMenu(Restaurante,carta(Precio,Plato)):-
    menu(Restaurante,carta(Precio,Plato)),
    menu(Restaurante,carta(OtroPrecio,Plato)),
    OtroPrecio \= Precio.

malaOrganizacionDeMenu(_, pasos(CantidadDePasos,_,ListaVinos,_)):-
    length(ListaVinos,NumeroVinos),
    CantidadDePasos > NumeroVinos.

%4
/*
copiaBarata(Copia,Restaurante,_):-
    tieneLosMismosPlatos(Copia,Restaurante,PlatoCopiado),
    platosALaCarta(Restaurante,PlatoCopiado,PrecioOriginal),
    forall(tieneLosMismosPlatos(Copia,Restaurante,PlatoCopiado),platosALaCarta(Copia,PlatoCopiado,PrecioCopia)).
*/

platosALaCarta(Restaurante,Plato,Precio):-
    menu(Restaurante,carta(Precio,Plato)).

tieneLosMismosPlatos(Copia,Restaurante,PlatoCopiado):-
    platosALaCarta(Restaurante,PlatoCopiado,_),
    forall(platosALaCarta(Restaurante,PlatoCopiado,_),platosALaCarta(Copia,PlatoCopiado,_)).



%5
precioPromedio(Restaurante,Promedio):-
    restauranteActivo(Restaurante),
    findall(Precio,calculoPrecio(Restaurante,_,Precio),ListaPrecios),
    sum_list(ListaPrecios, SumaDePrecios),
    length(ListaPrecios,Longitud),
    Promedio is SumaDePrecios / Longitud.

    
calculoPrecio(Restaurante,carta(Precio,_),Precio):-
    menu(Restaurante,carta(Precio,_)).

calculoPrecio(Restaurante,pasos(_, PrecioTotal, ListaVinos,CantComenzales),Precio):-
    menu(Restaurante,pasos(_, PrecioTotal, ListaVinos,CantComenzales)),
    recorrerListaVinos(ListaVinos, PrecioVinosTotal),
    Precio is ((PrecioTotal + PrecioVinosTotal)/CantComenzales).

recorrerListaVinos([],0).

recorrerListaVinos([X | Xs], PrecioFinal):- 
    precioVino(X, PrecioVino),
    recorrerListaVinos(Xs, Precio),
    PrecioFinal is Precio + PrecioVino.

precioVino(Vino,Precio):-
    vino(Vino,Nacionalidad,PrecioOriginal),
    Nacionalidad \= argentina,
    Precio is PrecioOriginal *1.35.

precioVino(Vino,Precio):- 
    vino(Vino,Nacionalidad,PrecioOriginal),
    Nacionalidad == argentina,
    Precio is  PrecioOriginal.
