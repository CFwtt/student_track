package cn.edu.hcnu.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author CF
 * @create 2021/1/30 16:42
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Books {
    private int bookID;
    private String bookName;
    private  int bookCounts;
    private  String detail;

}
