void ZrusTeleport(object paka)
{
    int i;
    for (i=1 ; i<=5;i++)
    {
        SetLocalString(paka,"dkvn_CryptPod1_MagPort"+IntToString(i),"dkvn_CryptPod1_MagPort"+IntToString(i));
    }
}

void main()
{
    string paka_tag = "dkvn_CryptPod1_NaPortaly";
    object paka = OBJECT_SELF;
    int boss = Random(5)+1;
    int i;
    for (i=1 ; i<=5;i++)
    {
       if (i == boss)
       {
            SetLocalString(paka,"dkvn_CryptPod1_MagPort"+IntToString(i),"dkvn_CryptPod3_MagPortBoss");
       }
       else
       {
           int random = Random(5)+1;
           SetLocalString(paka,"dkvn_CryptPod1_MagPort"+IntToString(i),"dkvn_CryptPod1_MagPort"+IntToString(random)) ;
       }




    }


    DelayCommand(5400.0,ZrusTeleport(paka));

}
