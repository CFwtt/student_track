package cn.edu.hcnu.service;

import cn.edu.hcnu.pojo.Student;

import java.util.List;

/**
 * @Author CF
 * @create 2021/1/30 17:00
 */
public interface StudentService {
    //增加一个学生
    int addStudent(Student student);

    //删除一个学生
    int deleteStudent(String sno);

    //更新一个学生
    int updateStudent(Student student);

    //查询一个学生
    Student queryStudentBysno(String sno);

    //查询全部学生
    List<Student> queryAllStudent();
}
