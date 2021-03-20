package cn.edu.hcnu.service;

import cn.edu.hcnu.dao.StudentMapper;
import cn.edu.hcnu.pojo.Student;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Map;

/**
 * @Author CF
 * @create 2021/1/30 17:31
 */

public class StudentServiceImpl implements StudentService {

    @Autowired
    private StudentMapper studentMapper;
    public void setStudentMapper(StudentMapper studentMapper){
        this.studentMapper=studentMapper;
    }

    public int addStudent(Student student) {
        return studentMapper.addStudent(student);
    }

    public int deleteStudent(String sno) {
        return 0;
    }

    public int updateStudent(Student student) {
        return 0;
    }

    public PageInfo<Student> queryStudentByNameAndSno(int page, int pagesize,String value) {
        PageHelper.startPage(page,pagesize);
        System.out.println("page:"+page+" pagesize:"+pagesize+" value:"+value);
        List<Student> list = studentMapper.queryStudentByNameAndSno(value);
        PageInfo<Student> pageInfo = new PageInfo<Student>(list);
        return pageInfo;
    }


    public PageInfo<Student> queryAllStudent(int page, int pagesize) {
        PageHelper.startPage(page,pagesize);
        List<Student> list = studentMapper.queryAllStudent();
        PageInfo<Student> pageInfo = new PageInfo<Student>(list);
        return pageInfo;
    }
}
