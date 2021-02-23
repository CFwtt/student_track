package cn.edu.hcnu.service;

import cn.edu.hcnu.dao.UserMapper;
import cn.edu.hcnu.pojo.User;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * @Author CF
 * @create 2021/2/23 17:15
 */
public class UserServiceImpl implements UserService{

    @Autowired
    private UserMapper userMapper;
    //调用dao层的操作，设置一个set接口，方便Spring管理
    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    public int addUser(User user) {
        return 0;
    }

    public int delete(User user) {
        return 0;
    }

    public int updateUser(User user) {
        return 0;
    }

    public User findByAccountAndPass(String username, String password) {
        return userMapper.findByAccountAndPass(username,password);
    }

    public List<User> queryAllUser() {
        return null;
    }
}
