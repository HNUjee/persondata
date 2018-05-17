package online.shixun.project.module.contacttype.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import online.shixun.project.dto.ContactCategoryDTO;

@Repository("contactTypeDao")
public class ContactTypeDao {
    @Autowired
    private SessionFactory sessionFactory;

    @SuppressWarnings("unchecked")
    public List<ContactCategoryDTO> categorylist() {
	return sessionFactory.getCurrentSession().createQuery("from ContactCategoryDTO").list();
    }

    public void save(ContactCategoryDTO categoryDTO) {
	sessionFactory.getCurrentSession().saveOrUpdate(categoryDTO);
    }

    public void delete(ContactCategoryDTO categoryDTO) {
	sessionFactory.getCurrentSession().delete(categoryDTO);
    }

    public ContactCategoryDTO getCategoryById(int id) {
	return (ContactCategoryDTO) sessionFactory.getCurrentSession().get(ContactCategoryDTO.class, id);
    }

    public void deletes(int ids) {
	String hql = "delete from ContactCategoryDTO where id in(:ids)";
	Query query = sessionFactory.getCurrentSession().createQuery(hql);
	query.setParameter("ids", ids);
	query.executeUpdate();
    }

    public Integer checkContact(int id) {
	String sql = "select count()";
	return sessionFactory.getCurrentSession().createSQLQuery(sql).getFirstResult();
    }
}
