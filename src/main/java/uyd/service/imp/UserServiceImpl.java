package uyd.service.imp;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import uyd.dao.UserDao;
import uyd.entity.User;
import uyd.service.UserService;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月14日
 * @version 1.0
 * @description 用户信息业务实现层
 */
@Service("userService")
public class UserServiceImpl implements UserService {

	@Resource
	private UserDao userDao;

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月14日
	 * @version 1.0
	 * @description
	 */
	@Override
	public User login(User user) {
		// TODO Auto-generated method stub
		return userDao.login(user);
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月14日
	 * @version 1.0
	 * @description
	 */
	@Override
	public User findById(String userId) {
		// TODO Auto-generated method stub
		return userDao.findById(userId);
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月14日
	 * @version 1.0
	 * @description
	 */
	@Override
	public int updatePwd(User user) {
		// TODO Auto-generated method stub
		return userDao.updatePwd(user);
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月14日
	 * @version 1.0
	 * @description
	 */
	@Override
	public int delete(String userId) {
		// TODO Auto-generated method stub
		return userDao.delete(userId);
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月14日
	 * @version 1.0
	 * @description
	 */
	@Override
	public int save(User user) {
		// TODO Auto-generated method stub
		return userDao.save(user);
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月14日
	 * @version 1.0
	 * @description
	 */
	@Override
	public int update(User user) {
		// TODO Auto-generated method stub
		return userDao.update(user);
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月14日
	 * @version 1.0
	 * @description
	 */
	@Override
	public List<User> list(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return userDao.list(map);
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月14日
	 * @version 1.0
	 * @description
	 */
	@Override
	public int getCount(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return userDao.getCount(map);
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月14日
	 * @version 1.0
	 * @description
	 */
	@Override
	public Integer findByUsername(String username) {
		return userDao.findByUsername(username);
	}

}
