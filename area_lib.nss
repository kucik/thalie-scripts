
// Returns TRUE for exterior area, FALSE for interior
int GetIsAreaExterior(object oArea)
{
    int bReturn;
    int iWeatherBackup = GetWeather(oArea);
    SetWeather(oArea, 1);
    bReturn = GetWeather(oArea) == 1;
    SetWeather(oArea, iWeatherBackup);
    return bReturn;
}
