public class GetImages {
    public static string getLink(String rt){
        String firstSubString = rt.substringBetween('<img', 'img>');
        
        String secondSubString = firstSubString.substringBetween('"', '"');

        return secondSubString;
    }
}