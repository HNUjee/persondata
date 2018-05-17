package online.shixun.project.module.contact.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import online.shixun.project.dto.ContactDTO;

@Repository("contactDao")
public class ContactDao {
    @Autowired
    private SessionFactory sessionFactory;
/**
 * 保存联系人
 * @param contact
 */
    public void save(ContactDTO contact) {
	sessionFactory.getCurrentSession().saveOrUpdate(contact);
    }
/**
 * 获取全部联系人
 * @return
 */
    @SuppressWarnings("unchecked")
    public List<ContactDTO> contactList() {
	return sessionFactory.getCurrentSession().createQuery("from ContactDTO c inner join fetch c.category").list();
    }
/**
 * 根据id查询
 * @param id
 * @return
 */
    public ContactDTO getContactById(int id) {
	return (ContactDTO) sessionFactory.getCurrentSession().get(ContactDTO.class, id);
    }
/**
 * 删除联系人
 * @param contact
 */
    public void delete(ContactDTO contact) {
	sessionFactory.getCurrentSession().delete(contact);
    }
/**
 * 批量删除
 * @param nums
 */
    public void deletes(int nums) {
	String hql = "delete from ContactDTO where id in(:ids)";
	Query query = sessionFactory.getCurrentSession().createQuery(hql);
	query.setParameter("ids", nums);
	query.executeUpdate();
    }
}
