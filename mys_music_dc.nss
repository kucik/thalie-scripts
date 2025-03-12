#include "nwnx_events"
#include "mys_music"

int StartingConditional()
{
    string sText = GetCurrentNodeText();
    object oPC = GetPCSpeaker();

    // *************************************************************************
    // Loutna
    // *************************************************************************

    if (sText == "2:12 �ern� o�i")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "2:38 Lehkost byt�")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "1:40 Lo�ka")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "1:24 Pohle� mi do o��")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "1:38 Ruk�vy")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "2:05 S tebou, m�j mil�")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "2:30 Galliard")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "1:37 Panenky u hr�dku")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "1:12 Dorensk� hvozd")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "1:44 Cavendish")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "1:29 Favaryt")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:19 Pod les�kem na ml�z�")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "0:47 Fale�n� Niegl")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "4:12 Pod stromy")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "1:25 Rozmarn�")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "1:44 Ve st�nu strom� kdysi")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "2:23 Allison Gross")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "1:05 Margali")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "1:55 Putov�n�")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "1:05 Lesn� tanec")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "3:55 Mandol�na")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "1:16 Rozhodov�n�")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "2:52 Gavotta")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "1:24 Patron")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "5:08 Mistrovsk�")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "3:35 Terega")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "5:20 And�l")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "1:26 V�ka")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "1:26 �ir� kraj")
    {
        return MusicGetMusicianPerformRank(oPC, 40);
    }
    else if (sText == "2:01 Dup�k")
    {
        return MusicGetMusicianPerformRank(oPC, 40);
    }
    else if (sText == "2:14 Lesn� milov�n�")
    {
        return MusicGetMusicianPerformRank(oPC, 40);
    }
    else if (sText == "3:57 Divok� j�zda")
    {
        return MusicGetMusicianPerformRank(oPC, 40);
    }
    else if (sText == "5:18 Souboj")
    {
        return MusicGetMusicianPerformRank(oPC, 45);
    }

    // *************************************************************************
    // Harfa
    // *************************************************************************

    else if (sText == "1:42 Zamy�len�")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "2:27 V Doubkov� na ja�e")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "1:52 Kr�sn� Alienor")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "2:17 Kde jsem nechal o�i")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "3:02 V sedle")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "2:29 Na hrotu kop�")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "3:18 Vzpom�nka na mrtv� hrdiny")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "2:51 Na tv�ch k��dlech")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "3:43 Kaval�r a pan�")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "3:20 Rann� ticho")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:50 Toulky")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "3:43 Pouta l�sky")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "3:44 Kerridwen")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "3:43 Za�arovan� les")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "3:40 P�es slzy")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "3:00 �to�i�t�")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "4:38 Sen harfen�ka")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "1:34 Jen tak na smutek")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "1:41 Ztr�c�m t�")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "3:00 Maelly")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "1:15 Nikdy nejsem s�m")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "2:21 Nem�m jen jednu panenku")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "3:27 Triumf�ln� pochod")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "3:28 K tanci")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "2:07 Petries a Atelheid")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "3:22 V zahrad� Eranin�")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }

    // *************************************************************************
    // P횝ala
    // *************************************************************************

    else if (sText == "1:23 Divokej tymi�n")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "2:00 Poh�eb kr�le")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "6:18 Nad lesem bambusu")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "2:33 Odpo�inek")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "2:17 Touha po nad�ji")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "1:10 Noc na pl�n�ch")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "4:57 Ostrov volnosti")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:44 Fl�tna z bambusu")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "1:19 Medv�d� tanec")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:27 Po�ehn�n�")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "0:50 Lou�en�")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "1:18 Tam do kopc�")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "5:30 Sen Prian�v")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "1:27 Z v��ky pt�k�")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "2:23 ���n� tanec")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "1:27 Pod m�s�cem")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "3:23 Alansujsk� vrchovina")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "3:13 Lapa� sn�")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "2:20 Josieho noc")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "2:05 V popelu")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "4:41 Chlapci od �eky")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "1:16 Duch pl�n�")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "2:38 Pramen Jaarig")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "2:16 Gn�msk� sko�n�")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "1:12 Past��sk� tanec")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "1:16 Dvorsk� tanec")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "2:11 Spi, m�j mil�, spi")
    {
        return MusicGetMusicianPerformRank(oPC, 40);
    }
    else if (sText == "4:02 Ivorsk� kozele�ek")
    {
        return MusicGetMusicianPerformRank(oPC, 40);
    }
    else if (sText == "2:00 Na vojnu se dej")
    {
        return MusicGetMusicianPerformRank(oPC, 40);
    }
    else if (sText == "2:09 Medv�d� �eka")
    {
        return MusicGetMusicianPerformRank(oPC, 45);
    }

    // *************************************************************************
    // Klav�r
    // *************************************************************************

    else if (sText == "4:40 Sout�zkou")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "4:21 Pod vrbou")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "2:33 Tallis Meyer")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "3:40 N�co za��n�")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "1:35 Touha po nad�ji")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "3:05 Paprsek")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "3:44 St��brn� pt��ek")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "2:23 Melancholie")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "5:09 Krystal")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "6:27 P�se� pro tebe")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:40 P�cha")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:33 Domlouv�n�")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "4:29 U maj�ku")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "3:22 Tul�k")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:55 Posledn� den")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "1:54 Lucidovy sny")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "2:20 Sn�n�")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "4:38 P�edehra")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "3:00 Vzpom�nky")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "3:09 U Hrumbur�ce")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "1:56 Samota v hor�ch")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "3:48 More�v z�kon")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "4:10 Mot�l� sen")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "2:26 �ance")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "4:10 Nocturne")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "3:11 Pod hv�zdami")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "3:09 N�vraty")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "4:27 Promen�da")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "3:39 Julietta")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "2:58 Poslen� v�spa")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "3:28 Improvizace")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "4:33 Balanc")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "3:01 Ob� zim�")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "3:30 Zimn� krajina")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "3:07 Po v�esovi�ti")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "1:38 Georgiana")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "4:56 Mistrovsk�")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "2:00 Pomsta �arod�jky")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }

    // *************************************************************************
    // Kytara
    // *************************************************************************

    else if (sText == "1:35 Sv�t�n�")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "2:54 Ukol�bavka")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "3:11 Albeniz")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "3:45 Zamy�len�")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "3:42 K p��b�h�m vyhr�v�m")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "4:21 Dom�")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "2:57 Ji�n� v�tr")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "4:28 Koruna v�tru")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "3:06 Soledat")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "3:44 Vyprav��")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:26 Danilly tan��")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:04 D�tstv�")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:09 Pou�tn� sk�ly")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "2:41 Soleas")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "2:46 Mal� Rowena")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "2:21 V�tvi�ka rozmar�ny")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "5:06 Zatm�n� m�s�ce")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "3:55 Rodrigo")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "1:57 Rej sv�tel")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "5:15 P�ed branami m�sta")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "3:46 Anjela")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "4:12 P�ekvapen� cik�n")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "2:06 Ve tv�ch o��ch")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "3:03 Nen� dne bez noci")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "6:04 D�t na st�e�e")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "2:05 Vyhr�v�m slav�k�m")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "4:23 Signorie")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "7:36 Corrientes")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "3:02 Do rytmu")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "4:26 Tanec jara")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "4:50 Kr�ska z pou�tn�ho m�sta")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "4:41 Seren�da")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "6:53 Majstr�tik")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "1:15 Kolib��k")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "3:36 Prvn� j�zda")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "3:26 St�echa sv�ta")
    {
        return MusicGetMusicianPerformRank(oPC, 40);
    }
    else if (sText == "4:04 Zlat� drak")
    {
        return MusicGetMusicianPerformRank(oPC, 40);
    }
    else if (sText == "2:30 Z�pad slunce")
    {
        return MusicGetMusicianPerformRank(oPC, 40);
    }
    else if (sText == "2:29 S v�trem v z�dech")
    {
        return MusicGetMusicianPerformRank(oPC, 40);
    }
    else if (sText == "4:29 Rej masek")
    {
        return MusicGetMusicianPerformRank(oPC, 40);
    }
    else if (sText == "2:33 Na lovu")
    {
        return MusicGetMusicianPerformRank(oPC, 45);
    }

    // *************************************************************************
    // Housle
    // *************************************************************************

    else if (sText == "3:26 Velk� mo�e")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "2:00 Vesel� houslista")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "1:16 Pod horami")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "3:20 Prach a popel")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "0:37 Carolan�v sen")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "3:22 Srdce a dech")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:06 Dopis mil�mu")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "2:36 Pl�� nad Karathou")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "1:47 N��ek nad mrtv�m")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "3:29 Pt��ek v Prahvozdu")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "3:53 �alozp�v za hrab�te")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "4:09 Rud� kv�ty")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "4:28 Golem a krej�ovsk� panna")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "1:55 Zelen� vr�ky")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "2:40 �ern� lotos")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "4:08 Sedmero mo��")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "2:51 O v�rn�m ryt��i Balianovi")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "2:33 Lacarant�v k�aft")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "0:43 Ryt��i kulat�ho sudu")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "1:50 Lareth")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }

    // *************************************************************************
    // Buben
    // *************************************************************************

    else if (sText == "5:25 Buben")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "5:41 Pochod genasi")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "4:49 Had� tanec")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "3:54 P�se� ohn�")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "4:50 Lov")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "6:32 Let orla")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "4:49 �e� Prahvozdu")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "5:26 P�se� d�t� pramene")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "3:44 De�t� pou�t�")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "3:23 Ritu�ln�")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "2:16 Zbrojn� tanec")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "3:20 Karathsky kozele�ek")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "0:51 Vojensk� pochod 1")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "0:53 P�ehl�dka")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "0:46 V��en�")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "0:39 V��en� 2")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "1:15 Vojensk� pochod 2")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "Thalie - Boj 01")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Boj 02")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Boj 03")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Boj 04")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Boj 05")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Boj 06")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Boj 07")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Boj 08")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Boj 09")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Boj 10")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Boj 11")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - P�epad 01")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - P�epad 02")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Darkmere")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Nap�t� 01")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Nap�t� 02")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Nap�t� 03")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Nap�t� 04")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Nap�t� 05")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Nap�t� 06")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Nap�t� 07")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Pochod 01")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Pochod 02")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Pochod 03")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Pochod 04")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Pochod 05")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Pochod 06")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Pochod 07")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Pochod 08")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Pochod 09")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Pochod 10")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Pochod 11")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Cesta 01")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Na mo�i 01")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Proces� 01")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Prohra 01")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Prohra 02")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Prohra 03")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - V�hra 01")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - V�hra 02")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - Epic")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - P�sky 01")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - P�sky 02")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - P�sky 03")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - P�sky 04")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - P�sky 05")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }
    else if (sText == "Thalie - P�sky 06")
    {
        return MusicGetMusicianPerformRank(oPC, 120);
    }

    // *************************************************************************
    //
    // *************************************************************************

    return FALSE;
}
