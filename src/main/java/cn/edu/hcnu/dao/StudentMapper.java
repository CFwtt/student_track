package cn.edu.hcnu.dao;
import cn.edu.hcnu.pojo.Student;

import java.util.List;

/**
 * @Author CF
 * @create 2021/1/30 17:00
 */
public interface StudentMapper {
    //增加一本书
    int addStudent(Student student);

    //删除一位学生信息
    int deleteStudent(String sno);

    //编辑学生信息
    int updateStudent(Student student);

    //根据名字查询学生
    Student queryStudentByName(String Name);

    //查询全部学生
    List<Student> queryAllStudent();
}
