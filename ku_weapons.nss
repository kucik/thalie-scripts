

int GetWeaponSize(int iModel) {
  int iSize = StringToInt(Get2daString("baseitems","WeaponSize",iModel));

  return iSize;
}
