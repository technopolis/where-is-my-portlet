
package gr.open.admin.portlet.views;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.model.Layout;
import com.liferay.portal.model.Portlet;
import com.liferay.portal.model.PortletPreferences;
import com.liferay.portal.service.PortletPreferencesLocalServiceUtil;
import com.liferay.portal.theme.ThemeDisplay;
import com.liferay.portal.util.PortalUtil;

import gr.open.admin.helpers.WhereIsMyPortletUtil;

import java.io.Serializable;
import java.util.List;

public class PortletView implements Serializable {

	private static final Log logger = LogFactoryUtil.getLog(PortletView.class);
	private static final long serialVersionUID = 1L;
	private final Portlet portlet;
	private final String portletId;
	private final Layout layout;

	public PortletView(Portlet portlet, Layout layout) {

		if (portlet == null) {
			throw new IllegalArgumentException("CANNOT PASS A null IN PortletView CONSTRUCTOR");
		}
		this.portlet = portlet;
		this.portletId = portlet.getPortletId();
		this.layout = layout;
	}

	public Portlet getPortlet() {

		return portlet;
	}

	public List<PortletPreferences> getPortletPreferences(long groupId)
		throws SystemException, PortalException {

		return PortletPreferencesLocalServiceUtil.getPortletPreferences(getPlid(groupId), getPortlet().getPortletId());
	}

	public long getPlid(long groupId)
		throws PortalException, SystemException {

		return PortalUtil.getPlidFromPortletId(groupId, getPortlet().getPortletId());
	}

	public String getPortletBarName(ThemeDisplay themeDisplay) {
		String result = "";
		try {
			result = WhereIsMyPortletUtil.getPortletTitleBarName(themeDisplay, getPortlet().getPortletId(), getPortlet().getDisplayName(), getLayout().getPlid());
		}
		catch (SystemException e) {
			logger.error(e.getMessage(), e);
		}
		return result;
	}

	public String getPortletId() {

		return portletId;
	}

	@Override
	public int hashCode() {

		final int prime = 31;
		int result = 1;
		result = prime * result + ((portletId == null) ? 0 : portletId.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {

		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		PortletView other = (PortletView) obj;
		if (portletId == null) {
			if (other.portletId != null)
				return false;
		}
		else if (!portletId.equals(other.portletId))
			return false;
		return true;
	}

	
	public Layout getLayout() {
	
		return layout;
	}

	
}
