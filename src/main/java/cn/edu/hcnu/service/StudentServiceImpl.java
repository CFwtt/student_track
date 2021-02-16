package cn.edu.hcnu.service;

import cn.edu.hcnu.dao.StudentMapper;
import cn.edu.hcnu.pojo.Student;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author CF
 * @create 2021/1/30 17:31
 */
@Service
public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentMapper studentMapper;
    public void setStudentMapper(StudentMapper studentMapper){
        this.studentMapper=studentMapper;
    }

    public int addStudent(Student student) {
        return 0;
    }

    public int deleteStudent(String sno) {
        return 0;
    }

    public int updateStudent(Student student) {
        return 0;
    }

    public Student queryStudentBysno(String sno) {
        return null;
    }

    public List<Student> queryAllStudnet() {
        return null;
    }

}
