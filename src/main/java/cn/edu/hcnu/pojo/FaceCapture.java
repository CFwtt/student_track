package cn.edu.hcnu.pojo;

/**
 * @Author CF
 * @create 2021/3/2 14:33
 */
public class FaceCapture{
    private String username;
    private String PersonId;
    private String Similary;
    private String CompareTime;
    private String FacePictureBase64;
    private String QueryTime;

    public FaceCapture() {
    }

    public FaceCapture(String username, String personId, String similary, String compareTime, String facePictureBase64, String queryTime) {
        this.username = username;
        PersonId = personId;
        Similary = similary;
        CompareTime = compareTime;
        FacePictureBase64 = facePictureBase64;
        QueryTime = queryTime;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPersonId() {
        return PersonId;
    }

    public void setPersonId(String personId) {
        PersonId = personId;
    }

    public String getSimilary() {
        return Similary;
    }

    public void setSimilary(String similary) {
        Similary = similary;
    }

    public String getCompareTime() {
        return CompareTime;
    }

    public void setCompareTime(String compareTime) {
        CompareTime = compareTime;
    }

    public String getFacePictureBase64() {
        return FacePictureBase64;
    }

    public void setFacePictureBase64(String facePictureBase64) {
        FacePictureBase64 = facePictureBase64;
    }

    public String getQueryTime() {
        return QueryTime;
    }

    public void setQueryTime(String queryTime) {
        QueryTime = queryTime;
    }
}
