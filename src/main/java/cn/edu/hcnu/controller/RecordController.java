package cn.edu.hcnu.controller;


import cn.edu.hcnu.pojo.FaceCapture;
import cn.edu.hcnu.service.FaceCaptureService;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import lombok.SneakyThrows;
import net.sf.json.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
* @author CF
* @Date 20:31 2021/3/7
*/

@Controller
@RequestMapping(value = "/record")
public class RecordController {

    /**
     * @author CF
     * @Description 控制层调用Student服务层
     * @Date 15:29 2021/2/27
     * @Param
     * @return
     */
    @Qualifier("faceCaptureService")
    private FaceCaptureService faceCaptureService;
    @Autowired
    public void setFaceCaptureService(FaceCaptureService faceCaptureService) {
        this.faceCaptureService = faceCaptureService;
    }

    /**
     * @author CF
     * @Description 获取用户查询的记录，保存在数据库
     * @Date 19:10 2021/3/7
     * @Param [faceCapture]
     * @return void
     */
    @SneakyThrows
    @RequestMapping(value = "/getQueryRecord")
    @ResponseBody
    public void getQueryRecord(FaceCapture faceCapture) {
        System.out.println(faceCapture.getQueryTime());
        faceCaptureService.saveRecord(faceCapture);
    }


}
