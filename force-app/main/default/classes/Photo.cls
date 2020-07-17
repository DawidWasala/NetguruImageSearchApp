public with sharing class Photo {
    
    public Integer albumId;
    public Integer id;
    public String title;
    public String url;
    public String thumbnailUrl;

    public static Photo[] parse(String json){
        return (Photo[]) System.JSON.deserialize(json, Photo[].class);
    }
}