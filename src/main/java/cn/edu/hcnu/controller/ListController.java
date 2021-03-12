package cn.edu.hcnu.controller;


import cn.edu.hcnu.pojo.FaceCapture;
import cn.edu.hcnu.pojo.Student;
import cn.edu.hcnu.service.StudentService;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import lombok.SneakyThrows;
import net.sf.json.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping(value = "/list")
public class ListController {

    /**
     * @author CF
     * @Description 控制层调用Student服务层
     * @Date 15:29 2021/2/27
     * @Param
     * @return
     */
    @Qualifier("studentServiceImpl")
    private StudentService studentService;
    @Autowired
    public void setStudentService(StudentService studentService) {
        this.studentService = studentService;
    }

    /**
     * @return java.lang.String
     * @author CF
     * @Description 跳转到登录成功后的页面, 用ajax发送请求到此控制器，拉取全部学生信息
     * @Date 13:52 2021/2/25
     * @Param [model]
     */
    @RequestMapping(value = "/allStudent")
    @ResponseBody
    public List<Student> toComparison() {
        List<Student> students = studentService.queryAllStudent();
        System.out.println(students);
        return students;
    }


    /**
     * @return java.lang.String
     * @author CF
     * @Description 跳转到根据时间段、ID查询的人脸对比记录页面
     * @Date 17:38 2021/2/15
     * @Param [sno, model]
     */
    @SneakyThrows
    @RequestMapping(value = "/toDetails")
    @ResponseBody
    public void selectUser(HttpServletRequest request, HttpServletResponse response,
                           @RequestParam(value = "startDate", required = false) String startDate,
                           @RequestParam(value = "endDate", required = false) String endDate,
                           @RequestParam(value = "sno",required = false) String sno) {
        request.setAttribute("startDate", startDate);
        request.setAttribute("endDate", endDate);
        request.setAttribute("sno", sno);
        System.out.println("startDate:"+startDate+" endDate:"+endDate+" sno:"+ sno);
        request.setAttribute("mainright", "/WEB-INF/jsp/detailsPage.jsp");
        request.getRequestDispatcher("/WEB-INF/jsp/mainTest.jsp").forward(request, response);
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
        System.out.println(faceCapture.getUsername());
    }


    /**
     * @return java.lang.String
     * @author CF
     * @Description 跳转到添加页面
     * @Date 17:40 2021/2/15
     * @Param []
     */
    @RequestMapping("/toAddStudeent")
    public String toAddPaPer() {
        return "addStudent";
    }


    /**
     * @return java.lang.String
     * @author CF
     * @Description 用中间代理服务器，解决跨域
     * @Date 19:01 2021/2/5
     * @Param [json]
     */
    @RequestMapping(value = "/testJson1", produces = "text/html;application/json;charset=UTF-8")
    @ResponseBody
    public String httpPostWithJSON(@RequestBody JSONObject json) throws Exception {

        HttpPost httpPost = new HttpPost("http://192.168.0.31:8011");
        CloseableHttpClient client = HttpClients.createDefault();
        String respContent = null;
        //System.out.println("传入中间代理服务器的JSON：" + json);

        StringEntity entity = new StringEntity(json.toString(), "utf-8");//解决中文乱码问题
        entity.setContentEncoding("UTF-8");
        entity.setContentType("application/json");
        httpPost.setEntity(entity);

        HttpResponse resp = client.execute(httpPost);
        if (resp.getStatusLine().getStatusCode() == 200) {
            HttpEntity he = resp.getEntity();
            respContent = EntityUtils.toString(he, "UTF-8");
        }

        //获取从前端传入的json中的ChannelNo字段（因为盒子返回的json无此字段，页面需要此字段作为“抓拍场所”字段）
        String Data = json.get("Data").toString();

        JsonParser jp = new JsonParser();
        //将json字符串转化成json对象
        JsonObject jo = jp.parse(respContent).getAsJsonObject();

        //截取频道字段，放入盒子返回的json串中
        String ChannelNo = Data.substring(1, 15);
        String str = respContent;
        StringBuilder sb = new StringBuilder(str);

        //在指定的位置1，插入指定的字符串
        sb.insert(1, ChannelNo);
        str = sb.toString();

        //返回拼接好的串给页面接收
        return str;

    }


}
