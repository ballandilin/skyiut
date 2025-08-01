unit unitinterfaceMenuHistoire;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, gestionecran, unitcreationperso, unitmap;
  procedure menuHistoire(joueur : perso);

implementation

	procedure menuHistoire(joueur : perso);
	var
		coord: coordonnees;

	begin

		coord.x := 2;
		coord.y := 2;

		dessinerCadreXY(0, 0, 30, 59, double, 15, 0);
		dessinerCadreXY(31, 0, 199, 5, double, 15, 0);
		dessinerCadreXY(0, 47, 30, 59, double, 15, 0);

		coord.y += 1;

		ecrireEnPosition(coord, 'lieu : ' + joueur.lieu);


		coord.y += 14;
		ecrireEnPosition(coord, 'Inventaire');
		coord.y += 1;
		ecrireEnPosition(coord, 'sauvegarde');

		coord.y := 50;

		ecrireEnPosition(coord, 'Ethnie : ' + joueur.ethnie);
		coord.y += 1;
		ecrireEnPosition(coord, 'nom : ' + joueur.nom);
		coord.y += 1;
		ecrireEnPosition(coord, 'Pv : ' + intToStr(joueur.vie));
		coord.y += 1;
		ecrireEnPosition(coord, 'coins : ' + intToStr(joueur.monnaie));
	end;

end.

