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
menu(finoli, carta(1500, pancho)).
menu(finoli, pasos(15, 15000, [chateauMessi, francescoliSangiovese, susanaBalboaMalbec], 6)).
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


copiaBarata(Copia,Restaurante):-
    tieneLosMismosPlatos(Copia,Restaurante,PlatoCopiado),
    platosALaCarta(Restaurante,PlatoCopiado,PrecioOriginal),
    platosALaCarta(Copia,PlatoCopiado,PrecioRestauranteCopia),
    PrecioRestauranteCopia < PrecioOriginal.


platosALaCarta(Restaurante,Plato,Precio):-
    menu(Restaurante,carta(Precio,Plato)).

tieneLosMismosPlatos(Copia,Restaurante,PlatoCopiado):-
    platosALaCarta(Restaurante,PlatoCopiado,_),
    forall(platosALaCarta(Restaurante,PlatoCopiado,_),platosALaCarta(Copia,PlatoCopiado,_)).



