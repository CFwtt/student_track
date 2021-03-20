package cn.edu.hcnu.service;

import cn.edu.hcnu.pojo.Student;
import com.github.pagehelper.PageInfo;

import java.util.Map;

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
    PageInfo<Student> queryStudentByNameAndSno(int page, int pagesize,String value);

    //查询全部学生
    PageInfo<Student> queryAllStudent(int page, int pagesize);

}
