package online.shixun.project.module.picture.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import online.shixun.project.dto.PictureDTO;

@Repository("pictureDao")
public class PictureDao {
    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<PictureDTO> picturelist() {
	return sessionFactory.getCurrentSession().createSQLQuery("SELECT srcpath FROM t_picture").list();
    }

    public void addPicture(PictureDTO pictureDTO) {
	sessionFactory.getCurrentSession().saveOrUpdate(pictureDTO);
    }

    @SuppressWarnings("unchecked")
    public List<PictureDTO> selectPicture(int id) {
	String hql = "SELECT srcpath FROM t_picture WHERE category_id =" + id;
	return sessionFactory.getCurrentSession().createSQLQuery(hql).list();
    }

    /**
     * 统计查询的总记录数
     * 
     * @return
     */
    public int queryAllcount() {
	return sessionFactory.getCurrentSession().createQuery("from PictureDTO").list().size();
    }
}
