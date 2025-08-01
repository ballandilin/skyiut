unit unitmap;

{$mode objfpc}{$H+}
{$codepage UTF8}

interface


// c = chemin
// F, V, B... = les chatelleries
// trouver d'autres evenement
// e = ?
// # = bord de map ?

// map = [
    // [#1, Fo, #2, V, #3, #4, #5, Fai, #6],
// 	   [#7, #8, #9, #10, #11, #12, #13, #14, #15],
// 	   [#16, A, #17, #18, B, #19, #20, #21, #22],
// 	   [#23, #24, M, #25, #26, #27, #28, fal, #29],
// 	   [#30, S, #31, #32, #33, #34, #35, #36, #37],
// 	   [#38, #39, #40, #41, #42, #43, #44, #45, #46]
// 	   ]

// map = [[0, 1, 2, 3, 4, 5, 6, 7, 8],
// 	   [9, 10, 11, 12, 13, 14, 15, 16, 17],
// 	   [18, 19, 20, 21, 22, 23, 24, 25, 26],
// 	   [27, 28, 29, 30, 31, 32, 33, 34, 35],
// 	   [36, 37, 38, 39, 40, 41, 42, 43, 44],
// 	   [45, 46, 47, 48, 49, 50, 51, 52, 53]
// 	   ]

uses
	Classes, SysUtils, gestionEcran, keyboard, unitInterface, unitcreationperso,
	unitmenuinit;

type
	map = array[1..8, 1..9] of String;

  // permet la gesstion du deplacement de joueur a travers la map
  procedure gestionMap(var joueur : perso; map : map);

  function getMapCoord(joueur : perso; map : map) : String;

  // recupere la gestion quand le joueur est dans une ville
  procedure gestionMapVille();

  // gestion des evenement de la map
  procedure gestionMapEvent();

implementation

	procedure gestionMap(var joueur : perso; map : map);
	var
		player : String;
		temp : String;
		choixX, choixY : Integer;
		coordMap, coordTextMap: coordonnees;
		k : TKeyEvent;
		i, n : Integer;

	begin

	player := 'P';

	coordMap.x := joueur.coordSurMap.x;
	coordMap.y := joueur.coordSurMap.y;

	// coordMap.x := 50;
	// coordMap.y := 0;

	choixX := 0;
	choixY := 0;
	InitKeyBoard;
	//up 65313, down 65319, left 65315, right 65317
	  Repeat


	    K:=GetKeyEvent;
	    K:=TranslateKeyEvent(K);
	    Case GetKeyEventCode(K) of
	      65313 : 	up(choixY, coordMap, 4);
	      65319  : down(choixY, coordMap, -2);
	      65315    : left(choixX, coordMap,-1);
	      65317     : right(choixX, coordMap, 4);
	    end;

	    effacerEcran();

	   	// if map[coordMap.y, (coordMap.x + choixX)] <> '#' then
	   	// begin
	   	// 	// mapSk[tempY, tempX] := temp;
	   	// 	coordMap.x += choixX;
	   	// end;

	   	// if map[(coordMap.y + choixY), coordMap.x] <> '#' then
	   	// begin
	   	// 	// mapSk[tempY, tempX] := temp;
	   	// 	coordMap.y += choixY;
	   	// end

	   	if (coordMap.x + choixX > 1)  and (coordMap.x + choixX < 9) then
	   	begin
	   		coordMap.x += choixX;
	   	end;

	   	if (coordMap.y + choixY > 1) and (coordMap.y + choixY < 8) then
	   	begin
	   		coordMap.y += choixY;
	   	end;

	   	map[coordMap.y, coordMap.x] := player;

	   	choixX := 0;
	   	choixY := 0;


		for i := 1 to 8 do
	    begin
			for n := 1 to 9 do
			begin 
				// write(map[i, n], '	');
				ecrireEnPosition(coordTextMap, map[i, n]);
				coordTextMap.x += 4;
			end;
			writeln();
			// coordTextMap.x := 50;
			coordTextMap.y += 1;
	    end;

	  Until ((GetKeyEventCode(K)= 65313) or (GetKeyEventCode(K)= 65319) or (GetKeyEventCode(K)= 65315) or (GetKeyEventCode(K)= 65317));
	  DoneKeyBoard;

	  joueur.coordSurMap.x := coordMap.x;
	  joueur.coordSurMap.y := coordMap.y;
		
	end;

	function getMapCoord(joueur : perso; map : map) : String;
	begin
		getMapCoord := map[joueur.coordSurMap.y, joueur.coordSurMap.x];
	end;


	procedure gestionMapVille();
	begin
		
	end;

  	procedure gestionMapEvent();
  	begin
  		
  	end;



end.

