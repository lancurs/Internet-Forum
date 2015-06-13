package forum.dao;

import forum.dao.vo.*;

import java.util.List;

public interface UserDao {
    boolean doInsert(User user) throws Exception;

    User findByUid(int uid) throws Exception;

    List findAll() throws Exception;

    User findByName(String username) throws Exception;
}