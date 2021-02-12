package cn.edu.hcnu.controller;


import cn.edu.hcnu.pojo.User;
import net.sf.json.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.net.URLDecoder;

@Controller
public class ListController {
    /**
     * 接收页面请求的JSON数据，并返回JSON格式结果
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

    /**
     * 接收RESTful风格的请求,其接收方式为GET
     */
    @RequestMapping(value = "/user/{id}", method = RequestMethod.GET)
    @ResponseBody
    public User selectUser(@PathVariable("id") String id) {
        //查看数据接收
        User user = new User();
        System.out.println("id=" + id);
        return user;
    }

}
