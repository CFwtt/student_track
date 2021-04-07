package cn.edu.hcnu.service;

import cn.edu.hcnu.dao.StudentMapper;
import cn.edu.hcnu.pojo.Student;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import java.util.List;

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

    @Override
    public int addStudent(Student student) {
        return studentMapper.addStudent(student);
    }

    @Override
    public int deleteStudent(String sno) {
        return 0;
    }

    @Override
    public int updateStudent(Student student) {
        return 0;
    }

    @Override
    public PageInfo<Student> queryStudentByNameAndSno(Integer page, Integer pagesize, String value) {
        PageHelper.startPage(page,pagesize);
        List<Student> list = studentMapper.queryStudentByNameAndSno(value);
        PageInfo<Student> pageInfo = new PageInfo<>(list);
        System.out.println(pageInfo);
        return pageInfo;
    }


    @Override
    public PageInfo<Student> queryAllStudent(Integer page, Integer size) {
        System.out.println("SearchStudentPage:"+page);
        PageHelper.startPage(page,size);
        List<Student> list = studentMapper.queryAllStudent();
        PageInfo<Student> pageInfo = new PageInfo<Student>(list);
        return pageInfo;
    }


    @Override
    public PageInfo<Student> queryStudent(Integer page, Integer pagesize, String value) {
        PageHelper.startPage(page,pagesize);
        List<Student> StudentList = studentMapper.queryStudent(value);
        PageInfo<Student> pageInfo = new PageInfo<>(StudentList);
        System.out.println(pageInfo);
        return pageInfo;
    }


}
