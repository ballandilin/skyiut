unit unitAcceuilAnim;

{$mode objfpc}{$H+}

interface

uses
    Windows, LCL, FileUtil, LazUTF8,
  	Classes, SysUtils, GestionEcran, keyboard, unitPerso;
	
    // affiche le fichier 
	procedure afficheDUTHESDA();




implementation
	

	procedure afficheDUTHESDA();
    const
        MAGIC_NUMBER = 8000;
	var
        SL_dut : TStringList;
        coord : Coordonnees;
        f_nom : String;
        l_Texte, i : Integer;

    begin


    	i := 0;
    	l_texte := 0;
    	couleurTexte(0);
        coord.x := 10;
        coord.y := 13;
        f_nom := 'DUTHESDA.txt';

        // on crée une instance de la classe TStringList
        SL_dut := TStringList.Create;

        try
            // le code peut générer une exception dans le cas d'un fichier inexistant ou une erreur de lecture, donc l'utilisation du
            // on charge les differents fichier dans les variables prévues pour
            SL_dut.LoadFromFile('data//logo//text//' + f_nom);
            SL_dut.Text := SysToUtf8(SL_dut.text); // on convertit en utf8 le texte au cas ou d'un mauvais encodage
            l_Texte := length(SL_dut.text); // on recupere la taille du de la chaine de caractere, le ".text" est une méthode de la classe TStringList pour récuperer le texte
            ecrireEnPosition(coord, SL_dut.Text);

            for i := 1 to (l_Texte - MAGIC_NUMBER) do
            begin
                //on colorie le texte de la zone selectionné en blanc pour affiche le texte petit a petit
                ColorierZone(0, 15, coord.x, coord.x + i, coord.y);
            end;

            for i := 1 to l_Texte div 3 do
            begin
                //on colorie le texte de la zone selectionné en noir pour faire disparaitre le texte
                ColorierZone(0, 0, coord.x, coord.x + i, coord.y);
            end;

        finally
        	SL_dut.clear; // libere la variable pour une utilisation future
            SL_dut.Free;
            couleurTexte(15); // on remet la couleur du text a blanc
        end;
		
	end;

end.

