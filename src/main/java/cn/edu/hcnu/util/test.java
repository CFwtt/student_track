package cn.edu.hcnu.util;

import com.google.gson.Gson;
import com.google.gson.JsonSyntaxException;
import com.google.gson.reflect.TypeToken;
import lombok.SneakyThrows;
import net.sf.json.JSONObject;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.InputStream;
import java.util.Map;

/**
 * @Author CF
 * @create 2021/2/3 17:52
 */
public class test {
    @SneakyThrows
    @RequestMapping(value = "/remote",method = RequestMethod.POST)
    @ResponseBody
    public static String httpPostWithJSON() throws Exception {

                 HttpPost httpPost = new HttpPost("192.168.0.31:8011");
                 CloseableHttpClient client = HttpClients.createDefault();
                 String respContent = null;

        //        json方式
                JSONObject jsonParam = new JSONObject();
                 jsonParam.put("Name","getNetParametersRequest");
                 StringEntity entity = new StringEntity(jsonParam.toString(),"utf-8");//解决中文乱码问题
                 entity.setContentEncoding("UTF-8");
                 entity.setContentType("application/json");
                 httpPost.setEntity(entity);
                 System.out.println();


         //        表单方式
         //        List<BasicNameValuePair> pairList = new ArrayList<BasicNameValuePair>();
         //        pairList.add(new BasicNameValuePair("name", "admin"));
         //        pairList.add(new BasicNameValuePair("pass", "123456"));
         //        httpPost.setEntity(new UrlEncodedFormEntity(pairList, "utf-8"));   //UrlEncodedFormEntity默认"application/x-www-form-urlencoded"


                 HttpResponse resp = client.execute(httpPost);
                 if(resp.getStatusLine().getStatusCode() == 200) {
                       HttpEntity he = resp.getEntity();
                       respContent = EntityUtils.toString(he,"UTF-8");
                    }
                 return respContent;
             }

    @RequestMapping("addPxx")
    @ResponseBody
    public static Map<String,Boolean> addPxx(@RequestBody JSONObject data) throws Exception {

        HttpPost httpPost = new HttpPost("192.168.0.31:8011");
        CloseableHttpClient client = HttpClients.createDefault();
        String respContent = null;

        //        json方式
        JSONObject jsonParam = new JSONObject();
        jsonParam.put("Name","getNetParametersRequest");
        StringEntity entity = new StringEntity(jsonParam.toString(),"utf-8");//解决中文乱码问题
        entity.setContentEncoding("UTF-8");
        entity.setContentType("application/json");
        httpPost.setEntity(entity);
        System.out.println();


        //        表单方式
        //        List<BasicNameValuePair> pairList = new ArrayList<BasicNameValuePair>();
        //        pairList.add(new BasicNameValuePair("name", "admin"));
        //        pairList.add(new BasicNameValuePair("pass", "123456"));
        //        httpPost.setEntity(new UrlEncodedFormEntity(pairList, "utf-8"));   //UrlEncodedFormEntity默认"application/x-www-form-urlencoded"


        HttpResponse resp = client.execute(httpPost);
        if(resp.getStatusLine().getStatusCode() == 200) {
            HttpEntity he = resp.getEntity();
            respContent = EntityUtils.toString(he,"UTF-8");
        }

            Map<String,Boolean> res = null;
            try {
                Gson gson = new Gson();
                res = gson.fromJson(respContent, new TypeToken<Map<String, Object>>() {
                }.getType());
            } catch (JsonSyntaxException e) {
            }

        return res;
    }
    @SneakyThrows
    public static String remote(){
        CloseableHttpClient httpClient = HttpClients.createDefault();
        HttpPost httpPost = new HttpPost("http://192.168.0.31:8011");

        CloseableHttpResponse response = httpClient.execute(httpPost);
        InputStream content = response.getEntity().getContent();
        StringBuilder stringBuilder = new StringBuilder();
        byte[] bytes = new byte[1024];
        System.out.println("------------------------");

        int len;
        while ((len = content.read(bytes)) != -1){
            stringBuilder.append(new String(bytes,0,len));
        }
        return stringBuilder.toString();
    }



    public static void main(String[] args) throws Exception {
                 String result = remote();
                 System.out.println(result);
             }
}
