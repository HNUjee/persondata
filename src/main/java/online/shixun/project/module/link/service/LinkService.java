package online.shixun.project.module.link.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import online.shixun.project.dto.ArticleDTO;
import online.shixun.project.dto.LinkDTO;
import online.shixun.project.module.link.dao.LinkDao;

@Service("linkService")
@Transactional
public class LinkService {
	@Autowired
	private LinkDao linkDao;

	/***
	 * 
	 * 链接列表
	 * @return
	 */
	public List<LinkDTO> linklist() {
		return linkDao.linklist();
	}

	/***
	 * 添加链接
	 * 
	 * @param linkDTO
	 */
	public void add(LinkDTO linkDTO) {
		linkDao.add(linkDTO);
	}
	public void delete(int id) {
		LinkDTO linkDTO =new LinkDTO();
		linkDTO.setId(id);
		linkDao.delete(linkDTO);
	}
	public LinkDTO getbyId(int id) {
		return linkDao.getLinkbyId(id);
	}

	public void deletes(String ids) {
		String[] strs = ids.split(",");
		int[] nums = new int[strs.length];
		for (int i = 0; i < strs.length; i++) {
			if (strs[i] != null) {
				nums[i] = Integer.parseInt(strs[i]);
				linkDao.deletes(nums[i]);
			}
		}
		
	}
	
}
