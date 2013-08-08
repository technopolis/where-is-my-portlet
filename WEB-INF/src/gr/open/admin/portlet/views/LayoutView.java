package gr.open.admin.portlet.views;

import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.model.Layout;
import com.liferay.portal.model.LayoutTypePortlet;
import com.liferay.portal.model.Portlet;

import java.io.Serializable;
import java.util.LinkedList;
import java.util.List;


public class LayoutView implements Serializable {

	private static final Log logger = LogFactoryUtil.getLog(LayoutView.class);
	private static final long serialVersionUID = 1L;

	private final Layout layout;
	private final long layoutId;
	private final String portletName;
	
	
	public String getPortletName() {
	
		return portletName;
	}

	public LayoutView(Layout layout, String portletName) {
		this.layout = layout;
		this.layoutId = layout.getLayoutId();
		this.portletName = portletName;
	}
	
	public List<Portlet> getPortletInstances() {
		LayoutTypePortlet layoutTypePortlet = (LayoutTypePortlet) layout.getLayoutType();
		
		try {
			return layoutTypePortlet.getAllPortlets();
		}
		catch (PortalException e) {
			logger.error(e.getMessage(), e);
		}
		catch (SystemException e) {
			logger.error(e.getMessage(), e);
		}
		return null;
	}

	public List<Portlet> getPortletInstancesForPortletName() {
		List<Portlet> results = new LinkedList<Portlet>();
		for (Portlet portlet : getPortletInstances()) {
			if (portlet.getPortletName().equals(getPortletName())) {
				results.add(portlet);
			}
		}
		return results;
	}
	
	public long getLayoutId() {
	
		return layoutId;
	}


	public Layout getLayout() {
	
		return layout;
	}


	@Override
	public int hashCode() {

		final int prime = 31;
		int result = 1;
		result = prime * result + (int) (layoutId ^ (layoutId >>> 32));
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
		LayoutView other = (LayoutView) obj;
		if (layoutId != other.layoutId)
			return false;
		return true;
	}

}
