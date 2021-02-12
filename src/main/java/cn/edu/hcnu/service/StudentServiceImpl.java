package cn.edu.hcnu.service;

import cn.edu.hcnu.dao.StudentMapper;
import cn.edu.hcnu.pojo.Books;
import cn.edu.hcnu.pojo.Student;

import java.util.List;

/**
 * @Author CF
 * @create 2021/1/30 17:31
 */
public class StudentServiceImpl implements StudentService {

    private StudentMapper studentMapper;


    public int addStudent(Student student) {
        return 0;
    }

    public int deleteStudent(String sno) {
        return 0;
    }

    public int updateStudent(Student student) {
        return 0;
    }

    public Books queryStudentBysno(String sno) {
        return null;
    }

    public List<Student> queryAllStudnet() {
        return null;
    }
}
