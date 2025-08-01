unit unitMenuInit;    

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
    Windows, LCL, FileUtil, LazUTF8, unitcreationPerso,
    Classes, SysUtils, GestionEcran, keyboard, unitInterface, unitSave;

type
    sens = (droite, gauche);
    ethnie = array[1..11] of String;


  //menu du jeu /jouer / Quitter
  procedure menu(var j : perso);


implementation

    procedure menu(var j : perso);
    var
        coord, coord2 : coordonnees;
        K : TKeyEvent;
        choix : Integer;
        joueur : perso;

    const
        SCREEN_WIDTH = 200;
        SCREEN_HEIGHT = 60;

    begin
        //up 65313, down 65319, left 65315, right 65317

        InitKeyboard;


        choix := 0;
        coord.x := (SCREEN_WIDTH div 2) - 5;
        coord.y := (SCREEN_HEIGHT div 2);

        coord2.x := (SCREEN_WIDTH div 2) - 6;
        coord2.y := (SCREEN_HEIGHT div 2);

        dessinerCadreXY((SCREEN_WIDTH div 2) - 10, (SCREEN_HEIGHT div 2) - 2, (SCREEN_WIDTH div 2) + 5, (SCREEN_HEIGHT div 2) + 5,  double, 8, 0);


        couleurTexte(15);
        selecteur(coord2, choix);
        ecrireEnPosition(coord, 'Nouveau');
        coord.y += 1;
        ecrireEnPosition(coord, 'Load');
        coord.y += 1;
        ecrireEnPosition(coord, 'Cheat');
        coord.y += 1;
        ecrireEnPosition(coord, 'Exit');

        coord.x := (SCREEN_WIDTH div 2) - 5;
        coord.y := (SCREEN_HEIGHT div 2);

        Repeat
            // on recupere un evenement du clavier
            K:=GetKeyEvent;
            K:=TranslateKeyEvent(K);

            //si le code correspond à un evenement
            Case GetKeyEventCode(K) of
              65313    : up(choix, coord, 3);
              65319  : down(choix, coord,-2);
            end;    


            if (choix = -1) and (coord2.y > 30) then
            begin
                selecteur(coord2, -1);
            end
            else if (choix = 1) and (coord2.y < 33) then
            begin
                selecteur(coord2, 1)
            end;

            choix := 0;

        Until (GetKeyEventCode(K) = 7181);
        DoneKeyBoard;

        case coord2.y of
            30: creationPerso(j);
            31 : load(j);
            32 : writeln('cheat');

        end;

        
    end;




end.

