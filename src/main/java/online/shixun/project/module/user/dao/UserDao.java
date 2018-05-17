package online.shixun.project.module.user.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import online.shixun.project.dto.UserDTO;

@Repository("userDao")
public class UserDao {
    @Autowired
    private SessionFactory sessionFactory;

    public void saveOrUpdate(UserDTO user) {
	sessionFactory.getCurrentSession().saveOrUpdate(user);
    }

    public void delete(UserDTO user) {
	sessionFactory.getCurrentSession().delete(user);
    }

    @SuppressWarnings("unchecked")
    public List<UserDTO> select() {
	return sessionFactory.getCurrentSession().createQuery("from UserDTO").list();
    }

    public UserDTO selectByID(long id) {
	return (UserDTO) sessionFactory.getCurrentSession().get(UserDTO.class, id);
    }

    public void deletes(long nums) {
	String hql = "delete from UserDTO where id in(:ids)";
	Query query = sessionFactory.getCurrentSession().createQuery(hql);
	query.setParameter("ids", nums);
	query.executeUpdate();
    }

    public void changeStatus(Long id, long status) {
	String hql = "update t_user u set u.status = '" + status + "' where u.id='" + id + "'";
	sessionFactory.getCurrentSession().createSQLQuery(hql).executeUpdate();
    }

}
