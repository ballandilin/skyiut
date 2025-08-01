unit unitSave;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, unitCreationPerso, fpjson, jsonparser, fpjsonrtti;

//Memo1.Lines.LoadFromFile('YourFile.json');  a regarder

  procedure save(joueur : perso);
  procedure load(var joueur : perso);
  function txtToJson(filename : String) : String;
  procedure saveToFile(chaine : String);

implementation

	procedure load(var joueur : perso);
  var
    J: TJSONData;
    i, n : Integer;
  begin
    i := 1;
    n := 1;

    creationPerso(joueur);

    // Parse JSON Data to TJSONData
    J:=GetJSON(txtToJson('save.txt'));
    // Get the value for the path in edtPath
 
    joueur.nom := J.FindPath('perso.nom[0]').AsString;
    joueur.ethnie := J.FindPath('perso.ethnie[0]').AsString;
    joueur.vie := J.FindPath('perso.vie[0]').AsInteger;
    joueur.lieu := J.FindPath('perso.lieu[0]').AsString;
    joueur.monnaie := J.FindPath('perso.monnaie[0]').AsInteger;
    
    for i := 1 to 24 do
    begin
      for n := 0 to 3 do
      begin
        joueur.inventaire[i, n+1] := J.FindPath('perso.inventaire.'+intToStr(i)+'['+intToStr(n)+']').AsString;
      end;
    end;
  end;

  procedure save(joueur : perso);
  var
    J, copy: TJSONData;
    i, n, compteur1, compteur2 : Integer;
  begin
    // Parse JSON Data to TJSONData
    J:=GetJSON(txtToJson('save.txt'));



    //on réecrit les données du héro
    copy := GetJSON('{"item": "' + joueur.nom + '"}');
    TJSONArray(J.FindPath('perso.nom')).items[0] := copy.FindPath('item');

    copy := GetJSON('{"item": "' + joueur.ethnie + '"}');
    TJSONArray(J.FindPath('perso.ethnie')).items[0] := copy.FindPath('item');

    copy := GetJSON('{"item": "' + intToStr(joueur.vie) + '"}');
	TJSONArray(J.FindPath('perso.vie')).items[0] := copy.FindPath('item');

	copy := GetJSON('{"item": "' + joueur.lieu + '"}');
	TJSONArray(J.FindPath('perso.lieu')).items[0] := copy.FindPath('item');

	copy := GetJSON('{"item": "' + intToStr(joueur.monnaie) + '"}');
	TJSONArray(J.FindPath('perso.monnaie')).items[0] := copy.FindPath('item');
	
    for i := 1 to 24 do
    begin
      for n := 0 to 3 do
      begin

      	try
        	copy := GetJSON('{"item": "' + joueur.inventaire[i, n+1] + '"}');
        	TJSONArray(J.FindPath('perso.inventaire.'+intToStr(i))).items[n] := copy.FindPath('item');
        except
      		on E: EAccessViolation do
                begin
        	   writeln('Erreur: ', E.Message);
                   sleep(3000);
                   readln();
                end;


        end;

      end;
    end;
    // for i := 1 to 24 do
    // begin
    //   for n := 2 to 3 do
    //   begin
    //     TJSONArray(J.FindPath('perso.inventaire.'+intToStr(i))).insert(n, joueur.inventaire[i, n+1]);
    //   end;
    // end;

    saveToFile(j.asJson);
  end;

	procedure saveToFile(chaine : String);
    var
        f_description : TextFile;
        s, nom : string;
        i, position: Integer;
        f_path : String;

    begin

        //regex [0-9]

        i := 0;
        nom := 'save.txt';
        //f_path := 'data//logo//text//' + nomDescription;

        // on crée une instance de la classe TStringList de rien du tout ca marche pas avec l'utf-8 -> a revoir
        assignFile(f_description, nom);

        try
            // on ouvre le fichier en mode "lecture"
            rewrite(f_description);

            // tant que l'on est pas a la fin du fichier on boucle (eof = end of file)
            write(f_description, chaine);

            
                    
                    // temp.append((s));
            
        finally
            //on ferme le fichier pour plus tard
            CloseFile(f_description);
                
        end;
     end;


  procedure JsonToText(fdata : String);
  var
    MyFile: TStringList;
    tfout : textfile;

  begin

    assign(tfout, 'save.txt');

    MyFile := TStringList.create;

     try
      // Load the contents of the textfile completely in memory
      rewrite(tfout);
      write(tfout, '');
      closeFile(tfout);
      MyFile.LoadFromFile('save.txt');

      MyFile.add(fdata);

      MyFile.saveToFile('test.txt');

      // Add some more contents

      // And write the contents back to disk, replacing the original contents

    except
      // If there was an error the reason can be found here
      on E: EInOutError do
        writeln('File handling error occurred. Reason: ', E.Message);
    end;

    // Clean up
    MyFile.clear;
    MyFile.Free;

  end;

  function txtToJson(filename : String) : String;
  var
    MyFile: TStringList;
    Data: String;

  begin

    MyFile := TStringList.create;

     try
      // Load the contents of the textfile completely in memory
      MyFile.LoadFromFile(filename);

      // Add some more contents
      txtToJson := MyFile.text;
      // And write the contents back to disk, replacing the original contents

    except
      // If there was an error the reason can be found here
      on E: EInOutError do
        writeln('File handling error occurred. Reason: ', E.Message);
    end;

    // Clean up
    MyFile.clear;
    MyFile.Free;

  end;
end.

