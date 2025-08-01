unit unitCreationPerso;

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
Windows,LCL,FileUtil,LazUTF8,
	Classes,SysUtils,GestionEcran,keyboard,unitinterface;

type
	
// 	listEquipement=(epeeenfer, masseenfer, hacheenfer, epeeadeuxmainenfer, epeeenacier,
// 					masseenacier, hacheenacier, epeeadeuxmainenacier, epeeengriffedeDovahBear,
// 					masseengriffedeDovahBear, hacheengriffedeDovahBear, epeeadeuxmainengriffedeDovahBear,
// 					casqueenfer, plastronenfer, gantsenfer, bottesenfer,
// 					casqueenacier, plastronenacier, gantsenacier, bottesenacier,
// 					casqueengriffedeDovahBear, plastronengriffedeDovahBear, gantsengriffedeDovahBear,
// 					bottesengriffedeDovahBear);
	
	item = array[1..4] of string; //[typeItem = arme ou armure, materiaux, typeArme ou typeArmure, nom]

	degatRatio = array[1..2, 1..3, 1..4] of real;

	ethnie = array[1..11] of String;
	// inventaire = record
	// 	arme : array[1..4] of String;
	// 	armure : array[1..4] of String;
	// end;

	inventaire = array[1..24] of item;

	equipement = record
		armeEquipe : real;
		armureTeteEquipe : real;
		armurePlastronEquipe : real;
		armureGantEquipe : real;
		armureBotteEquipe : real;
	end;

	perso=record

			nom:String;
			vie:Integer;
			stamina:Integer;
			magie:Integer;
			monnaie:Integer;
			experience:Integer;
			lvl:Integer;
			quete : Integer;
			coordSurMap:coordonnees;
			marchandArme: integer;
            marchandArmure: integer;
			ethnie:String;
			inventaire:inventaire;
			equipement:equipement;
			lieu:String;
			iWantToPlay : Boolean;

		end;

	ennemie=record
		nom:String;
		vie:Integer;
	end;

	const
		DEGAT_RATIO : degatRatio = (
                                           (
                                            (1.2, 1.2, 1.3, 1.7),
                                            (2, 2, 2.3, 2.7),
                                            (5, 5, 5.3, 5.7)
                                            ),
                                            (
                                             (0.99, 0.97, 0.99, 0.98),
                                             (0.95, 0.90, 0.95, 0.97),
                                             (0.5, 0.4, 0.55, 0.56)
                                             )

                                    );// ratio arme et ratio armure


//proceduremenuTitre();
procedure choixPerso(var perso:perso);

//creationdupersonnagedebase,sanscompetence
procedure creationPerso(var j:perso);

procedure setVie(var joueur:perso; degat:Integer);
procedure setVie(var ennemie:ennemie; degat:Integer; joueur:perso);

procedure setCoordSurMap(var j:perso; coord:coordonnees);

procedure getCoordSurMap(var coord:coordonnees; j:perso);



implementation


