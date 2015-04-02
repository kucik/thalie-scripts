/**
* Script pro zamčenou páku, nebo jiný placeable. Plc volá různý script podle toh, zda je či není odemčený.
*
* Proměnné:
*  LOCKED string - Script který se provede pokud hráč zatáhne za zamčenou páku. Obvykle žádný script nenastavovat.
*  UNLOCKED string - Script, který se má provést pokud hráč zatáhne za odemčenou páku.
*/

void main() {

  object oLever = OBJECT_SELF;
  string script;
  if(GetLocked(oLever)) {
    PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
    SpeakString("* Paka je zamcena a neni mozne s ni hnout *");
    string script = GetLocalString(oLever,"LOCKED");
    if(GetStringLength(script) > 0) {
      ExecuteScript(script, oLever);
    }
  }
  else {
    string script = GetLocalString(oLever,"UNLOCKED");
    PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    DelayCommand(2.0,PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    if(GetStringLength(script) > 0) {
      ExecuteScript(script, oLever);
    }
  }
}
