package cn.edu.hcnu.dao;
import cn.edu.hcnu.pojo.Student;
import com.github.pagehelper.PageInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

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

    //根据学号或姓名查询学生
    List<Student> queryStudentByNameAndSno(String vule);

    //查询全部学生
    List<Student> queryAllStudent();
}
