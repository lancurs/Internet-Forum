package forum.dao;

public class DaoFactory {
    public static UserDao getUserDaoInstance() {
        UserDao dao= null;
        try {
            dao = new UserDaoProxy();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return dao;
    }

    public static TopicDao getTopicDaoInstance(){
        TopicDao dao = null;
        try{
            dao=new TopicDaoProxy();
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return dao;
    }
}