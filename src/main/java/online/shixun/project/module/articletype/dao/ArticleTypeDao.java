package online.shixun.project.module.articletype.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import online.shixun.project.dto.ArticleTypeDTO;

@Repository("articleTypeDao")
public class ArticleTypeDao {
    @Autowired
    private SessionFactory sessionFactory;
/**
 * 查询所有文章
 * @return  List文章 
 */
    @SuppressWarnings("unchecked")
    public List<ArticleTypeDTO> articleTypeList() {
	return sessionFactory.getCurrentSession().createQuery("from ArticleTypeDTO").list();
    }
/**
 * 添加文章
 * @param articleTypeDTO
 */
    public void add(ArticleTypeDTO articleTypeDTO) {
	sessionFactory.getCurrentSession().saveOrUpdate(articleTypeDTO);
    }
/**
 * 删除文章
 * @param articleTypeDTO
 */
    public void delete(ArticleTypeDTO articleTypeDTO) {
	sessionFactory.getCurrentSession().delete(articleTypeDTO);
    }
/**
 * 根据id查询文章
 * @param id
 * @return
 */
    public ArticleTypeDTO geArticleTypebyId(int id) {
	return (ArticleTypeDTO) sessionFactory.getCurrentSession().get(ArticleTypeDTO.class, id);
    }
    /**
     * 批量删除
     * @param ids
     */
    public void deletes(int ids) {
	String hql = "delete from ArticleTypeDTO where id in(:ids)";
	Query query = sessionFactory.getCurrentSession().createQuery(hql);
	query.setParameter("ids", ids);
	query.executeUpdate();
    }
}
