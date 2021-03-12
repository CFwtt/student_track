package cn.edu.hcnu.controller;

import cn.edu.hcnu.pojo.Student;
import cn.edu.hcnu.pojo.User;
import cn.edu.hcnu.service.StudentService;
import cn.edu.hcnu.service.UserService;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * @Author CF
 * @create 2021/2/23 16:31
 */
@Controller
@RequestMapping(value = "/login")
public class LoginController {


    @Qualifier("studentServiceImpl")
    private StudentService studentService;


    @Qualifier("userServiceImpl")
    private UserService userService;
    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    /**
    * @author CF
    * @Description 登陆成功跳转页面
    * @Date 16:36 2021/2/23
    * @Param
    * @return
    */
    @SneakyThrows
    @RequestMapping(value = "/doLogin",method = RequestMethod.POST)
    public String login(HttpServletRequest request,
                        @RequestParam("username")String username,
                        @RequestParam("password")String password
    ){
        User user = userService.findByAccountAndPass(username, password);
        if (user!=null && user.getPassword().equals(password)){
            //用户输入学号和密码正确，登录成功，跳转到主页面
            //保存在session中的数据，默认是30分钟内有效。保存在session中的数据，在整个项目中都可以获取得到
            request.getSession().setAttribute("session_user", user);
           return "mainTest";
        }else {
            request.setAttribute("wrongMsg","用户名密码错误");
            request.getSession().setAttribute("wrongMsg","用户名密码错误");
            return "redirect:/login";
    }
    }


}
