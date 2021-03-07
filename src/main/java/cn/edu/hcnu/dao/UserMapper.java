package cn.edu.hcnu.dao;

import cn.edu.hcnu.pojo.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author CF
 * @create 2021/2/23 16:39
 */
public interface UserMapper {

    int addUser(User user);

    int delete(User user);

    int updateUser(User user);

    User findByAccountAndPass(@Param("username") String username, @Param("password") String password);

    List<User> queryAllUser();
}

