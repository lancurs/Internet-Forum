package forum.dao;

import forum.dao.vo.User;

import java.util.List;

public class UserDaoProxy implements UserDao {
    private DbConnection dbConnection = null;
    private UserDao dao = null;

    public UserDaoProxy() {
        this.dbConnection = new DbConnection();
        this.dao = new UserDaoImpl(this.dbConnection.getConnection());
    }

    public boolean doInsert(User user) throws Exception {
        boolean flag = false;
        try {

            flag = this.dao.doInsert(user);

        } catch (Exception e) {
            throw e;
        } finally {
            this.dbConnection.closeConnection();
        }
        return flag;
    }

    public List findAll() throws Exception {
        List list = null;
        try {
            list = this.dao.findAll();
        } catch (Exception e) {
            throw e;
        } finally {
            this.dbConnection.closeConnection();
        }
        return list;
    }

    public User findByUid(int uid) throws Exception {
        User user = null;
        try {
            user = this.dao.findByUid(uid);
        } catch (Exception e) {
            throw e;
        }
        return user;
    }



    public User findByName(String username) throws Exception {
        User user = null;
        try {
            user = this.dao.findByName(username);
        } catch (Exception e) {
            throw e;
        }
        return user;
    }
}