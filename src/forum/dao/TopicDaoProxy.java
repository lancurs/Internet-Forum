package forum.dao;

import forum.dao.vo.Topic;

import java.util.ArrayList;
import java.util.List;

public class TopicDaoProxy implements TopicDao {
    private DbConnection dbConnection = null;
    private TopicDao dao = null;

    public TopicDaoProxy() {
        this.dbConnection = new DbConnection();
        this.dao = new TopicDaoImpl(this.dbConnection.getConnection());
    }

    public boolean doInsert(Topic topic) throws Exception {
        boolean flag = false;
        try {

            flag = this.dao.doInsert(topic);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.dbConnection.closeConnection();
        }
        return flag;
    }

    public int getCount() throws Exception {
        int count = 0;
        try {
            count = this.dao.getCount();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.dbConnection.closeConnection();
        }
        return count;
    }

    public List showTopics() throws Exception {
        List topics = new ArrayList();
        try {

            topics = this.dao.showTopics();

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.dbConnection.closeConnection();
        }
        return topics;
    }

    public List showContents(int rootid) throws Exception{
        List cont = new ArrayList();
        try
        {
          cont = this.dao.showContents(rootid);
        }
        catch (Exception e)
        {
         e.printStackTrace();
        }
        finally {
            this.dbConnection.closeConnection();
        }
        return cont;
    }

    public Topic getTopicByID(int id) throws Exception {
    Topic topic = new Topic();
        try {
            topic = this.dao.getTopicByID(id);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        finally {
            this.dbConnection.closeConnection();
        }
        return topic;
    }

    public void updateView(int rid) throws Exception{
        try {
            this.dao.updateView(rid);
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        finally {
            this.dbConnection.closeConnection();
        }
    }

    public boolean doReply(Topic topic) throws Exception{
        boolean flag = false;
        try {

            flag = this.dao.doReply(topic);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            this.dbConnection.closeConnection();
        }
        return flag;
    }
    }