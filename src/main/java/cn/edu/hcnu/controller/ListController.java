package cn.edu.hcnu.controller;


import cn.edu.hcnu.pojo.Student;
import cn.edu.hcnu.service.StudentService;
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

import java.util.List;

@Controller
@RequestMapping(value = "/main")
public class ListController {

    //controller 调 service 层

    @Qualifier("studentServiceImpl")
    private StudentService studentService;

    @Autowired
    public void setStudentService(StudentService studentService) {
        this.studentService = studentService;
    }

    @RequestMapping(value = "/toMain")
    public String toMain(){
        Model model = null;
        List<Student> students = studentService.queryAllStudent();
        model.addAttribute("students",students);
        return "redirect:/comparisonRecord1";
    }

    /**
    * @author CF
    * @Description 跳转到修改页面并把当前学号传过去
    * @Date 17:38 2021/2/15
    * @Param [sno, model]
    * @return java.lang.String
    */
    @RequestMapping(value = "/toUpdate/{sno}", method = RequestMethod.GET)
    public String selectUser(@PathVariable("sno") String sno,Model model) {
        model.addAttribute("sno",sno);
        return "updateStudent";
    }


    /**
    * @author CF
    * @Description 跳转到添加页面
    * @Date 17:40 2021/2/15
    * @Param []
    * @return java.lang.String
    */
    @RequestMapping("/toAddStudeent")
    public String toAddPaPer() {
        return "addStudent";
    }

    /**
    * @author CF
    * @Description 跳转到人员搜索页面
    * @Date 13:52 2021/2/25
    * @Param [model]
    * @return java.lang.String
    */
    @RequestMapping(value = "/allStudent")
    @ResponseBody
    public List<Student> toComparison(){
        List<Student> students = studentService.queryAllStudent();
        System.out.println(students);
        return students;
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

        // json = URLDecoder.decode(json, "UTF-8");
        HttpPost httpPost = new HttpPost("http://192.168.0.31:8011");
        CloseableHttpClient client = HttpClients.createDefault();
        String respContent = null;
        System.out.println("传入中间代理服务器的JSON："+json);

        StringEntity entity = new StringEntity(json.toString(), "utf-8");//解决中文乱码问题
        entity.setContentEncoding("UTF-8");
        entity.setContentType("application/json");
        httpPost.setEntity(entity);

        HttpResponse resp = client.execute(httpPost);

        //resp.setHeader("Content-Type", "application/json");
        if (resp.getStatusLine().getStatusCode() == 200) {
            HttpEntity he = resp.getEntity();
            respContent = EntityUtils.toString(he, "UTF-8");
        }
        System.out.println("返回的JSON：" + respContent);
        return respContent;
    }



}
