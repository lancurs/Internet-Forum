package forum.dao;

import forum.dao.vo.Topic;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class TopicDaoImpl implements TopicDao {
    private Connection conn = null;
    private PreparedStatement psmt = null;

    public TopicDaoImpl(Connection conn) {
        this.conn = conn;
    }

    public boolean doInsert(Topic topic) throws Exception {

        this.conn.setAutoCommit(false);

        String insert = "INSERT INTO article values (NULL,0,?,0,0,?,?,?,?,0)";
        this.psmt = this.conn.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);

        String time = DateFormat.getDateTimeInstance().format(new Date());
        psmt.setInt(1, -1);
        psmt.setString(2, topic.getAuthor());
        psmt.setString(3, topic.getTitle().trim());
        psmt.setString(4, topic.getCont().trim());
        psmt.setString(5, time);


        int n = this.psmt.executeUpdate();
        ResultSet rsKey = psmt.getGeneratedKeys();
        rsKey.next();
        int key = rsKey.getInt(1);
        rsKey.close();
        psmt.executeUpdate("UPDATE article SET rootid = " + key + " WHERE id = " + key);

        this.conn.commit();
        this.conn.setAutoCommit(true);

        this.psmt.close();
        if (n > 0) {
            return true;
        }
        return false;
    }

    public List showTopics() throws Exception {
        ArrayList res = new ArrayList();
        String sql = "SELECT * FROM article WHERE pid = 0 order by pdate desc";
        this.psmt = this.conn.prepareStatement(sql);
        ResultSet rs = psmt.executeQuery();
        while (rs.next()) {
            read(rs, res);

        }
        this.psmt.close();
        rs.close();
        return res;
    }

    public int getCount() throws Exception {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM article WHERE pid=0";
        this.psmt = this.conn.prepareStatement(sql);
        ResultSet rs = psmt.executeQuery();
        if (rs.next()) {
            count = rs.getInt(1);
        }
        return count;

    }

    public List showContents(int rootid) throws Exception {


        //psmt.executeUpdate("UPDATE article SET views=views+1 WHERE id=\" + rootid");
        ArrayList<Topic> res = new ArrayList<Topic>();
        String sql = "SELECT * FROM article WHERE rootid =" + rootid;
        this.psmt = this.conn.prepareStatement(sql);
        ResultSet rs = psmt.executeQuery();
        while (rs.next()) {
            read(rs, res);
        }
        psmt.executeUpdate("UPDATE article SET views = views +1 where id=" + rootid);
        return res;
    }

    public Topic getTopicByID(int id) throws Exception {
        ArrayList<Topic> res = new ArrayList<Topic>();
        String sql = "SELECT * FROM article WHERE ID =" + id;
        this.psmt = this.conn.prepareStatement(sql);
        ResultSet rs = psmt.executeQuery();
        if (rs.next()) {
            read(rs, res);
        }
        return res.get(0);
    }

    public void read(ResultSet rs, ArrayList res) throws Exception {
        Topic topic = new Topic();
        topic.setId(rs.getInt("id"));
        topic.setPid(rs.getInt("pid"));
        topic.setRootid(rs.getInt("rootid"));
        topic.setViews(rs.getInt("views"));
        topic.setReplies(rs.getInt("replies"));
        topic.setAuthor(rs.getString("author"));
        topic.setTitle(rs.getString("title"));
        topic.setCont(rs.getString("cont"));
        topic.setPdate(rs.getString("pdate"));
        res.add(topic);
    }

    public void updateView(int rid) {
        String sql = "UPDATE article SET views=views+1 WHERE id=" + rid;
        try {
            this.psmt = this.conn.prepareStatement(sql);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean doReply(Topic topic) throws Exception {

        this.conn.setAutoCommit(false);

        String sql = "INSERT INTO article values (null,?,?,0,0,?,null,?,?,0)";
        this.psmt = this.conn.prepareStatement(sql);

        String time = DateFormat.getDateTimeInstance().format(new Date());

        psmt.setInt(1, topic.getPid());
        psmt.setInt(2, topic.getRootid());
        psmt.setString(3, topic.getAuthor());
        psmt.setString(4, topic.getCont());
        psmt.setString(5, time);

        int n = this.psmt.executeUpdate();

        psmt.executeUpdate("UPDATE article SET replies = replies +1 where id=" + topic.getRootid());

        this.conn.commit();
        this.conn.setAutoCommit(true);

        this.psmt.close();
        if (n > 0) {
            return true;
        }
        return false;
    }
}



