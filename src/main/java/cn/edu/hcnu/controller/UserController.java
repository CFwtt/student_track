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
import org.springframework.web.bind.annotation.*;

@Controller
public class UserController {
	/**
	 * 接收页面请求的JSON数据，并返回JSON格式结果
	 */
	@RequestMapping("/testJson")
	@ResponseBody
	public User testJson(@RequestBody User user) {
		// 打印接收的JSON格式数据
		System.out.println(user);
		// 返回JSON格式的响应
		return user;
	}

	@RequestMapping("/testJson1")
	@ResponseBody
	public  String httpPostWithJSON(@RequestBody JSONObject json) throws Exception {
		System.out.println(json);
		 HttpPost httpPost = new HttpPost("http://192.168.0.31:8011");
		 CloseableHttpClient client = HttpClients.createDefault();
		 String respContent = null;

		 //        json方式
		  JSONObject jsonParam = new JSONObject();
		 // jsonParam.put();
		 StringEntity entity = new StringEntity(json.toString(),"utf-8");//解决中文乱码问题
		 entity.setContentEncoding("UTF-8");
		 entity.setContentType("application/json");
		 httpPost.setEntity(entity);
		 System.out.println(entity);
		//
		//
		// //        表单方式
		// //        List<BasicNameValuePair> pairList = new ArrayList<BasicNameValuePair>();
		// //        pairList.add(new BasicNameValuePair("name", "admin"));
		// //        pairList.add(new BasicNameValuePair("pass", "123456"));
		// //        httpPost.setEntity(new UrlEncodedFormEntity(pairList, "utf-8"));   //UrlEncodedFormEntity默认"application/x-www-form-urlencoded"
		//
		//
		 HttpResponse resp = client.execute(httpPost);
		 if(resp.getStatusLine().getStatusCode() == 200) {
		 	HttpEntity he = resp.getEntity();
		 	respContent = EntityUtils.toString(he,"UTF-8");
		 }
		return respContent;
	}
	
	/**
	 *接收RESTful风格的请求,其接收方式为GET
	 */
	@RequestMapping(value="/user/{id}",method= RequestMethod.GET)
	@ResponseBody
	public User selectUser(@PathVariable("id") String id){
	    //查看数据接收
	    System.out.println("id="+id);
	    User user=new User();
	    //模拟根据id查询出到用户对象数据
	    if(id.equals("1234")){	    	
	        user.setUsername("tom");
	    }
	    //返回JSON格式的数据
	    return user;
	}

}
