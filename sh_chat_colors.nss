// Set the text after this fuction to the color you specify.
// Numbers from (0-15)
//  (1,1,1)  =  Black
//  (15,15,1):= YELLOW
//  (15,5,1) := ORANGE
//  (15,1,1) := RED
//  (7,7,15) := BLUE
//  (1,15,1) := NEON GREEN
//  (1,11,1) := GREEN
//  (9,6,1)  := BROWN
//  (11,9,11):= LIGHT PURPLE
//  (12,10,7):= TAN
//  (8,1,8)  := PURPLE
//  (13,9,13):= PLUM
//  (1,7,7)  := TEAL
//  (1,15,15):= CYAN
//  (1,1,15) := BRIGHT BLUE
//  (0,0,0) or (15,15,15) = WHITE
string ColorTextRGB(int red = 15,int green = 15,int blue = 15);

string ColorTextRGB(int red = 15,int green = 15,int blue = 15)
{
    string sColor = GetLocalString(GetModule(),"ColorSet");
    if(red > 15) red = 15; if(green > 15) green = 15; if(blue > 15) blue = 15;

    return "<c" +
    GetSubString(sColor, red - 1, 1) +
    GetSubString(sColor, green - 1, 1) +
    GetSubString(sColor, blue - 1, 1) +">";

}

//setting the color of speech by volume
void ColorSet(string sSpoken)
{
    int iVolume = GetPCChatVolume();

    if(iVolume==TALKVOLUME_PARTY)
    {
        SetPCChatMessage(ColorTextRGB(15,1,1)+sSpoken);
    }
    if(iVolume==TALKVOLUME_WHISPER)
    {
        SetPCChatMessage(ColorTextRGB(15,15,15)+sSpoken);
    }
}