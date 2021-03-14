package cn.edu.hcnu.pojo;

/**
 * @Author CF
 * @create 2021/2/12 17:19
 */
public class Student {
    private String face;
    private String name;
    private String sex;
    private String sno;
    private String major;
    private String grade;
    private String s_college;
    private String phone;
    private String add_time;

    public Student(){

    }

    public Student(String face, String name, String sex, String sno, String major, String grade, String s_college, String phone, String add_time) {
        this.face = face;
        this.name = name;
        this.sex = sex;
        this.sno = sno;
        this.major = major;
        this.grade = grade;
        this.s_college = s_college;
        this.phone = phone;
        this.add_time = add_time;
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

    public String getS_college() {
        return s_college;
    }

    public void setS_college(String s_college) {
        this.s_college = s_college;
    }

    public String getFace() {
        return face;
    }

    public void setFace(String face) {
        this.face = face;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAdd_time() {
        return add_time;
    }

    public void setAdd_time(String add_time) {
        this.add_time = add_time;
    }

    @Override
    public String toString() {
        return "Student{" +
                "face='" + face + '\'' +
                ", name='" + name + '\'' +
                ", sex='" + sex + '\'' +
                ", sno='" + sno + '\'' +
                ", major='" + major + '\'' +
                ", grade='" + grade + '\'' +
                ", s_college='" + s_college + '\'' +
                ", phone='" + phone + '\'' +
                ", add_time='" + add_time + '\'' +
                '}';
    }
}
