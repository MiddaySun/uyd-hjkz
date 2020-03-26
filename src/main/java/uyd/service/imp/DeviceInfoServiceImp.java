package uyd.service.imp;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import uyd.dao.DeviceInfoDao;
import uyd.entity.DeviceInfo;
import uyd.service.DeviceInfoService;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月24日,下午5:22:34
 * @version 1.0
 * @description
 */
@Service
public class DeviceInfoServiceImp implements DeviceInfoService {

	@Resource
	private DeviceInfoDao deviceInfodao;

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月24日,下午5:22:54
	 * @version 1.0
	 * @param map
	 * @return
	 * @description
	 */
	@Override
	public List<DeviceInfo> findList(Map<String, Object> map) {
		return deviceInfodao.findList(map);
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月24日,下午5:24:00
	 * @version 1.0
	 * @param map
	 * @return
	 * @description
	 */
	@Override
	public Integer getCount(Map<String, Object> map) {
		return deviceInfodao.getCount(map);
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月26日,上午10:55:55
	 * @version 1.0
	 * @param deviceInfo
	 * @return
	 * @description
	 */
	@Override
	public Integer findByDeviceInfo(DeviceInfo deviceInfo) {
		return null;
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月26日,上午10:55:55
	 * @version 1.0
	 * @param deviceInfo
	 * @return
	 * @description
	 */
	@Override
	public Integer addDeviceInfo(DeviceInfo deviceInfo) {
		return null;
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月26日,上午10:55:55
	 * @version 1.0
	 * @param deviceInfo
	 * @return
	 * @description
	 */
	@Override
	public Integer delteDeviceInfo(DeviceInfo deviceInfo) {
		return null;
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月26日,上午10:55:55
	 * @version 1.0
	 * @param deviceInfo
	 * @return
	 * @description
	 */
	@Override
	public Integer updateDeviceInfo(DeviceInfo deviceInfo) {
		return null;
	}

}
