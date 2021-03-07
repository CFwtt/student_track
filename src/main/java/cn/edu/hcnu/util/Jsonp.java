package cn.edu.hcnu.util;

import net.sf.json.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @Author CF
 * @create 2021/3/7 20:59
 */
@Controller
@RequestMapping(value = "/Jsonp")
public class Jsonp {
    /**
     * @return java.lang.String
     * @author CF
     * @Description 用中间代理服务器，解决跨域
     * @Date 19:01 2021/2/5
     * @Param [json]
     */
    @RequestMapping(value = "/jsonp", produces = "text/html;application/json;charset=UTF-8")
    @ResponseBody
    public static String httpPostWithJSON(@RequestBody JSONObject json) throws Exception {

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
