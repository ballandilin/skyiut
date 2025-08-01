unit unitInventaire;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, unitcreationperso, gestionEcran;
  
type
	 typeEquip = (arme, armure);

  procedure gestionInventaireAjout(var joueur : perso; item : item);

  procedure gestionInventaireMagasinVente(var joueur : perso;choix : Integer);

  procedure gestionInventaire(var joueur : perso; choix : Integer);

  procedure affichageInventaire(joueur : perso; var nbItem : Integer);

  procedure affichePrix(joueur : perso);
  procedure affichePrix(equip : array of item; var listPrix : array of Integer);

  procedure marchandage(var listPrix : array of Integer; joueur : perso; t : typeequip);

implementation

	procedure gestionInventaireAjout(var joueur : perso; item : item);
	var
		isFull: Boolean;
		i : Integer;
        itemExemple: item = ('', '', '', '');
	begin

		i := 1;
		isFull := true;

			while (isFull) and (i < 24) do
			begin
			 	if ('') = joueur.inventaire[i, 1] then
			 	begin
			 	 	isFull := false;
			 	end;
			 	i+=1;
			end;

			if isFull = false then
				joueur.inventaire[i-1] := item;

	end;

	procedure gestionInventaireMagasinVente(var joueur : perso; choix : Integer);
	var
		itemTemp : item = ('', '', '', '');
		itemSupp: item = ('', '', '', '');
		choixPrix : array[1..3] of Integer; 
		i : Integer;
		prix : array[1..2, 1..3, 1..4] of Integer = (
		                                           (
			                                            (5, 5, 6, 10),
			                                            (12, 12, 13, 17),
			                                            (200, 200, 230, 250)
		                                            ),
		                                            (
			                                             (20, 30, 15, 20),
			                                             (22, 55, 20, 25),
			                                             (150, 450, 120, 130)
		                                             )

                                    );// prix arme et ratio armure
	begin

		i := 1;

		choixPrix[1] := strToInt(joueur.inventaire[choix, 1]); // on recupere le type de l'item a vendre
 		choixPrix[2] := strToInt(joueur.inventaire[choix, 2]);
		choixPrix[3] := strToInt(joueur.inventaire[choix, 3]);


		joueur.monnaie += prix[choixPrix[1], choixPrix[2], choixPrix[3]];// on rajoute de la monnaie a la monnaie du perso, suivant le tableau de prix

		joueur.inventaire[choix] := itemSupp; // on supp l'item en question de l'inventaire du perso

		while (joueur.inventaire[choix + 1, 1] <> '') and (choix < 25) do // tant que l'item a la position choix + 1 n'est pas vide on continue 
		begin 
			joueur.inventaire[choix] := joueur.inventaire[choix + 1]; // l'item a la position de choix vaut l'item a la position de choix + 1
			joueur.inventaire[choix + 1] := itemSupp; // on supp l'item a la position choix + 1
			choix += 1; // on incremente choix
		end;
		
		
	end;

	procedure gestionInventaire(var joueur : perso; choix : Integer);
        var
           choixTab : array[1..3] of Integer;
           intChoix : Integer;
	begin

		choixTab[1] := strToInt(joueur.inventaire[choix, 1]);
		choixTab[2] := strToInt(joueur.inventaire[choix, 2]);
		choixTab[3] := strToInt(joueur.inventaire[choix, 3]);

		intChoix := strToInt(joueur.inventaire[choix, 1]);


		if intChoix = 1 then
		begin
		 	joueur.equipement.armeEquipe := DEGAT_RATIO[choixTab[1], choixTab[2], choixTab[3]];
		end
		else if intChoix = 2 then
		begin
			case joueur.inventaire[choix, 3] of
				'1' : joueur.equipement.armureTeteEquipe := DEGAT_RATIO[choixTab[1], choixTab[2], choixTab[3]];
			    '2' : joueur.equipement.armurePlastronEquipe := DEGAT_RATIO[choixTab[1], choixTab[2], choixTab[3]];
				'3' : joueur.equipement.armureGantEquipe := DEGAT_RATIO[choixTab[1], choixTab[2], choixTab[3]];
				'4' : joueur.equipement.armureBotteEquipe := DEGAT_RATIO[choixTab[1], choixTab[2], choixTab[3]];
			end;
		end;
	end;

	procedure affichageInventaire(joueur : perso; var nbItem : Integer);
	var
	  coordArme : coordonnees;
	  i, choix: Integer;

	 begin

	    choix := 0;

	    coordArme.x := 50;
	    coordArme.y := 6;


	    // effacerEcran();

	    coordArme.y -= 2;
	    ecrireEnPosition(coordArme, 'inventaire');

	    coordArme.y += 2;

	    // on affiche tout se qu'il y a dans l'inventaire
	    // for i := 1 to 24 do
	    // begin
	    //      ecrireEnPosition(coordArme, intToStr(i) +'. '+ joueur.inventaire[i, 4]);

	    //      coordArme.y += 1;
	    // end;

	    i := 1;

	    while (joueur.inventaire[i, 1] <> '') and (i < 24) do
	    begin
	      ecrireEnPosition(coordArme, intToStr(i) +'. '+ joueur.inventaire[i, 4]);

	      coordArme.y += 1;
	      i += 1;
	      nbItem += 1;
	    end;

	    ecrireEnPosition(coordArme, '26. quittez');
    	coordArme.y += 2;
    	
	end;

	procedure affichePrix(joueur : perso);
	var
		coordPrix : coordonnees;
		choixPrix : array[1..3] of Integer; 
		i : Integer;
		prix : array[1..2, 1..3, 1..4] of Integer = (
		                                           (
			                                            (5, 5, 6, 10),
			                                            (12, 12, 13, 17),
			                                            (200, 200, 230, 250)
		                                            ),
		                                            (
			                                             (20, 30, 15, 20),
			                                             (22, 55, 20, 25),
			                                             (150, 450, 120, 130)
		                                             )

                                    );// prix arme et ratio armure
	begin
		coordPrix.x := 80;
		coordPrix.y := 6;

		coordPrix.y -= 2;
		ecrireEnPosition(coordPrix, 'Prix :');
		coordPrix.y += 2;

		i := 1;

	    while (joueur.inventaire[i, 1] <> '') and (i < 24) do
	    begin
	    	choixPrix[1] := strToInt(joueur.inventaire[i, 1]); // on recupere le type de l'item a vendre
 			choixPrix[2] := strToInt(joueur.inventaire[i, 2]);
			choixPrix[3] := strToInt(joueur.inventaire[i, 3]);
	      	ecrireEnPosition(coordPrix, intToStr(prix[choixPrix[1], choixPrix[2], choixPrix[3]]) + 'p');

	      	coordPrix.y += 1;
	      	i += 1;
	    end;

	end;

	procedure affichePrix(equip : array of item; var listPrix : array of Integer);
	var
		coordPrix : coordonnees;
		choixPrix : array[1..3] of Integer; 
		i : Integer;
		prix : array[1..2, 1..3, 1..4] of Integer = (
		                                           (
			                                            (10, 10, 15, 12),
			                                            (20, 20, 25, 23),
			                                            (500, 556, 666, 550)
		                                            ),
		                                            (
			                                             (20, 30, 10, 34),
			                                            (40, 50, 40, 23),
			                                            (500, 556, 666, 550)
		                                             )

                                    );// prix arme et armure
	begin
		coordPrix.x := 80;
		coordPrix.y := 7;

		coordPrix.y -= 2;
		ecrireEnPosition(coordPrix, 'Prix :');
		coordPrix.y += 2;

		i := 1;

	    while (i < 13) do
	    begin
	      	ecrireEnPosition(coordPrix, intToStr(listPrix[i-1]) + 'p');

	      	if ((i mod 4) = 0) then
	      		coordPrix.y += 1;

	      	coordPrix.y += 1;
	      	i += 1;
	    end;

	end;

	procedure marchandage(var listPrix : array of Integer; joueur : perso; t : typeequip);
	type
    ratioprixArmure=array[0..20] of real;
    const
      listMarchandage: ratioprixArmure=(1,0.975,0.95,0.925,0.9,0.875,0.85,0.825,0.8,0.775,0.75,0.725,0.7,0.675,0.65,0.625,0.6,0.575,0.55,0.525,0.5);
	var
		i: Integer;
	begin

		if t = armure then
		begin
			for i := 0 to length(listPrix) do
			begin
			 	listPrix[i] := round(listPrix[i]*listMarchandage[joueur.marchandArmure]);
			 end
		end
		else
		begin
			for i := 0 to length(listPrix) do
		begin
		 	listPrix[i] := round(listPrix[i]*listMarchandage[joueur.marchandArme]);
		 end  	
		end; 
		
	end;


end.

