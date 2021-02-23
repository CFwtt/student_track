package cn.edu.hcnu.service;

import cn.edu.hcnu.pojo.User;

import java.util.List;

/**
 * @Author CF
 * @create 2021/2/23 17:14
 */
public interface UserService {
    int addUser(User user);

    int delete(User user);

    int updateUser(User user);

    User findByAccountAndPass(String username,String password);

    List<User> queryAllUser();
}
