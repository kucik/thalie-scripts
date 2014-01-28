//no_love_q_rictco
//skript by mel rict co shani, ci rict,ze  obchodnik nic neshani

//#include "no_love_q_inc"

void main()
{
  if(GetLocalInt(OBJECT_SELF,"lovec_q_qid") > 0) {
    string sName = GetLocalString(OBJECT_SELF,"lovec_q_qname");
    SpeakString(" Mas stesti prave je lovecke obdobi. V tomto obdobi se lovi  " +  sName + " . Kdyz mi prineses dukaz o smrti teto nestvury, tak ti za nej vyplatim ctyrnasobnou odmenu, nez by ti dal kdokoliv jiny. " );
  }
  else {
    SpeakString(" Momentalne neni vypsana odmena na zadnou nestvuru. ");

  }

}