procedure choixPerso(var perso : perso);

	var

		supCornerL, infCornerL, supCornerR, infCornerR, 
		supCorner, infCorner, coordText: Coordonnees;
		coordAff : coordonnees;
		K : TKeyEvent;
		bord : typeBordure;
		defilTabPerso : Integer;
        str : String;
        nom : String;
        taile_nom_ethnieDiv, taile_nom_ethnie : Integer;


	const
		SCREEN_WIDTH = 200;
		SCREEN_HEIGHT = 60;
		PERSO_ethnie : ethnie = ('Argonien', 'Breton', 'Elf noir', 'Haut elf', 'Elf des bois', 'Imperial', 'Imp', 'Khajiit', 'Nordique', 'Orque', 'Rougegarde');

	begin

        
		InitKeyboard;

        str := '';
        nom := '';
        taile_nom_ethnieDiv := length(PERSO_ethnie[1]) div 2;
        taile_nom_ethnie := length(PERSO_ethnie[1]);
        defilTabPerso := 1;
        
        // initialise coord Texte
		coordText.x := (SCREEN_WIDTH div 2) - 7;
		coordText.y := (SCREEN_HEIGHT div 2) + 7;

        // initialise coord coin Supérieur/inférieur du cadre de droite
		supCornerR.x := (SCREEN_WIDTH div 2) + 7;
		supCornerR.y := (SCREEN_HEIGHT div 2) + 5;

        // initialise coord coin Supérieur/inférieur du cadre de gauche
		supCornerL.x := (SCREEN_WIDTH div 2);
		supCornerL.y := (SCREEN_HEIGHT div 2);

		coordAff.x := 61;
		coordAff.y := 0;

		bord := simple;

        afficheFichePerso(lowerCase(PERSO_ethnie[defilTabPerso]), coordAff);
        ecrireEnPosition(coordText, PERSO_ethnie[defilTabPerso]);
        fleche(supCornerR, droite);

		// récupère les evenements clavier
		// 7181 => touche enter
		InitKeyBoard;

		Repeat
			// on recupere un evenement du clavier
		    K:=GetKeyEvent;
		    K:=TranslateKeyEvent(K);
		    //si le code correspond à un evenement

		    Case GetKeyEventCode(K) of
		      65315    : Left(defilTabPerso, coordText, 1);
			  65317  : Right(defilTabPerso, coordText, 11);
		    end;

            taile_nom_ethnieDiv := length(PERSO_ethnie[defilTabPerso]) div 2;
            taile_nom_ethnie := length(PERSO_ethnie[defilTabPerso]);


		    if (defilTabPerso > 1) and (defilTabPerso < 11) then
		    begin
                effacerEcran();
		    	// on change les coords du retangle de base pour dessiner un rectangle de chaque coter
                decalage(supCornerR, infCornerR, 5 + taile_nom_ethnieDiv, 5, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                decalage(supCornerL, infCornerL,  -20 - taile_nom_ethnieDiv, 5, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

                fleche(supCornerL, gauche);
                fleche(supCornerR, droite);

		    end

		    else if defilTabPerso = 11 then //si on est au dernier element du tableau 
		    begin
		    	effacerEcran();
                decalage(supCornerL, infCornerL, -20 - taile_nom_ethnieDiv, 5, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                fleche(supCornerL, gauche);

		    end

		    else if defilTabPerso = 1 then
		    begin

                // decalage de SLX + 8, SLY + 5, ILX + 22, ILY + 7 
		    	effacerEcran();
                decalage(supCornerR, infCornerR, 5 + taile_nom_ethnieDiv, 5, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
                fleche(supCornerR, droite);
	
		    end;


		    afficheFichePerso(lowerCase(PERSO_ethnie[defilTabPerso]), coordAff);
		    ecrireEnPosition(coordText, PERSO_ethnie[defilTabPerso]);

		Until (GetKeyEventCode(K) = 7181);

        perso.ethnie := PERSO_ethnie[defilTabPerso];


        dessinerCadreXY((SCREEN_WIDTH div 2) - 10, (SCREEN_HEIGHT div 2) , (SCREEN_WIDTH div 2) + 5, (SCREEN_HEIGHT div 2) + 2,  double, 8, 0);

        deplacerCurseurXY((SCREEN_WIDTH div 2) - 9, (SCREEN_HEIGHT div 2) + 1);

        couleurs(15, 0);

        coordText.x:=(SCREEN_WIDTH div 2)-9;
		coordText.y:=(SCREEN_HEIGHT div 2)+1;

        ecrireEnPosition(coordText,'nom: ');

        readln(nom);
        perso.nom := nom;

        writeln();
        DoneKeyBoard;

        

    end;


procedure creationPerso(var j:perso);
	var
		i:Integer;
		unItemExemple : item = ('', '', '', '');
	begin

		i:=0;
		j.nom:='';
		j.vie:=100;
		j.stamina:=100;
		j.magie:=100;
		j.monnaie:=100;
		j.experience:=0;
		j.ethnie := '';
		j.lvl:=1;
		j.quete := 0;
		j.coordSurMap.x:=5;
		j.coordSurMap.y:=4;
		j.marchandArme:=0;
        j.marchandArmure:=0;

		for i:=1 to 24 do
		begin

			j.inventaire[i] := unItemExemple;

		end;

		j.equipement.armeEquipe:=1;
		j.equipement.armureTeteEquipe:=1;
		j.equipement.armurePlastronEquipe:=1;
		j.equipement.armureGantEquipe:=1;
		j.equipement.armureBotteEquipe:=1;
		
		j.lieu:='fortDragon';
		j.iWantToPlay := true;

		effacerEcran();


	end;


	procedure setCoordSurMap(var j:perso; coord:coordonnees);
	begin
		j.coordSurMap.x:=coord.x;
		j.coordSurMap.y:=coord.y;
	end;

	procedure getCoordSurMap(var coord:coordonnees; j : perso);
	begin
		coord.x:=j.coordSurMap.x;
		coord.y:=j.coordSurMap.y;
	end;


	procedure setVie(var joueur:perso; degat : Integer);
	begin
		joueur.vie+=round(degat*(joueur.equipement.armureTeteEquipe * joueur.equipement.armurePlastronEquipe * joueur.equipement.armureGantEquipe * joueur.equipement.armureBotteEquipe));
	end;

	procedure setVie(var ennemie:ennemie; degat:Integer; joueur:perso);
	begin
		ennemie.vie+=round(degat*joueur.equipement.armeEquipe);
	end;




end.

