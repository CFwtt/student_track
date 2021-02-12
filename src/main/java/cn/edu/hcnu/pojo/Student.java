package cn.edu.hcnu.pojo;

/**
 * @Author CF
 * @create 2021/2/12 17:19
 */
public class Student {
    private String name;
    private String sex;
    private String sno;
    private String major;
    private String grade;
    private String stu_cell;
    private String parent_cell;

    public Student(){

    }

    public Student(String name, String sex, String sno, String major, String grade, String stu_cell, String parent_cell) {
        this.name = name;
        this.sex = sex;
        this.sno = sno;
        this.major = major;
        this.grade = grade;
        this.stu_cell = stu_cell;
        this.parent_cell = parent_cell;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getSno() {
        return sno;
    }

    public void setSno(String sno) {
        this.sno = sno;
    }

    public String getMajor() {
        return major;
    }

    public void setMajor(String major) {
        this.major = major;
    }

    public String getGrade() {
        return grade;
    }

    public void setGrade(String grade) {
        this.grade = grade;
    }

    public String getStu_cell() {
        return stu_cell;
    }

    public void setStu_cell(String stu_cell) {
        this.stu_cell = stu_cell;
    }

    public String getParent_cell() {
        return parent_cell;
    }

    public void setParent_cell(String parent_cell) {
        this.parent_cell = parent_cell;
    }
}
