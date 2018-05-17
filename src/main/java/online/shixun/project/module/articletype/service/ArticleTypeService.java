package online.shixun.project.module.articletype.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import online.shixun.project.dto.ArticleTypeDTO;
import online.shixun.project.module.articletype.dao.ArticleTypeDao;

@Service("articleTypeService")
@Transactional
public class ArticleTypeService {
    @Autowired
    private ArticleTypeDao articleTypeDao;

    public List<ArticleTypeDTO> articleTypelist() {
	return articleTypeDao.articleTypeList();
    }

    public void add(ArticleTypeDTO articleTypeDTO) {
	articleTypeDao.add(articleTypeDTO);
    }

    public void delete(int id) {
	ArticleTypeDTO articleTypeDTO = new ArticleTypeDTO();
	articleTypeDTO.setId(id);
	articleTypeDao.delete(articleTypeDTO);
    }

    /**
     * 根据id获取
     * 
     * @param id
     * @return
     */
    public ArticleTypeDTO getArticleTypeById(int id) {
	return articleTypeDao.geArticleTypebyId(id);
    }

    public void deletes(String ids) {
	String[] strs = ids.split(",");
	int[] nums = new int[strs.length];
	for (int i = 0; i < strs.length; i++) {
	    if (strs[i] != null) {
		nums[i] = Integer.parseInt(strs[i]);
		articleTypeDao.deletes(nums[i]);
	    }
	}
    }
}
