package cn.edu.hcnu.controller;


import cn.edu.hcnu.pojo.FaceCapture;
import cn.edu.hcnu.pojo.Student;
import cn.edu.hcnu.service.StudentService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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
    public PageInfo<Student> allStudent(@RequestParam(value = "page", required = false,defaultValue = "1") Integer page,
                                        @RequestParam(value = "size", required = false,defaultValue = "10") Integer pagesize) {

        System.out.println("allStudentPage:"+page);
        return studentService.queryAllStudent(page,12);
    }

    @SneakyThrows
    @RequestMapping("/SearchStudent")
    @ResponseBody
    public PageInfo<Student> SearchStudent(@RequestParam(value = "value",required = false) String value,
                                           @RequestParam(name = "page",required = false) Integer page,
                                           @RequestParam(value = "pagesize",required = false) Integer pagesize) {
        System.out.println("SearchStudentPage:"+page);
        System.out.println("value:"+value);
        return studentService.queryStudentByNameAndSno(page,10,value);
    }

    @RequestMapping("/queryStudent")
    @ResponseBody
    public String queryStudent(@RequestParam(value = "value",required = false) String value,
                                          @RequestParam(name = "page",required = false,defaultValue = "1") Integer page,
                                          @RequestParam(value = "pagesize",required = false,defaultValue = "10") Integer pagesize,Model model){
        PageInfo<Student> pageInfo =  studentService.queryStudent(page,10,value);
        model.addAttribute("pageInfo",pageInfo);
        model.addAttribute("mainRight", "/WEB-INF/jsp/mainRight2.jsp");
        return "main";
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
        request.setAttribute("mainRight", "/WEB-INF/jsp/detailsPage.jsp");
        request.getRequestDispatcher("/WEB-INF/jsp/main.jsp").forward(request, response);
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
    * @author CF
    * @Description 添加学生资料
    * @Date 15:12 2021/3/13
    * @Param [student]
    * @return void
    */
    @SneakyThrows
    @RequestMapping("/AddStudent")
    @ResponseBody
    public void AddStudent(Student student) {
        System.out.println(student);
        studentService.addStudent(student);

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


        //返回拼接好的串给页面接收
        return respContent;

    }

}
