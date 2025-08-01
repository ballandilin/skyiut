unit unitHistoire;

{$mode objfpc}{$H+}
{$codepage UTF8}

interface

uses
  Classes, SysUtils, unitmap, keyboard, unitInterface, unitcreationperso, gestionecran, unitinterfaceMenuHistoire, unitInventaire,
  unitcombat, unitSave;

  type
    // item = array[1..12] of String;
    prix = array[1..12] of Integer;



  procedure introduction(var joueur : perso);

  procedure fortDragon(var joueur : perso);



  procedure quartierDesNuees(var joueur : perso);

  procedure quartierDuVent(var joueur : perso);

  procedure quartierDesPlaines(var joueur : perso);

  procedure MainGates(var joueur : perso);

  procedure campagne(var joueur : perso);

  procedure auberge(joueur : perso);



  procedure frapperJarl(var joueur : perso);

  procedure parlerJarl(joueur : perso);

  procedure parlerChambellan(joueur : perso);

  procedure Inventaire(joueur : perso);



  procedure magasin(var joueur : perso);

  procedure magasinArme(var joueur : perso);

  procedure magasinArmure(var joueur : perso);

  procedure magasinVente(var joueur : perso);

  procedure repos(var joueur : perso);


  // permet la gestion des mouvement, dans le cas ou le joueur est a proximité des bord de la map ou autre
  procedure choixMouvement(var choix : Integer; choixMax : Integer);



implementation



  procedure introduction(var joueur : perso);
  var
    coordTexte : coordonnees;

  begin

    coordTexte.x := 31;
    coordTexte.y := 6;

    formatTexteFile('introduction', coordTexte);
    readln();
    effacerEcran();
    menuHistoire(joueur);
    formatTexteFile('introduction2', coordTexte);
    joueur.monnaie += 200;
    readln();

  end;


  procedure fortDragon(var joueur : perso);
  var
    coordTexte : coordonnees;
    dialogue : String;
    choix : Integer;
  begin

    if joueur.iWantToPlay then
    begin
      joueur.lieu := 'fortDragon';
      effacerEcran();
      menuHistoire(joueur);

      coordTexte.x := 31;
      coordTexte.y := 6;

      formatTexteFile('fortDragon', coordTexte); // le texte afficher en fonction de l'avancer de l'histoire et du lieu

      coordTexte.y += 44;



      ecrireEnPosition(coordTexte, 'parler au jarl');
      coordTexte.y += 1;
      ecrireEnPosition(coordTexte, 'parler au chambellan');
      coordTexte.y += 1;
      ecrireEnPosition(coordTexte, 'frapper le jarl');
      coordTexte.y += 1;
      ecrireEnPosition(coordTexte, 'sortir de fort dragon');

      choixMouvement(choix, 4);
      effacerEcran();
      case choix of
        50 : parlerJarl(joueur);
        51 : parlerChambellan(joueur);
        52 : frapperJarl(joueur);
        53 : quartierDesNuees(joueur);
        17 : Inventaire(joueur);
        18 : begin
            save(joueur);
            fortDragon(joueur);
            end;
      end
    end;

  end;

  procedure quartierDesNuees(var joueur : perso);
var
    coordTexte : coordonnees;
    dialogue : String;
    choix : Integer;

  begin

    joueur.lieu := 'quartierDesNuees';
    effacerEcran();
    menuHistoire(joueur);

    coordTexte.x := 31;
    coordTexte.y := 6;

    formatTexteFile('quartierDesNuees', coordTexte); // le texte afficher en fonction de l'avancer de l'histoire

    coordTexte.y += 44;

    ecrireEnPosition(coordTexte, 'rentrer dans fort dragon');
    coordTexte.y += 1;
    ecrireEnPosition(coordTexte, 'descendre dans le quartier du vent');

     choixMouvement(choix, 2);
     effacerEcran();
    case choix of
      50 : fortDragon(joueur);
      51 : quartierDuVent(joueur);
      17 : Inventaire(joueur);
      18 : begin
            save(joueur);
            quartierDesNuees(joueur);
            end;
    end;

  end;

  procedure quartierDuVent(var joueur : perso);
