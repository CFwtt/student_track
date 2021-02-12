package cn.edu.hcnu.controller;

import cn.edu.hcnu.pojo.Books;
import cn.edu.hcnu.service.StudentService;
import lombok.SneakyThrows;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.io.InputStream;
import java.util.List;

/**
 * @Author CF
 * @create 2021/1/31 18:18
 */
@RestController
@RequestMapping("/book")

public class BookController {
    //controller 调 service 层
    @Autowired
    @Qualifier("BookServiceImpl")
    private StudentService studentService;

    //查询全部的书籍，并且返回到一个书籍展示页面
    @RequestMapping("/allBook")
    public String list(Model model){
        List<Books> list = studentService.queryAllBook();
        model.addAttribute("list",list);
        return "allBook";
    }

    //跳转到添加书籍页面
    @RequestMapping("/toAddBook")
    public String toAddPaPer(){
        return "addBook";
    }

    //添加书籍请求
    @RequestMapping("/addBook")
    public String addBook(Books books){
        System.out.println("addBook=>"+books);
        studentService.addBook(books);
        return "redirect:/book/allBook";
    }

    //跳转到修改书籍页面
    @RequestMapping("/toUpdateBook")
    public String toUpdatePaPer(int id,Model model){
        Books books = studentService.queryBookById(id);
        model.addAttribute("Qbook",books);
        return "updateBook";
    }


    //修改书籍
    @RequestMapping("/updateBook")
    public String updateBook(Books books){
        studentService.updateBook(books);
       return "redirect:/book/allBook";
    }

    //删除书籍
    @RequestMapping("/deleteBook")
    public String deleteBook(int id){
        studentService.deleteBook(id);
        return "redirect:/book/allBook";
    }

    @SneakyThrows
    @RequestMapping(value = "/remote0",method = RequestMethod.POST)
    @ResponseBody
    public String remote(){
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


}
