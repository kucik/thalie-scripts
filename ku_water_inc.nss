/*
switch(iType) {
    case 0: return ;
    case 1: return ;
    case 2: return ;
    case 3: return ;
    case 4: return ;
    case 5: return ;
    default: return ;
  }
*/

int ku_GetIsDrinkable(int iType) {
  switch(iType) {
    case 0: return FALSE; //Zadna voda
    case 1: return TRUE;  //Kasny fontany
    case 2: return FALSE; //morska
    case 3: return TRUE;  //otravena
    case 4: return TRUE;  //prirodni voda - povrch
    case 5: return TRUE;  //Prirdni voda podtemno
    default: return FALSE;
  }

  return FALSE;
}

int ku_FishWater(int iType) {
  switch(iType) {
    case 0: return 0; //Zadna voda
    case 1: return 0; //Kasny fontany
    case 2: return 2; //morska
    case 3: return 0; //otravena
    case 4: return 1; //prirodni voda - povrch
    case 5: return 1; //Prirdni voda podtemno
    default: return 0;
  }
  return 0;
}

int ku_GetIsSickWater(int iType) {
  switch(iType) {
    case 0: return FALSE; //Zadna voda
    case 1: return FALSE;  //Kasny fontany
    case 2: return FALSE; //morska
    case 3: return TRUE;  //otravena
    case 4: return FALSE;  //prirodni voda - povrch
    case 5: return FALSE;  //Prirdni voda podtemno
    default: return FALSE;
  }

  return FALSE;
}
