unit unitInterface;

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
    Windows, LCL, FileUtil, LazUTF8,
  	Classes, SysUtils, GestionEcran, keyboard;

type
    sens = (droite, gauche);


  //procedure pour gerer les mvt haut, bas, gauche, droite
  // procedure mouvement(coord : coordonnees; upMax, downMax, leftMax, rightMax, varDefil : Integer);
  // procedure mouvement(coord : coordonnees, upMax, downMax, leftMax, rightMax, choixVert, choixHorizon : Integer);
  // procedure left incremente une variable pour bouger dans un tableau
  procedure left(var choix : Integer; coord : Coordonnees; leftMax : Integer);

    procedure afficheFichePerso(nomPerso : String; coord : coordonnees);


  // procedure Right decremente une variable pour bouger dans un tableau
  procedure right(var choix : Integer; coord : Coordonnees; rightMax : Integer);

  // procedure left incremente une variable pour bouger dans un tableau
  // procedure Left(var v : Integer; coord : Coordonnees);

  // procedure Right decremente une variable pour bouger dans un tableau
  // procedure Right(var v : Integer; coord : Coordonnees);

  //
  procedure up(var choix : Integer; coord : Coordonnees; upMax : Integer);

  // //
  procedure down(var choix : Integer; coord : Coordonnees; downMax : Integer);


  // procedure qui fait une jolie fleche...pour naviguer
  procedure fleche(coord : coordonnees; sensFleche : sens);

  //affiche un selecteur qui bouge en fonction d'une variable, choix ici
  // un simple selecteur "<" ou ">" qui se deplace avec haut bas dasn notre cas
   procedure selecteur(var coord :  coordonnees; choix : integer);

  // formate le texte d'une fichier txt puis l'affiche 
  procedure formatTexteFile(nomDescription : String; coord : coordonnees);

  procedure afficheImageAscii(nomAscii : String);



  // procedure pour decvaler les cadre
  procedure decalage(var coord1, coord2 : Coordonnees; decalage1X, decalage1Y, decalage2X, decalage2Y, SCREEN_WIDTH, SCREEN_HEIGHT : Integer);

    // ┌─┐      ┌─┐
    // └─┼──────┼─┘
    //   │      │  
    // ┌─┼──────┼─┐
    // └─┘      └─┘



implementation


    procedure left(var choix : Integer; coord : Coordonnees; leftMax : Integer);
    begin
    // si la variable est supérieur a 0 soit le debut du tableau on décrémente
    	if choix > leftMax then
    	begin
    		choix -= 1;
    	end;
    end;


    procedure right(var choix : Integer; coord : Coordonnees; rightMax : Integer);
    begin
    // si la variable est inférieur a 10 soit la fin du tableau on incremente
    	if choix < rightMax then
    	begin
    		choix += 1;
    	end;

    end;


    procedure up(var choix : Integer; coord : Coordonnees; upMax : Integer);
    begin
        if choix < upMax then
        begin
             choix -= 1;
        end;
            
    end;


    procedure down(var choix : Integer; coord : Coordonnees; downMax : Integer);
    begin
        
        if choix > downMax then
        begin
             choix += 1;
        end
    end;

    procedure afficheImageAscii(nomAscii : String);
    var
        SL_ascii : TStringList;
        coord : Coordonnees;

    begin

        coord.x := 0;
        coord.y := 0;

        // on crée une instance de la classe TStringList
        SL_ascii := TStringList.Create;
        nomAscii += '.txt';

        try
            // on charge les differents fichier dans les variables prévues pour
            SL_ascii.LoadFromFile('data//logo//text//'+nomAscii);
            SL_ascii.Text := SysToUtf8(SL_ascii.text);
            ecrireEnPosition(coord, SL_ascii.Text);
        finally
            SL_ascii.clear;
            SL_ascii.Free;
        end


    end;





    
    procedure formatTexteFile(nomDescription : String; coord : coordonnees);
    var
        f_description : TextFile;
        s : string;
        i, position: Integer;
        f_path : String;

    begin

        //regex [0-9]

        i := 0;
        nomDescription += '_des.txt';
        f_path := 'data//logo//text//' + nomDescription;

        // on crée une instance de la classe TStringList de rien du tout ca marche pas avec l'utf-8 -> a revoir
        assignFile(f_description, f_path);

        try
            // on ouvre le fichier en mode "lecture"
            reset(f_description);

            // tant que l'on est pas a la fin du fichier on boucle (eof = end of file)
            while not eof(f_description) do
                begin
                    //on lit chaque ligne et on les mets dans la variable s
                    readln(f_description, s);
                    ecrireEnPosition(coord, s);
                    coord.y += 1;
                end;
                    
                    // temp.append((s));
            
        finally
            //on ferme le fichier pour plus tard
            CloseFile(f_description);
                
        end;



        // temp.text := SysToUtf8(temp.text);

        // for i := 1 to length(temp.Text) do
        // begin
        //      if temp.text[i] in ['0'..'9'] then
        //         couleurTexte(2);

        //     if temp.text[i] = #13 then 
        //         begin
        //             coord.y += 1;
        //             coord.x := 60;
        //         end


        //     else 
        //         coord.x += 1;

        //     ecrireEnPosition(coord, temp.Text[i]);
        //     couleurTexte(15);
        //  end;

        //  temp.Clear;
        //  temp.Free;
        
    end;


    procedure afficheFichePerso(nomPerso : String; coord : coordonnees);

    begin

        // on crée une instance de la classe TStringList
        afficheImageAscii(nomPerso);
        formatTexteFile(nomPerso, coord);

    end;




    procedure fleche(coord : coordonnees; sensFleche : sens);

    begin
        deplacerCurseur(coord);
        if sensFleche = droite then
        begin

            writeln('┌───┐');
            deplacerCurseurXY(coord.x, coord.y+1);
            writeln('└┐  └┐');
            deplacerCurseurXY(coord.x, coord.y+2);
            writeln(' └┐  └┐');
            deplacerCurseurXY(coord.x, coord.y+3);
            writeln(' ┌┘  ┌┘ ');
            deplacerCurseurXY(coord.x, coord.y+4);
            writeln('┌┘  ┌┘');
            deplacerCurseurXY(coord.x, coord.y+5);
            writeln('└───┘');
        end
        else
        begin

            writeln('  ┌───┐');
            deplacerCurseurXY(coord.x, coord.y+1);
            writeln(' ┌┘  ┌┘');
            deplacerCurseurXY(coord.x, coord.y+2);
            writeln('┌┘  ┌┘');
            deplacerCurseurXY(coord.x, coord.y+3);
            writeln('└┐  └┐');
            deplacerCurseurXY(coord.x, coord.y+4);
            writeln(' └┐  └┐');
            deplacerCurseurXY(coord.x, coord.y+5);
            writeln('  └───┘');
        end;
    end;


    procedure selecteur(var coord :  coordonnees; choix : integer);
    begin
        ecrireEnPosition(coord, ' ');
        coord.y += choix;
        ecrireEnPosition(coord, '>');
    end;





    procedure decalage(var coord1, coord2 : Coordonnees; decalage1X, decalage1Y, decalage2X, decalage2Y, SCREEN_WIDTH, SCREEN_HEIGHT : Integer);
    begin
        coord1.x := (SCREEN_WIDTH div 2) + decalage1X;
        coord1.y := (SCREEN_HEIGHT div 2) + decalage1Y;
        coord2.x := (SCREEN_WIDTH div 2) + decalage2X;
        coord2.y := (SCREEN_HEIGHT div 2)+ decalage2Y;
    end;

end.

