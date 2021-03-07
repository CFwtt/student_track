package cn.edu.hcnu.service;
import cn.edu.hcnu.dao.FaceCaptureRecordMapper;
import cn.edu.hcnu.pojo.FaceCapture;
import cn.edu.hcnu.pojo.Student;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @Author CF
 * @create 2021/3/7 19:45
 */
public class FaceCaptureServiceImpl implements FaceCaptureService{

    @Autowired
    private FaceCaptureRecordMapper faceCaptureRecordMapper;
    public void setFaceCaptureRecordMapper(FaceCaptureRecordMapper faceCaptureRecordMapper){
        this.faceCaptureRecordMapper=faceCaptureRecordMapper;
    }

    public int saveRecord(FaceCapture faceCapture) {
        faceCaptureRecordMapper.saveRecord(faceCapture);
        return 0;
    }

    public FaceCapture queryStudentByName(String username) {
        return null;
    }
}
