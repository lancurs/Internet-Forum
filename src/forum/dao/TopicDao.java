package forum.dao;
import forum.dao.vo.Topic;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by yangpeng on 4/8/15.
 */
public interface TopicDao {
    boolean doInsert(Topic topic) throws Exception;
    int getCount() throws Exception;
    List showTopics() throws Exception;
    List showContents(int rootid) throws Exception;
    Topic getTopicByID(int id) throws Exception;
    void updateView(int rid) throws Exception;
    boolean doReply(Topic topic) throws Exception;
}
