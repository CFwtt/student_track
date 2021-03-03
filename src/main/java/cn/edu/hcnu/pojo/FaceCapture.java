package cn.edu.hcnu.pojo;

/**
 * @Author CF
 * @create 2021/3/2 14:33
 */
public class FaceCapture{
    private String stuName;
    private String stuSno;
    private String capturePictures;
    private String nameList;
    private String captureTime;
    private String similarity;
    private String captureAmount;

    public FaceCapture() {
    }

    public FaceCapture(String stuName, String stuSno, String capturePictures, String nameList, String captureTime, String similarity, String captureAmount) {
        this.stuName = stuName;
        this.stuSno = stuSno;
        this.capturePictures = capturePictures;
        this.nameList = nameList;
        this.captureTime = captureTime;
        this.similarity = similarity;
        this.captureAmount = captureAmount;
    }

    public String getStuName() {
        return stuName;
    }

    public void setStuName(String stuName) {
        this.stuName = stuName;
    }

    public String getStuSno() {
        return stuSno;
    }

    public void setStuSno(String stuSno) {
        this.stuSno = stuSno;
    }

    public String getCapturePictures() {
        return capturePictures;
    }

    public void setCapturePictures(String capturePictures) {
        this.capturePictures = capturePictures;
    }

    public String getNameList() {
        return nameList;
    }

    public void setNameList(String nameList) {
        this.nameList = nameList;
    }

    public String getCaptureTime() {
        return captureTime;
    }

    public void setCaptureTime(String captureTime) {
        this.captureTime = captureTime;
    }

    public String getSimilarity() {
        return similarity;
    }

    public void setSimilarity(String similarity) {
        this.similarity = similarity;
    }

    public String getCaptureAmount() {
        return captureAmount;
    }

    public void setCaptureAmount(String captureAmount) {
        this.captureAmount = captureAmount;
    }
}