var
    coordTexte : coordonnees;
    dialogue : String;
    choix : Integer;


  begin


    joueur.lieu := 'quartierDuVent';
    effacerEcran();
    menuHistoire(joueur);

    coordTexte.x := 31;
    coordTexte.y := 6;

    formatTexteFile('quartierDuVent', coordTexte); // le texte afficher en fonction de l'avancer de l'histoire

    coordTexte.y += 44;


    ecrireEnPosition(coordTexte, 'Monter dans le quartier des Nuees');
    coordTexte.y += 1;
    ecrireEnPosition(coordTexte, 'aller dans le quartier des Plaines');

    choixMouvement(choix, 2);
    effacerEcran();
    case choix of
      50 : quartierDesNuees(joueur);
      51 : quartierDesPlaines(joueur);
      17 : Inventaire(joueur);
      18 : begin
            save(joueur);
            quartierDuVent(joueur);
            end;
    end
    
  end;

  procedure quartierDesPlaines(var joueur : perso);
    var
    coordTexte : coordonnees;
    dialogue : String;
    choix : Integer;

  begin


    joueur.lieu := 'quartierDesPlaines';
    effacerEcran();
    menuHistoire(joueur);

    coordTexte.x := 31;
    coordTexte.y := 6;

    formatTexteFile('quartierDesPlaines', coordTexte); // le texte afficher en fonction de l'avancer de l'histoire

    coordTexte.y += 44;

    choix := 0;

    ecrireEnPosition(coordTexte, 'aller dans le quartier du Vent');
    coordTexte.y += 1;
    ecrireEnPosition(coordTexte, 'entrer chez la jument pavoisé');
    coordTexte.y += 1;
    ecrireEnPosition(coordTexte, 'aller vers le baraquement des gardes');

    choixMouvement(choix, 3);
    effacerEcran();
    case choix of
      50 : quartierDuVent(joueur);
      51 : auberge(joueur);
      52 : MainGates(joueur);
      17 : Inventaire(joueur);
      18 : begin
            save(joueur);
            quartierDesPlaines(joueur);
            end;
    end
  end;

  procedure MainGates(var joueur : perso);
    var
    coordTexte : coordonnees;
    dialogue : String;
    choix, i : Integer;
    isHabille : Boolean;

  begin

    isHabille := false;
    i := 1;
    coordTexte.x := 31;
    coordTexte.y := 6;
    choix := 0;

    joueur.lieu := 'MainGates'; 
    effacerEcran();
    menuHistoire(joueur);

    formatTexteFile('MainGates', coordTexte); // le texte afficher en fonction de l'avancer de l'histoire


    for i := 1 to 6 do
    begin
      if joueur.equipement.armureTeteEquipe <> 1 then
      begin
        isHabille := true   
      end; 
    end;

    coordTexte.x := 31;
    coordTexte.y := 11;

    if isHabille = false then
      formatTexteFile('nudiste', coordTexte);

    coordTexte.x := 31;
    coordTexte.y := 6;

    coordTexte.y += 44;

    ecrireEnPosition(coordTexte, 'sortir de blancherive');
    coordTexte.y += 1;
    ecrireEnPosition(coordTexte, 'entrer chez la guerriere');
    coordTexte.y += 1;
    ecrireEnPosition(coordTexte, 'aller dans quartier des plaines');
    
    choixMouvement(choix, 3);
    effacerEcran();
    case choix of
      50 : campagne(joueur);
      51 : magasin(joueur);
      52 : quartierDesPlaines(joueur);
      17 : Inventaire(joueur);
      18 : begin
            save(joueur);
            MainGates(joueur);
            end;
    end

  end;

  procedure campagne(var joueur : perso);
    var
    coordTexte : coordonnees;
    dialogue : String;
    nbrQuetes : Integer;
    choix : Integer;
    mechant : ennemie;

  begin

      mechant.nom := '';
      mechant.vie := 100;


      joueur.lieu := 'campagne';
      effacerEcran();
      menuHistoire(joueur);

      coordTexte.x := 31;
      coordTexte.y := 6;

      choix := 0;


      //formatTexteFile() // le texte afficher en fonction de l'avancer de l'histoire

      coordTexte.y += 44;

      ecrireEnPosition(coordTexte, 'retourner dans blancherive');
      coordTexte.y += 1;
      ecrireEnPosition(coordTexte, 'Attaquer un camp de monstre');
      
    choixMouvement(choix, 2);
    effacerEcran();
    case choix of
      50 : MainGates(joueur);
      51 : begin
            if joueur.quete = 0 then
            begin
              mechant.nom := 'Dovahbear';
              mechant.vie := 10;
              gestionCombatPerso(joueur, mechant);
              if mechant.vie <= 0 then
              begin
                joueur.quete += 1;
                campagne(joueur);
              end
            end
            else
            begin
              gestionCombat(joueur, mechant);
              campagne(joueur);
            end;
          end;
      17 : Inventaire(joueur);
      18 : begin
            save(joueur);
            campagne(joueur);
            end;
    end;

  end;

  procedure parlerJarl(joueur : perso);
  var
    coordTexte: coordonnees;
  begin
    coordTexte.x := 31;
    coordTexte.y := 6;

    formatTexteFile('jarl', coordTexte);
    readln();

    fortDragon(joueur);

  end;

  procedure parlerChambellan(joueur : perso);
  var
    coordTexte: coordonnees;
  begin
    coordTexte.x := 31;
    coordTexte.y := 6;

    // formatTexteFile('chambellan' + nbrQuetes);
    formatTexteFile('chambellan0', coordTexte);
    readln();

    fortDragon(joueur);

  end;


	procedure choixMouvement(var choix : Integer; choixMax : Integer);
	var
    K : TKeyEvent;
    choixAction, choixMenu : Integer;
    coord, coordSelecteur : coordonnees;

  begin

    choixAction := 0;
    choixMenu := 0;

    coord.x := 0;
    coord.y := 0;

    coordSelecteur.x := 30;
    coordSelecteur.y := 50;

    selecteur(coordSelecteur, 0);

    InitKeyBoard;

    Repeat
      // on recupere un evenement du clavier
        K:=GetKeyEvent;
        K:=TranslateKeyEvent(K);
        //si le code correspond à un evenement

        //up 65313, down 65319, left 65315, right 65317
        Case GetKeyEventCode(K) of
          65313 : up(choixAction, coord, 3);
          65319 : down(choixAction, coord, -2);
          65315 : left(choixMenu, coord, -2);
          65317 : right(choixMenu, coord, 3)
        end;


        if (choixAction = -1) and (coordSelecteur.y > 50) and (coordSelecteur.x = 30) then
          begin
            selecteur(coordSelecteur, -1);
        end
        else if (choixAction = 1) and (coordSelecteur.y < 50 + choixMax - 1) and (coordSelecteur.x = 30) then
        begin
          selecteur(coordSelecteur, 1)
        end;

        if (choixAction = -1) and (coordSelecteur.y > 17) and (coordSelecteur.x = 1) then
          begin
            selecteur(coordSelecteur, -1);
        end
        else if (choixAction = 1) and (coordSelecteur.y < 18) and (coordSelecteur.x = 1) then
        begin
          selecteur(coordSelecteur, 1)
        end;

        if (choixMenu = -1) and (coordSelecteur.x = 30) then
          begin
            ecrireEnPosition(coordSelecteur, ' ');
            coordSelecteur.x := 1;
            coordSelecteur.y := 17;
            selecteur(coordSelecteur, 0);
        end
        else if (choixMenu = 1) and  (coordSelecteur.x = 1) then
        begin
          ecrireEnPosition(coordSelecteur, ' ');
          coordSelecteur.x := 30;
          coordSelecteur.y := 50;
          selecteur(coordSelecteur, 0)
        end;

        choixAction := 0;
        choixMenu := 0;

        choix := coordSelecteur.y;



    Until (GetKeyEventCode(K) = 7181);

    DoneKeyBoard;

  end;

  procedure Inventaire(joueur : perso);
  var
     coordArme : coordonnees;
    i, choix, nbItem: Integer;
  begin

    nbItem := 0;
    choix := 0;
    coordArme.x := 40;
    coordArme.y := 30;

    effacerEcran();

    while choix <> 26 do
    begin
      // effacerEcran();
      nbItem := 0;

      affichageInventaire(joueur, nbItem);
      nbItem += 1;

      ecrireEnPosition(coordArme, 'Quelle arme ou armure voulez vous equipez ? : ');
      readln(choix);


      effacerEcran();

      if choix in [nbItem..25] then
      begin
        ecrireEnPosition(coordArme, 'Vous êtes allez trop loin dans votre sac');
        sleep(1500);
      end
      else if choix <> 26 then
      begin
          gestionInventaire(joueur, choix);
          writeln(joueur.inventaire[choix, 4], ' equipé');
      end;


    end;

    case joueur.lieu of
        'fortDragon' : fortDragon(joueur);
        'quartierDesNuees' : quartierDesNuees(joueur);
        'quartierDuVent' : quartierDuVent(joueur);
        'quartierDesPlaines' : quartierDesPlaines(joueur);
        'MainGates' : MainGates(joueur);
        'campagne' : campagne(joueur);
    end;

  end;

  procedure frapperJarl(var joueur : perso);
  var
    variableName: Integer;
    leJarl : ennemie;
  begin
    leJarl.vie := 200;
    leJarl.nom := 'le Jarl';
    gestionCombatPerso(joueur, leJarl);

    case joueur.lieu of
      'fortDragon' : fortDragon(joueur);
      'quartierDesNuees' : quartierDesNuees(joueur);
      'quartierDuVent' : quartierDuVent(joueur);
      'quartierDesPlaines' : quartierDesPlaines(joueur);
      'MainGates' : MainGates(joueur);
      'campagne' : campagne(joueur);
    end;
    
  end;





  procedure magasin(var joueur : perso);
    var
      coordItem: coordonnees;
      choix : String;

  begin

    choix := '';
    coordItem.x := 60;
    coordItem.y := 6;

    ecrireEnPosition(coordItem, '1. Achat arme');
    coordItem.y += 2;
    ecrireEnPosition(coordItem, '2. Achat armure');
    coordItem.y += 2;
    ecrireEnPosition(coordItem, '3. Vendre');
    coordItem.y += 2;

    ecrireEnPosition(coordItem, 'votre choix : ');
    readln(choix);

    effacerEcran();

    case choix of
      '1': magasinArme(joueur);
      '2' : magasinArmure(joueur);
      '3' : magasinVente(joueur);
      '' : MainGates(joueur);
      else
      begin
        writeln('Votre choix n''est pas appropié, sortez !!');
        MainGates(joueur);
      end

    end;

  end;

  procedure magasinArme(var joueur : perso);
  type
    ratioprixArme=array[0..20] of real;
  const
       listMarchandage: ratioprixArme=(1,0.975,0.95,0.925,0.9,0.875,0.85,0.825,0.8,0.775,0.75,0.725,0.7,0.675,0.65,0.625,0.6,0.575,0.55,0.525,0.5);
  var
      coordItem: coordonnees;
      choix : Integer;
      listPrix : prix = (10, 10, 15, 12, 20, 20, 25, 23, 500, 556, 666, 550);
      listArme : array[1..12] of item = (
                                          ('1', '1', '1', 'épée en fer'),
                                          ('1', '1', '2', 'masse en fer'),
                                          ('1', '1', '3', 'hache en fer'),
                                          ('1', '1', '4', 'épée a deux main en fer'),

                                          ('1', '2', '1', 'épée en acier'),
                                          ('1', '2', '2', 'masse en acier'),
                                          ('1', '2', '3', 'hache en acier'),
                                          ('1', '2', '4', 'épée a deux mains en acier'),

                                          ('1', '3', '1', 'épée en griffe de dovahbear'),
                                          ('1', '3', '2', 'masse en griffe de dovahbear'),
                                          ('1', '3', '3', 'hache en griffe de dovahbear'),
                                          ('1', '3', '4', 'épée a deux main en griffe de dovahbear')

                                          );

  begin

    choix := 0;
    coordItem.x := 31;
    coordItem.y := 7;


    formatTexteFile('arme', coordItem);
    marchandage(listPrix, joueur, arme);
    affichePrix(listArme, listPrix);

    coordItem.x := 31;
    coordItem.y := 25;

    ecrireEnPosition(coordItem, 'votre choix : ');
    readln(choix);

    effacerEcran();

    case choix of
      1 : writeln('épée en fer');
      2 : writeln('masse en fer');
      3 : writeln('hache en fer');
      4 : writeln('épée à deu main en fer');

      5 : writeln('épée en acier');
      6 : writeln('masse en acier');
      7 : writeln('hache en acier');
      8 : writeln('épée à deux main en acier');

      9 : writeln('épée en griffe de DovahBear');
      10 : writeln('masse en griffe de DovahBear');
      11 : writeln('hache en griffe de DovahBear');
      12 : writeln('épée à deux main en griffe de DovahBear');
      13: magasinArmure(joueur);
      14: MainGates(joueur);

      else
      begin
        writeln('le choix demandé n''est pas possible, pour t''aider il y a des chiffres');
        magasin(joueur);
      end;
    end;

    
    if joueur.monnaie >= listPrix[choix] then
    begin
      joueur.monnaie -= listPrix[choix];
      gestionInventaireAjout(joueur, listArme[choix]);
      if listMarchandage[joueur.marchandArme]<length(listMarchandage) then
      begin
        joueur.marchandArme:=joueur.marchandArme+1;
      end
      else
        joueur.marchandArme:=joueur.marchandArme;
    end
    else
      writeln('vous n''avez pas assez d''argent, or joueur : ' + intToStr(joueur.monnaie));

    magasinArme(joueur);

  end;

    procedure magasinArmure(var joueur : perso);
    type
        ratioprixArmure=array[0..20] of real;
    const
      listMarchandage: ratioprixArmure=(1,0.975,0.95,0.925,0.9,0.875,0.85,0.825,0.8,0.775,0.75,0.725,0.7,0.675,0.65,0.625,0.6,0.575,0.55,0.525,0.5);
    var
      coordItem: coordonnees;
      choix : Integer;
      listPrix : prix = (20, 30, 10, 34, 40, 50, 40, 23, 500, 556, 666, 550);
      listArmure : array[1..12] of item = (

                                          ('2', '1', '1', 'casque en fer'),
                                          ('2', '1', '2', 'plastron en fer'),
                                          ('2', '1', '3', 'gants en fer'),
                                          ('2', '1', '4', 'bottes en fer'),

                                          ('2', '2', '1', 'casque en acier'),
                                          ('2', '2', '2', 'plastron en acier'),
                                          ('2', '2', '3', 'gants en acier'),
                                          ('2', '2', '4', 'bottes en acier'),

                                          ('2', '3', '1', 'casque en griffes de dovahbear'),
                                          ('2', '3', '2', 'plastron en griffes de dovahbear'),
                                          ('2', '3', '3', 'gants en griffes de dovahbear'),
                                          ('2', '3', '4', 'bottes en griffes de dovahbear')
                          );


    begin

      choix := 0;
      coordItem.x := 31;
      coordItem.y := 7;

      formatTexteFile('armure', coordItem);
      marchandage(listPrix, joueur, armure);
      affichePrix(listArmure, listPrix);

      coordItem.x := 31;
      coordItem.y := 29;

      ecrireEnPosition(coordItem, 'votre choix : ');
      readln(choix);

      effacerEcran();

    case choix of
      1 : writeln('casque en fer');
      2 : writeln('plastron en fer');
      3 : writeln('gants en fer');
      4 : writeln('bottes en fer');

      5 : writeln('casque en acier');
      6 : writeln('plastron en acier');
      7 : writeln('gants en acier');
      8 : writeln('bottes en acier');

      9 : writeln('casque en griffe de DovahBear');
      10 : writeln('plastron en griffe de DovahBear');
      11 : writeln('gants en griffe de DovahBear');
      12 : writeln('bottes en griffe de DovahBear');
      13: magasinArme(joueur);
      14: MainGates(joueur);

      else
        begin
        writeln('le choix demandé n''est pas possible, pour t''aider il y a des chiffres');
        magasin(joueur);
        end;
    end;

    if joueur.monnaie >= listPrix[choix] then
    begin
      joueur.monnaie -= listPrix[choix];
      gestionInventaireAjout(joueur, listArmure[choix]);

      if listMarchandage[joueur.marchandArmure]<length(listMarchandage) then
        joueur.marchandArmure:=joueur.marchandArmure+1
      else
        joueur.marchandArmure:=joueur.marchandArmure;
    end
    else
      writeln('vous n''avez pas assez d''argent, or joueur : ' + intToStr(joueur.monnaie));

    magasinArmure(joueur);


  end;

  procedure magasinVente(var joueur : perso);
  var
    choix, nbItem: Integer;
    coordArme : coordonnees;
  begin

    nbItem := 0;
    choix := 0;
    coordArme.x := 40;
    coordArme.y := 30;

    if joueur.Inventaire[1, 1] = '' then
    begin
      coordArme.y := 10;
      ecrireEnPosition(coordArme, 'Votre inventaire est vide ! Acheté un p''tit truc');
      sleep(2000);
      effacerEcran();
      magasin(joueur);
    end
    else
      while choix <> 26 do
        begin
          effacerEcran();
          nbItem := 0;

          affichageInventaire(joueur, nbItem);
          affichePrix(joueur);



          ecrireEnPosition(coordArme, 'Quelle arme ou armure voulez vous vendre ? : ');
          readln(choix);
          nbItem += 1;

          effacerEcran();

          if choix in [nbItem..25] then
          begin
            ecrireEnPosition(coordArme, 'Il n''y as pas autant de chose dans votre sac');
            sleep(1500);
          end
          else if choix <> 26 then
          gestionInventaireMagasinVente(joueur, choix);
            // gestionInventaire(joueur, choix);

        end;
    MainGates(joueur);
  end;

  procedure auberge(joueur : perso);
 var
   coordTexte : coordonnees;
   choix : Integer;
 begin


   joueur.lieu := 'Auberge';
   effacerEcran();
   menuHistoire(joueur);

   coordTexte.x := 31;
   coordTexte.y := 6;

   choix := 0;

   ecrireEnPosition(coordTexte,'Auberge'); // le texte afficher en fonction de l'avancer de l'histoire et du lieu

   coordTexte.y += 44;


   ecrireEnPosition(coordTexte, 'se reposer');
   coordTexte.y += 1;
   ecrireEnPosition(coordTexte, 'sortir');

   choixMouvement(choix, 2);
   effacerEcran();
   case choix of
     50 : repos(joueur);
     51 : quartierDesPlaines(joueur);
     17 : Inventaire(joueur);
   end

 end;            


  procedure repos(var joueur : perso);
  begin
    joueur.vie:=100;
    MainGates(joueur);
  end;





	
end.

