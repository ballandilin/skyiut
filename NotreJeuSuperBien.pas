program jeuAvance2;

{$codepage UTF8}

uses 

		Sysutils, windows, MMSystem,
		GestionEcran in 'GestionEcran.pas',
		// unitPerso in 'unitPerso.pas',
		unitAnim in 'unitAnim.pas',
		unitInterface in 'unitInterface.pas',
		unitacceuilanim in 'unitacceuilanim.pas',
		unitmap in 'unitmap.pas',
		Classes, math, keyboard, unitHistoire,
		unitcreationperso, unitmenuinit,
		unitInterfaceMenuHistoire, unitInventaire, unitCombat, Quetes;



var
	coord, coord2 : coordonnees;
	joueur : perso;	// variable pour stocker le perso
	iWantToPlay: Boolean; // variable d'arret du jeu

begin

	coord.x := 200 div 2;
	coord.y := 60 div 2;

	iWantToPlay := false;


	//100, 30 pour mon pc
	changerTailleConsole(200, 60);


	sndPlaySound('sound//main.wav', snd_Async);		//permet de jouer une music en fond, snd_NoDefault bloque le deroulement du programme jusqu'a la fin du son

	afficheDUTHESDA(); 
	


	afficheImageAscii('sky_iut');
	// affichePresentationSkyiut(); 
	sleep(2000);

	menu(joueur); // onaffiche le menu des choix de debut de jeu

	iWantToPlay := joueur.iWantToPlay;

	effacerEcran();


	if iWantToPlay then
	begin
		if joueur.ethnie = '' then
		begin
			choixPerso(joueur);
            effacerEcran();
			menuHistoire(joueur);
			introduction(joueur);
		end;

		while joueur.iWantToPlay do
		begin
			case joueur.lieu of // on renvoie le joueur a son derniere emplacement dans le cas d'un chargement de partie
		        'fortDragon' : fortDragon(joueur);
		        'quartierDesNuees' : quartierDesNuees(joueur);
		        'quartierDuVent' : quartierDuVent(joueur);
		        'quartierDesPlaines' : quartierDesPlaines(joueur);
		        'MainGates' : MainGates(joueur);
		        'campagne' : campagne(joueur);
    		end;
		end;
	end;


	ecrireEnPosition(coord, 'C''est bien dommage, mais au revoir');


	readln();

	
end.

