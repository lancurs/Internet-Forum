package forum.dao;

import forum.dao.vo.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDaoImpl implements UserDao {
    private Connection conn = null;
    private PreparedStatement psmt = null;


    public UserDaoImpl(Connection conn) {
        this.conn = conn;
    }

    public boolean doInsert(User user) throws Exception {

        String insert = "INSERT INTO user(username,password) VALUES (?,?)";
        this.psmt = this.conn.prepareStatement(insert);
        this.psmt.setString(1, user.getUsername());
        this.psmt.setString(2, user.getPassword());
        int n = this.psmt.executeUpdate();
        this.psmt.close();
        if (n > 0) {
            return true;
        }
        return false;
    }


    public List findAll() throws Exception {
        String select = "select * from user";
        List list = new ArrayList();
        this.psmt = this.conn.prepareStatement(select);
        ResultSet rst = this.psmt.executeQuery();
        while (rst.next()) {
            User user = new User();
            user.setUsername(rst.getString("username"));
            user.setPassword(rst.getString("password"));
            list.add(user);
        }
        this.psmt.close();
//rst.close();
        return list;
    }


    public User findByUid(int uid) throws Exception {
        String sql = "select * from user where uid=?";
        this.psmt = this.conn.prepareStatement(sql);
        ResultSet rst = this.psmt.executeQuery();
        User user = null;
        if (rst.next()) {
            user = new User();
            user.setUsername(rst.getString("username"));
            user.setPassword(rst.getString("password"));
        }
        this.psmt.close();
        return user;
    }

    public User findByName(String username) throws Exception {
        String sql = "select * from user where username=?";
        this.psmt = this.conn.prepareStatement(sql);
        psmt.setString(1, username);
        ResultSet rst = this.psmt.executeQuery();
        User user = null;
        if (rst.next()) {
            user = new User();
            user.setUsername(rst.getString("username"));
            user.setPassword(rst.getString("password"));
        }
        this.psmt.close();
        return user;
    }


}