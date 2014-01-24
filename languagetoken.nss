#include    "sh_classes_inc_e"
object oSpeaker =GetPCSpeaker();
object oCheck = GetSoulStone(oSpeaker);
int iLanguageSpeaker = GetLocalInt(oCheck,"Language");
object oTargetSpeak = GetLocalObject(oSpeaker, "dmfi_Lang_target");
string sNameTarget =  GetName(oTargetSpeak,FALSE);
void main()
{
string sLangSpeak;
if(iLanguageSpeaker == 0) sLangSpeak ="( Common )";
if(iLanguageSpeaker == 1) sLangSpeak ="( Abyssal )";
if(iLanguageSpeaker == 2) sLangSpeak ="( Aquan )";
if(iLanguageSpeaker == 3) sLangSpeak ="( Auran )";
if(iLanguageSpeaker == 4) sLangSpeak ="( Celestial )";
if(iLanguageSpeaker == 5) sLangSpeak ="( Draconic )";
if(iLanguageSpeaker == 6) sLangSpeak ="( Druidic )";
if(iLanguageSpeaker == 7) sLangSpeak =" ( Dwarven ): ";
if(iLanguageSpeaker == 8) sLangSpeak =" ( Elven ): ";
if(iLanguageSpeaker == 9) sLangSpeak =" ( Giant ): ";
if(iLanguageSpeaker == 10) sLangSpeak =" ( Gnome ): ";
if(iLanguageSpeaker == 11) sLangSpeak =" ( Goblin ): ";
if(iLanguageSpeaker == 12) sLangSpeak =" ( Gnoll ): ";
if(iLanguageSpeaker == 13) sLangSpeak =" ( Halfling ): ";
if(iLanguageSpeaker == 14) sLangSpeak =" ( Ignan ): ";
if(iLanguageSpeaker == 15) sLangSpeak =" ( Infernal ): ";
if(iLanguageSpeaker == 16) sLangSpeak =" ( Orc ): ";
if(iLanguageSpeaker == 17) sLangSpeak =" ( Sylvan ): ";
if(iLanguageSpeaker == 18) sLangSpeak =" ( Terran ): ";
if(iLanguageSpeaker == 19) sLangSpeak =" ( Undercommon ): ";
if(iLanguageSpeaker == 20) sLangSpeak =" ( Plant ): ";
if(iLanguageSpeaker == 21) sLangSpeak =" ( Animal ): ";

SetCustomToken(534,sLangSpeak);
SetCustomToken(535,sNameTarget);
}
