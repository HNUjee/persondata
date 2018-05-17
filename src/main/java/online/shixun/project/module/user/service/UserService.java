package online.shixun.project.module.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import online.shixun.project.dto.UserDTO;
import online.shixun.project.module.user.dao.UserDao;

@Service("userService")
@Transactional
public class UserService {
    @Autowired
    private UserDao userDao;

    public void saveOrUpDate(UserDTO user) {
	userDao.saveOrUpdate(user);
    }

    public void delete(int id) {
	UserDTO user = new UserDTO();
	user.setId(id);
	userDao.delete(user);
    }

    public List<UserDTO> select() {
	return userDao.select();
    }

    public UserDTO selectByID(long id) {
	return userDao.selectByID(id);
    }

    /**
     * 批量删除
     * 
     * @param ids
     */
    public void deletes(String ids) {
	String[] strs = ids.split(",");
	long[] nums = new long[strs.length];
	for (int i = 0; i < strs.length; i++) {
	    if (strs[i] != null) {
		nums[i] = Long.parseLong(strs[i]);
		userDao.deletes(nums[i]);
	    }
	}
    }

    public void change(long id, long status) {
	userDao.changeStatus(id, status);
    }
}
