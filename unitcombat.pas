unit unitCombat;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, MMSystem, unitcreationperso, gestionEcran, unitInventaire;

  // gestion des combat contre les ennemies du bestiaire
  procedure gestionCombat(var joueur : perso; mechant : ennemie);

  //gestion des combats personnalisés contre des ennemies renconré une seul fois
  procedure gestionCombatPerso(var joueur : perso; var mechant : ennemie);

  //gestion du butin apres un combat
  procedure butin(var joueur : perso);

  // gestion des degats recu lors des combats
  function degat() : Integer;

implementation

	procedure gestionCombat(var joueur : perso; mechant : ennemie);
	var
		coord, coordVie: coordonnees;
		pointDegat : Integer;
		nomE : String;
		itsNotOver : Boolean;
		choix : String;
		ratioArmure : Real;
		ratioArme : Real;
        effet : Integer;
        Saignement : Integer;
        EffetSurJoueur: String;
        EffetSurEnnemi: String;
        Saigne: String;
        degatsEnnemi:Real;
        typeEnnemi:Integer;                

	begin
        Randomize; // initilisation d'une nouvelle sequence de "hasard"
		sndPlaySound('sound//e1m1.wav', snd_Async);

        typeEnnemi:=random(50); // suivant le type de l'ennemie on assigne des points de vie et de degats differents
        case typeEnnemi of
                1..20 : begin
                   			degatsEnnemi:= 1.0;
                   			mechant.vie := 100;
                  		end;

                21..33 : begin
                   			degatsEnnemi:= 1.0;
                   			mechant.vie := 50;
                  		end;
                34..43 : begin
                   			degatsEnnemi:= 1.0;
                   			mechant.vie := 80;
                  		end;    {ce que j'ai rajouté}
                44..50 : begin
                   			degatsEnnemi:= 1.0;
                   			mechant.vie := 120;
                  		end;
        end;
        case typeEnnemi of
             1..20 : nomE:= 'Bandit';
             21..33 : nomE:='Squelette';         // assignation des nom des differents ennemies
             34..43 : nomE:='Gévripeire';
             44..50 : nomE:='Loup des plaines';
        end;

        ratioArme := joueur.equipement.armeEquipe; // recuperation des degats pouvant etre effectué par le perso
        // récuperation la protection de l'armure
		ratioArmure := (joueur.equipement.armureTeteEquipe * joueur.equipement.armurePlastronEquipe * joueur.equipement.armureGantEquipe * joueur.equipement.armureBotteEquipe);

		choix := '';
		itsNotOver := true;
		coord.x := 60;
		coord.y := 5;

		coordVie.x := 2;
		coordVie.y := 50;

		ecrireEnPosition(coord, 'Vous avez engagé un combat contre ' + nomE);
		effacerEcran();
		ecrireEnPosition(coord, 'Vous commencez à attaquer');

		coord.y := 10;

                EffetSurJoueur:=' ';
                EffetSurEnnemi:=' ';


		while (itsNotOver) and (joueur.vie >= 0) and (mechant.vie >= 0) do // tant que le hero ne fuit pas, ou que le perso ou l'ennemie a des points de vie supérieur ou égal a zero
		begin

			ecrireEnPosition(coordVie, joueur.nom + ' vie : ' + intToStr(joueur.vie));
			coordVie.y += 1;
			ecrireEnPosition(coordVie, nomE + ' vie : ' + intToStr(mechant.vie));

			coordVie.y := 50;

			pointDegat := degat();

			ecrireEnPosition(coord, 'Que voulez-vous faire');
			coord.y += 1;
			ecrireEnPosition(coord, '1. Attaquer votre ennemi avec votre arme');
			coord.y += 1;
			ecrireEnPosition(coord, '2. Fuir');
			coord.y += 1;
			ecrireEnPosition(coord, 'Votre choix : ');
			readln(choix);

			effacerEcran();

			case choix of
				'1' : setVie(mechant, -pointDegat, joueur);
				'2' : itsNotOver := false; // fuite le perso peut donner un coup en traitre de meme pour l'ennemie
				else
				begin // si le joueur rentre n'importe quoi ou miss click c'est punitif
					effacerEcran();
					coord.y -= 3;
					ecrireEnPosition(coord, 'vous avez trébuchez !!');
					EffetSurJoueur := 'etourdi';
					sleep(1500);
				end;
			end;


                        if joueur.vie > 0 then
                           begin
                              if EffetSurJoueur='etourdi' then
                                 begin
                                    ecrireEnPosition(coord, 'Vous êtes étourdi, vous ne pouvez pas attaquer !');
                                    sleep(1500);
                                    EffetSurJoueur:=' ';
                                 end
                              else
                                 begin
			            ecrireEnPosition(coord, 'Vous infligez ' + intToStr(round(pointDegat * ratioArme)) + ' points de degats !');
                                    sleep(1500);
                                    effet:=random(100);
                                    if ((effet<10) and (effet>0)) then
                                       begin
                                          ecrireEnPosition(coord, 'Votre attaque a etourdi l''ennemi ! Il ne pourra plus attaquer jusqu''au prochain tour !');
                                          sleep(1500);
                                          EffetSurEnnemi:='etourdi';
                                       end
                                    else if ((effet<100) and (effet>95)) then
                                       begin
                                          ecrireEnPosition(coord, 'Votre attaque fait saigner abondamment votre ennemi ! Il perd de la vie !');
                                          sleep(1500);
                                          Saignement:=random(10);
                                          mechant.vie:=mechant.vie-Saignement;
                                          ecrireEnPosition(coord, 'Votre ennemi perd ' + intToStr(Saignement) + ' point(s) de vie à cause du saignement !');
                                          sleep(1500);
                                       end;
		                    sleep(1500);
                                 end;
                              end;

			   effacerEcran();

			   ecrireEnPosition(coordVie, joueur.nom + ' vie : ' + intToStr(joueur.vie));
			   coordVie.y += 1;
			   ecrireEnPosition(coordVie, nomE + ' vie : ' + intToStr(mechant.vie));

			   coordVie.y := 50;

			   coord.x := 60;
			   coord.y := 10;

			   ecrireEnPosition(coord, nomE + ' attaque : ');
			   sleep(1500);

			   effacerEcran();

			   ecrireEnPosition(coordVie, joueur.nom + ' vie : ' + intToStr(joueur.vie));
			   coordVie.y += 1;
			   ecrireEnPosition(coordVie, nomE + ' vie : ' + intToStr(mechant.vie));

			   coordVie.y := 50;

			   pointDegat := degat();

			   if mechant.vie > 0 then
			      begin
                                 if EffetSurEnnemi='etourdi' then
                                    begin
                                       ecrireEnPosition(coord, 'Votre ennemi est etourdi, il ne peut pas attaquer !');
                                       sleep(1500);
                                       EffetSurEnnemi:=' ';
                                    end
                                 else if (pointDegat = 0) then
				    begin
				       ecrireEnPosition(coord, nomE + ' vous a raté !');
				       sleep(1500);
				    end
				else
                                  begin
				     ecrireEnPosition(coord, nomE + ' vous inflige ' + intToStr(round(pointDegat*degatsEnnemi {ce que j'ai rajouté} * ratioArmure)) + ' points de degats !');
                                     sleep(1500);
				     setVie(joueur, -(round(pointDegat*degatsEnnemi{ce que j'ai rajouté})));
                                     effet:=Random(100);
                                     if ((effet<10) and (effet>0)) then
                                        begin
                                           ecrireEnPosition(coord, 'L''attaque de votre ennemi vous etourdi ! Vous ne pourrez plus attaquer jusqu''au prochain tour !');
                                           sleep(1500);
                                           EffetSurJoueur:='etourdi';
                                        end
                                     else if ((effet<100) and (effet>95)) then
                                        begin
                                           ecrireEnPosition(coord, 'L''attaque de votre ennemi vous fait saigner abondamment ! Vous perdez de la vie !');
                                           sleep(1500);
                                           Saignement:=random(10);
                                           setVie(joueur, -Saignement);
                                           ecrireEnPosition(coord, 'Vous perdez ' + intToStr(Saignement) + ' point(s) de vie à cause du saignement !');
                                           sleep(1500);
                                        end;
				  end;
                              end;
                           effacerEcran();
                end;

		coord.x := 200 div 2;
		coord.y := 60 div 2;

		ecrireEnPosition(coord, 'le combat est fini !!');
		sleep(1000);
		if itsNotOver then // si le joueur n'as pas fuit il recupere un butin
			butin(joueur);


		if joueur.vie <= 0 then
		begin
			effacerEcran();
			ecrireEnPosition(coord, 'Vous etes mort !');
			sleep(1500);
			joueur.iWantToplay := false;

		end;
	end;



	procedure gestionCombatPerso(var joueur : perso; var mechant : ennemie);
	var
		coord, coordVie: coordonnees;
		pointDegat : Integer;
		nomE : String;
		itsNotOver : Boolean;
		choix : Integer;
		ratioArmure : Real;
		ratioArme : Real;

	begin
		sndPlaySound('sound//e1m1.wav', snd_Async);

		nomE := mechant.nom;

 		ratioArme := joueur.equipement.armeEquipe;
		ratioArmure := (joueur.equipement.armureTeteEquipe * joueur.equipement.armurePlastronEquipe * joueur.equipement.armureGantEquipe * joueur.equipement.armureBotteEquipe);

		choix := 0;
		itsNotOver := true;
		coord.x := 60;
		coord.y := 5;

		coordVie.x := 2;
		coordVie.y := 50;

		ecrireEnPosition(coord, 'Vous avez engagez un combat contre ' + nomE);
		effacerEcran();
		ecrireEnPosition(coord, 'Vous commencer à attaquer');

		coord.y := 10;

		while (itsNotOver) and (joueur.vie > 0) and (mechant.vie > 0) do
		begin

			ecrireEnPosition(coordVie, joueur.nom + ' vie : ' + intToStr(joueur.vie));
			coordVie.y += 1;
			ecrireEnPosition(coordVie, nomE + ' vie : ' + intToStr(mechant.vie));

			coordVie.y := 50;

			pointDegat := degat();

			ecrireEnPosition(coord, 'Que voulez vous faire ? ');
			coord.y += 1;
			ecrireEnPosition(coord, '1. attaquer l''adversaire avec votre arme');
			coord.y += 1;
			ecrireEnPosition(coord, '2. fuir');
			coord.y += 1;
			ecrireEnPosition(coord, 'votre choix : ');
			readln(choix);

			effacerEcran();@

			case choix of
				1 : setVie(mechant, -pointDegat, joueur);
				2 : itsNotOver := false;
				else
				begin
					effacerEcran();
					coord.y -= 3;
					ecrireEnPosition(coord, 'Vous loupez votre ennemie');
					sleep(1500);
				end;
			end;

			ecrireEnPosition(coord, 'vous infligez ' + intToStr(round(pointDegat * ratioArme)) + ' pts de degats');
			sleep(1500);

			effacerEcran();

			ecrireEnPosition(coordVie, joueur.nom + ' vie : ' + intToStr(joueur.vie));
			coordVie.y += 1;
			ecrireEnPosition(coordVie, nomE + ' vie : ' + intToStr(mechant.vie));

			coordVie.y := 50;

			coord.x := 60;
			coord.y := 10;



			effacerEcran();

			ecrireEnPosition(coordVie, joueur.nom + ' vie : ' + intToStr(joueur.vie));
			coordVie.y += 1;
			ecrireEnPosition(coordVie, nomE + ' vie : ' + intToStr(mechant.vie));

			coordVie.y := 50;

			pointDegat := degat();

			if mechant.vie > 0 then
			begin
				ecrireEnPosition(coord, nomE + ' attaque');
				sleep(1500);
				if (pointDegat = 0) then
				begin
					ecrireEnPosition(coord, nomE + ' vous à loupé');
					sleep(1500);
				end
				else
					begin
						ecrireEnPosition(coord, nomE + ' vous inflige ' + intToStr(round(pointDegat * ratioArmure)) + ' pts de degats');
						setVie(joueur, -pointDegat);
						sleep(1500);
					end;
			end;
                    effacerEcran();
		end;

		coord.x := 200 div 2;
		coord.y := 60 div 2;

		ecrireEnPosition(coord, 'le combat est fini !!');
		sleep(1000);
		if itsNotOver then
			butin(joueur);

		if joueur.vie <= 0 then
		begin
			effacerEcran();
			ecrireEnPosition(coord, 'Vous etes mort !');
			sleep(1500);
			joueur.iWantToplay := false;

		end;

		

		

		
	end;

	function degat() : Integer;
	var
		tirage: Integer;

	begin

		randomize();
		tirage := random(50);

		case tirage of
			1..10 : tirage := 2;
			11..20 : tirage := 5;
			21..40 : tirage := 10;
			41..43 : tirage := random(15);

			else
			begin
				tirage := 0;
			end;
		end;
		degat := tirage;
	end;

	procedure butin(var joueur : perso);
	var
		tirageButinMonnaie: array[1..11] of Integer = (0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100); 
		tirageButinequipement: array[1..62] of Item = (
														('', '', '', ''),
														('1', '1', '1', 'épée en fer'),
														('2', '1', '1', 'casque en fer'),
														('2', '1', '2', 'plastron en fer'),
														('1', '2', '3', 'hache en acier'),	
														('1', '2', '1', 'épée en acier'),
														('2', '1', '1', 'casque en fer'),	
														('1', '1', '1', 'épée en fer'),
														('2', '1', '1', 'casque en fer'),
														('', '', '', ''),
														('', '', '', ''),
														('1', '3', '1', 'épée en griffe de dovahBear'),
														('2', '3', '2', 'plastron en griffe de dovahBear'),
														('2', '3', '1', 'casque en griffe de dovahBear'),
														('1', '1', '1', 'épée en fer'),
														('2', '1', '1', 'casque en fer'),
														('2', '2', '2', 'plastron en acier'),
														('1', '2', '3', 'hache en acier'),
														('', '', '', ''),
														('', '', '', ''),
														('', '', '', ''),
														('1', '2', '1', 'épée en acier'),
														('2', '1', '1', 'casque en fer'),	
														('1', '1', '1', 'épée en fer'),
														('2', '1', '1', 'casque en fer'),	
														('1', '3', '1', 'épée en griffe de dovahBear'),
														('2', '3', '2', 'plastron en griffe de dovahBear'),
														('2', '3', '1', 'casque en griffe de dovahBear'),
														('1', '1', '1', 'épée en fer'),
														('2', '2', '1', 'casque en acier'),
														('2', '1', '2', 'plastron en fer'),
														('1', '2', '3', 'hache en acier'),	
														('1', '2', '1', 'épée en acier'),
														('', '', '', ''),
														('2', '1', '1', 'casque en fer'),	
														('1', '1', '1', 'épée en fer'),
														('2', '1', '1', 'casque en fer'),	
														('1', '3', '1', 'épée en griffe de dovahBear'),
														('2', '3', '2', 'plastron en griffe de dovahBear'),
														('2', '3', '1', 'casque en griffe de dovahBear'),
														('1', '1', '1', 'épée en fer'),
														('', '', '', ''),
														('', '', '', ''),
														('', '', '', ''),
														('', '', '', ''),
														('', '', '', ''),
														('2', '1', '1', 'casque en fer'),
														('2', '1', '2', 'plastron en fer'),
														('1', '2', '3', 'hache en acier'),	
														('1', '2', '1', 'épée en acier'),
														('2', '1', '1', 'casque en fer'),	
														('1', '1', '1', 'épée en fer'),
														('2', '1', '1', 'casque en fer'),
														('', '', '', ''),
														('', '', '', ''),
														('', '', '', ''),
														('', '', '', ''),
														('', '', '', ''),
														('', '', '', ''),
														('1', '3', '1', 'épée en griffe de dovahBear'),
														('2', '3', '2', 'plastron en griffe de dovahBear'),
														('2', '3', '1', 'casque en griffe de dovahBear')	
													);
	begin
		randomize();
		joueur.monnaie += tirageButinMonnaie[random(10+1)];
		gestionInventaireAjout(joueur, tirageButinequipement[random(random(61+1))]);

		
	end;

end.

