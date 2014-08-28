

int GetWeaponSize(int iModel) {
  int iSize = StringToInt(Get2DAString("baseitems","WeaponSize",iModel));

  return iSize;
}
