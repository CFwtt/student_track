package cn.edu.hcnu.controller;

import cn.edu.hcnu.pojo.User;
import cn.edu.hcnu.service.UserService;
import lombok.SneakyThrows;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Author CF
 * @create 2021/2/23 16:31
 */
@Controller
@RequestMapping(value = "/login")
public class LoginController {


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
    @RequestMapping(value = "/form")
    public void LoginInfo(String username, String password, HttpServletRequest request, HttpServletResponse response){
        User user = userService.findByAccountAndPass(username,password);
        if (user!=null){
            request.getRequestDispatcher("/WEB-INF/jsp/comparisonRecord.jsp").forward(request, response);
        }
    }


}
