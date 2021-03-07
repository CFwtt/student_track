package cn.edu.hcnu.dao;

import cn.edu.hcnu.pojo.FaceCapture;
import cn.edu.hcnu.pojo.Student;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author CF
 * @create 2021/3/7 19:35
 */
public interface FaceCaptureRecordMapper {

    /**
    * @author CF
    * @Description 保存用户每次的查询记录
    * @Date 19:54 2021/3/7
    * @Param [faceCapture]
    * @return int
    */
    int saveRecord(FaceCapture faceCapture);

    /**
    * @author CF
    * @Description 查找用户的搜索记录
    * @Date 19:40 2021/3/7
    * @Param [username]
    * @return cn.edu.hcnu.pojo.FaceCapture
    */
    FaceCapture queryStudentByName(@Param("username") String username);
}
