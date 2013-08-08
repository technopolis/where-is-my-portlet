
package gr.open.admin.portlet.action;

import com.liferay.portal.kernel.portlet.ConfigurationAction;
import com.liferay.portal.kernel.portlet.DefaultConfigurationAction;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portlet.PortletPreferencesFactoryUtil;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.PortletConfig;
import javax.portlet.PortletPreferences;
import javax.portlet.RenderRequest;
import javax.portlet.RenderResponse;

public class WhereIsMyPortletConfigurationAction extends DefaultConfigurationAction implements ConfigurationAction {

	public void processAction(PortletConfig portletConfig, ActionRequest actionRequest, ActionResponse actionResponse)
		throws Exception {

		String portletResource = ParamUtil.getString(actionRequest, "portletResource");

		PortletPreferences preferences =
			Validator.isNotNull(portletResource)
				? PortletPreferencesFactoryUtil.getPortletSetup(actionRequest, portletResource) : actionRequest.getPreferences();

		preferences.setValue("ignoreScopeGroupIdFlag", actionRequest.getParameter("ignoreScopeGroupIdFlag"));
		preferences.setValue("showBaseUrl", actionRequest.getParameter("showBaseUrl"));
		preferences.setValue("popupWidth", actionRequest.getParameter("popupWidth"));
		preferences.setValue("popupHeight", actionRequest.getParameter("popupHeight"));
		preferences.setValue("enableFilters", actionRequest.getParameter("enableFilters"));

		preferences.store();

		super.processAction(portletConfig, actionRequest, actionResponse);

	}

	public String render(PortletConfig arg0, RenderRequest arg1, RenderResponse arg2)
		throws Exception {

		return "/html/where-is-my-portlet/config.jsp";
	}
}
