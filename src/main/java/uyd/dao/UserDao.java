package uyd.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import uyd.entity.User;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月13日
 * @version 1.0
 * @description 用户信息DAO
 */
@Repository("userDao")
public interface UserDao {

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @description 用户登录
	 */
	public User login(User user);

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @description 根据id查询用户信息
	 */
	public User findById(String userId);

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月14日
	 * @version 1.0
	 * @description 根据登录用户名查询是否用户名重复
	 */
	public Integer findByUsername(String username);

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @description 修改密码
	 */
	public int updatePwd(User user);

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @description 删除用户
	 */
	public int delete(String userId);

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @description 添加用户
	 */
	public int save(User user);

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @description 更新用户信息
	 */
	public int update(User user);

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @description 查询所有用户信息
	 */
	public List<User> list(Map<String, Object> map);

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @description 查询符合条件的用户数量
	 */
	public int getCount(Map<String, Object> map);
}
