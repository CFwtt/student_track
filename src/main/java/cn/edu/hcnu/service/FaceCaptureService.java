package cn.edu.hcnu.service;

import cn.edu.hcnu.pojo.FaceCapture;
import cn.edu.hcnu.pojo.Student;
import org.apache.ibatis.annotations.Param;

/**
 * @Author CF
 * @create 2021/3/7 19:44
 */
public interface FaceCaptureService {

    int saveRecord(FaceCapture faceCapture);

    FaceCapture queryStudentByName(String username);
}
