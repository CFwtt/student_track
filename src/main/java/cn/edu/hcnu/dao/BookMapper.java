package cn.edu.hcnu.dao;

import cn.edu.hcnu.pojo.Books;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @Author CF
 * @create 2021/1/30 17:00
 */
public interface BookMapper {
    //增加一本书
    int addBook(Books books);

    //删除一本书
    int deleteBook(@Param("bookId") int id);

    //更新一本书
    int updateBook(Books books);

    //查询一本书
    Books queryBookById(@Param("bookId") int id);

    //查询全部书
    List<Books> queryAllBook();
}
