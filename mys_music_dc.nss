#include "nwnx_events"
#include "mys_music"

int StartingConditional()
{
    string sText = GetCurrentNodeText();
    object oPC = GetPCSpeaker();

    // *************************************************************************
    // Loutna
    // *************************************************************************

    if (sText == "2:12 Èerné oèi")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "2:38 Lehkost bytí")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "1:40 Loïka")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "1:24 Pohleï mi do oèí")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "1:38 Rukávy")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "2:05 S tebou, mùj milı")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "2:30 Galliard")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "1:37 Panenky u hrádku")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "1:12 Dorenskı hvozd")
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
    else if (sText == "2:19 Pod lesíkem na mlází")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "0:47 Falešnı Niegl")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "4:12 Pod stromy")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "1:25 Rozmarná")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "1:44 Ve stínu stromù kdysi")
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
    else if (sText == "1:55 Putování")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "1:05 Lesní tanec")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "3:55 Mandolína")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "1:16 Rozhodování")
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
    else if (sText == "5:08 Mistrovská")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "3:35 Terega")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }

    // *************************************************************************
    // Harfa
    // *************************************************************************

    else if (sText == "1:42 Zamyšlení")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "2:27 V Doubkovì na jaøe")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "1:52 Krásná Alienor")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "2:17 Kde jsem nechal oèi")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "3:02 V sedle")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "2:29 Na hrotu kopí")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "3:18 Vzpomínka na mrtvé hrdiny")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "2:51 Na tvıch køídlech")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "3:43 Kavalír a paní")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "3:20 Ranní ticho")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:50 Toulky")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "3:43 Pouta lásky")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "3:44 Kerridwen")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "3:43 Zaèarovanı les")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "3:40 Pøes slzy")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "3:00 Útoèištì")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "4:38 Sen harfeníka")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "1:34 Jen tak na smutek")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "1:41 Ztrácím tì")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "3:00 Maelly")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "1:15 Nikdy nejsem sám")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "2:21 Nemám jen jednu panenku")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "3:27 Triumfální pochod")
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
    else if (sText == "3:22 V zahradì Eraninì")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }

    // *************************************************************************
    // Píšala
    // *************************************************************************

    else if (sText == "1:23 Divokej tymián")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "2:00 Pohøeb krále")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "6:18 Nad lesem bambusu")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "2:33 Odpoèinek")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "2:17 Touha po nadìji")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "1:10 Noc na pláních")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "4:57 Ostrov volnosti")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:44 Flétna z bambusu")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "1:19 Medvìdí tanec")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:27 Poehnání")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "0:50 Louèení")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "1:18 Tam do kopcù")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "5:30 Sen Prianùv")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "1:27 Z vıšky ptákù")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "2:23 Øíèní tanec")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "1:27 Pod mìsícem")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "3:23 Alansujská vrchovina")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "3:13 Lapaè snù")
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
    else if (sText == "4:41 Chlapci od øeky")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "1:16 Duch plání")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }

    // *************************************************************************
    // Klavír
    // *************************************************************************

    else if (sText == "4:40 Soutìzkou")
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
    else if (sText == "3:40 Nìco zaèíná")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "1:35 Touha po nadìji")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "3:05 Paprsek")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "3:44 Støíbrnı ptáèek")
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
    else if (sText == "6:27 Píseò pro tebe")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:40 Pıcha")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:33 Domlouvání")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "4:29 U majáku")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "3:22 Tulák")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:55 Poslední den")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "1:54 Lucidovy sny")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "2:20 Snìní")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "4:38 Pøedehra")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "3:00 Vzpomínky")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "3:09 U Hrumburáce")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "1:56 Samota v horách")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "3:48 Moreùv zákon")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "4:10 Motılí sen")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "2:26 Šance")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "4:10 Nocturne")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "3:11 Pod hvìzdami")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "3:09 Návraty")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "4:27 Promenáda")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "3:39 Julietta")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "2:58 Poslení vıspa")
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
    else if (sText == "3:01 Obì zimì")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "3:30 Zimní krajina")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "3:07 Po vøesovišti")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "1:38 Georgiana")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "4:56 Mistrovská")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "2:00 Pomsta èarodìjky")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }

    // *************************************************************************
    // Kytara
    // *************************************************************************

    else if (sText == "1:35 Svítání")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "2:54 Ukolébavka")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "3:11 Albeniz")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "3:45 Zamyšlení")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "3:42 K pøíbìhùm vyhrávám")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "4:21 Domù")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "2:57 Jiní vítr")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "4:28 Koruna vìtru")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "3:06 Soledat")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "3:44 Vypravìè")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:26 Danilly tanèí")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:04 Dìtství")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:09 Pouštní skály")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "2:41 Soleas")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "2:46 Malá Rowena")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "2:21 Vìtvièka rozmarıny")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "5:06 Zatmìní mìsíce")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "3:55 Rodrigo")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "1:57 Rej svìtel")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "5:15 Pøed branami mìsta")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "3:46 Anjela")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "4:12 Pøekvapenı cikán")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "2:06 Ve tvıch oèích")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "3:03 Není dne bez noci")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "6:04 Déšt na støeše")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "2:05 Vyhrávám slavíkùm")
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
    else if (sText == "4:50 Kráska z pouštního mìsta")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "4:41 Serenáda")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "6:53 Majstrštik")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "1:15 Kolibøík")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    else if (sText == "3:36 První jízda")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }

    // *************************************************************************
    // Housle
    // *************************************************************************

    else if (sText == "3:26 Velké moøe")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "2:00 Veselı houslista")
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
    else if (sText == "0:37 Carolanùv sen")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "3:22 Srdce a dech")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "2:06 Dopis milému")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "2:36 Pláè nad Karathou")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "1:47 Náøek nad mrtvım")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "3:29 Ptáèek v Prahvozdu")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "3:53 alozpìv za hrabìte")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "4:09 Rudé kvìty")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "4:28 Golem a krejèovská panna")
    {
        return MusicGetMusicianPerformRank(oPC, 15);
    }
    else if (sText == "1:55 Zelené vršky")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "2:40 Èernı lotos")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "4:08 Sedmero moøí")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "2:51 O vìrném rytíøi Balianovi")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "2:33 Lacarantùv kšaft")
    {
        return MusicGetMusicianPerformRank(oPC, 30);
    }
    else if (sText == "0:43 Rytíøi kulatého sudu")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "1:50 Lareth")
    {
        return MusicGetMusicianPerformRank(oPC, 35);
    }
    
    // *************************************************************************
    // Housle
    // *************************************************************************

    else if (sText == "5:25 Buben")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "5:41 Pochod genasi")
    {
        return MusicGetMusicianPerformRank(oPC, 5);
    }
    else if (sText == "4:49 Hadí tanec")
    {
        return MusicGetMusicianPerformRank(oPC, 10);
    }
    else if (sText == "3:54 Píseò ohnì")
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
    else if (sText == "4:49 Øeè Prahvozdu")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "6:30 Píseò dìtí pramene")
    {
        return MusicGetMusicianPerformRank(oPC, 20);
    }
    else if (sText == "3:44 Deštì pouštì")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }
    else if (sText == "3:23 Rituální")
    {
        return MusicGetMusicianPerformRank(oPC, 25);
    }

    // *************************************************************************
    //
    // *************************************************************************

    return FALSE;
}
