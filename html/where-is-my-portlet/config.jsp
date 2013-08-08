<%@ include file="/html/init.jsp" %>
<%@ page import="com.liferay.portal.kernel.util.Constants "%>

<%
String portletResource = ParamUtil.getString(renderRequest, "portletResource");

PortletPreferences prefs = PortletPreferencesFactoryUtil.getPortletSetup(renderRequest, portletResource);

String ignoreScopeGroupIdFlag = prefs.getValue("ignoreScopeGroupIdFlag","false");
String showBaseUrl = prefs.getValue("showBaseUrl","false");

String popupWidth = prefs.getValue("popupWidth", "600");
String popupHeight = prefs.getValue("popupHeight", "400");

boolean enableFilters = Boolean.valueOf(prefs.getValue("enableFilters", "true"));

%>

<form action='<liferay-portlet:actionURL portletConfiguration="true" />' method="POST" name="fm" >
	<aui:input name="<%=Constants.CMD%>" type="hidden" value="<%=Constants.UPDATE%>" />
	
	<aui:fieldset label="general">
		<aui:input name="ignoreScopeGroupIdFlag" type="checkbox" value="<%= ignoreScopeGroupIdFlag %>"/>
		<aui:input name="showBaseUrl" type="checkbox" value="<%= showBaseUrl %>"/>
	</aui:fieldset>
	
	<aui:fieldset label="popup">
		<aui:input name="popupWidth" type="text" value="<%= popupWidth %>"/>
		<aui:input name="popupHeight" type="text" value="<%= popupHeight %>"/>
	</aui:fieldset>
	
	<aui:fieldset label="filters">
		<aui:input name="enableFilters" type="checkbox" value="<%= enableFilters %>"/>
	</aui:fieldset>
	
	<aui:button-row>
		<aui:button type="submit" value="save" />
	</aui:button-row>
</form>