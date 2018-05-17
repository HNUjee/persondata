package online.shixun.project.module.link.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import online.shixun.project.dto.LinkDTO;

@Repository("linkDao")
public class LinkDao {
    @Autowired
    private SessionFactory sessionFactory;

    /**
     * 获取所有链接
     * 
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<LinkDTO> linklist() {
	return sessionFactory.getCurrentSession().createQuery("from LinkDTO").list();
    }

    /**
     * 添加链接
     * 
     * @param linkDTO
     */
    public void add(LinkDTO linkDTO) {
	sessionFactory.getCurrentSession().saveOrUpdate(linkDTO);
    }

    /**
     * 删除链接
     * 
     * @param linkDTO
     */
    public void delete(LinkDTO linkDTO) {
	sessionFactory.getCurrentSession().delete(linkDTO);
    }

    /**
     * 通过id查询链接
     * 
     * @param id
     * @return
     */
    public LinkDTO getLinkbyId(int id) {
	return (LinkDTO) sessionFactory.getCurrentSession().get(LinkDTO.class, id);
    }

    /**
     * 批量删除
     * 
     * @param ids
     */
    public void deletes(int ids) {
	String hql = "delete from LinkDTO where id in(:ids)";
	Query query = sessionFactory.getCurrentSession().createQuery(hql);
	query.setParameter("ids", ids);
	query.executeUpdate();
    }
}
