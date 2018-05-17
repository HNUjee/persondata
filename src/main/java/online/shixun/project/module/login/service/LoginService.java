package online.shixun.project.module.login.service;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import online.shixun.project.dto.SysuserDTO;
import online.shixun.project.module.login.dao.LoginDao;

@Service("loginService")
@Transactional
public class LoginService {
    @Autowired
    private LoginDao loginDao;

    /**
     * 用户登录
     * 
     * @param sysuser
     * @return
     */
    public boolean login(SysuserDTO sysuser) {
	boolean issysuser = loginDao.login(sysuser.getName(), DigestUtils.md5Hex(sysuser.getPassword()));
	if (issysuser) {
	    return true;
	}
	return false;
    }
}
