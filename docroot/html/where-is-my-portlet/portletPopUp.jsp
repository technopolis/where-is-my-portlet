<%@page import="gr.open.admin.portlet.views.PortletView"%>
<%@page import="com.liferay.portal.kernel.xml.QName"%>
<%@page import="com.liferay.portal.model.PublicRenderParameter"%>
<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>
<%@ include file="/html/init.jsp" %>

<%
String popupPortletId = ParamUtil.getString(renderRequest, "portletId");
Portlet popupPortlet = PortletLocalServiceUtil.getPortletById(themeDisplay.getCompanyId(), popupPortletId);
long portletPlid = PortalUtil.getPlidFromPortletId(themeDisplay.getScopeGroupId(), popupPortlet.getPortletId());
String portletBarName = WhereIsMyPortletUtil.getPortletTitleBarName(themeDisplay, popupPortlet.getPortletId(), popupPortlet.getDisplayName());
PortletView portletView = new PortletView(popupPortlet);
%>

<div id="<portlet:namespace/>details">
	<h4 class="header aui-toggler-header-expanded"><span>Information</span></h4>
	<div class="content aui-toggler-content-expanded">
		<liferay-ui:message key="portletId"/>: <%= popupPortlet.getPortletId() %>
		<br><liferay-ui:message key="pluginId"/>: <%= popupPortlet.getPluginId()%>
		<br><liferay-ui:message key="portletPlid"/>: <%= portletPlid %>
		<br><liferay-ui:message key="pluginType"/>: <%= popupPortlet.getPluginType() %>
		<br><liferay-ui:message key="rootPortletId"/>: <%= popupPortlet.getRootPortletId() %>
		<br><liferay-ui:message key="instanceId"/>: <%= popupPortlet.getInstanceId() %>
		<br><liferay-ui:message key="firendlyUrlMapping"/>: <%= popupPortlet.getFriendlyURLMapping() %>
		<br><liferay-ui:message key="portletInstanceId"/>: <%= popupPortlet.getInstanceId()%>
		
		<liferay-ui:message key="instanciable"/>: <img src="<%= request.getContextPath()%>/images/<%= popupPortlet.getInstanceable()%>.png"/>
		<br><liferay-ui:message key="instanceId"/>: <%=popupPortlet.getInstanceId() %>
		<br><liferay-ui:message key="system"/>: <img src="<%= request.getContextPath()%>/images/<%= popupPortlet.getSystem() %>.png"/>
	</div>
	
	<h4 class="header aui-toggler-header-collapsed"><span>Preferences</span></h4>
	<div class="content aui-toggler-content-collapsed">
		<liferay-ui:message key="preferencesUniquePerLayout"/>: <img src="<%= request.getContextPath()%>/images/<%= popupPortlet.getPreferencesUniquePerLayout()%>.png"/>
		<br><liferay-ui:message key="preferencesCompanyWide"/>: <img src="<%= request.getContextPath()%>/images/<%= popupPortlet.getPreferencesCompanyWide()%>.png"/>
		<br><liferay-ui:message key="preferencesOwnedByGroup"/>: <img src="<%= request.getContextPath()%>/images/<%= popupPortlet.getPreferencesOwnedByGroup()%>.png"/>
		<br><ul>
			<%
				for (com.liferay.portal.model.PortletPreferences portletPreference : portletView.getPortletPreferences(themeDisplay.getScopeGroupId())) {
					%>
						<li><%= HtmlUtil.escape(portletPreference.getPreferences()) %></li>
					<%
				}
			%>
		</ul>
	</div>
	
	<h4 class="header aui-toggler-header-collapsed"><span>Events</span></h4>
	<div class="content aui-toggler-content-collapsed">
		<liferay-ui:message key="publishingEventsAmount"/>: <%= popupPortlet.getPublishingEvents().size() %>
		<br><ul>
			<%
				for (QName eventQname : popupPortlet.getPublishingEvents()) {
					%>
						<li><%= eventQname%></li>
					<%
				}
			%>
		</ul>
		<br><liferay-ui:message key="proccessingEventsAmount"/>: <%= popupPortlet.getProcessingEvents().size() %>
		<br><ul>
			<%
				for (QName eventQname : popupPortlet.getProcessingEvents()) {
					%>
						<li><%= eventQname%></li>
					<%
				}
			%>
		</ul>
	</div>
	
	<h4 class="header aui-toggler-header-collapsed"><span>Render Parameters</span></h4>
	<div class="content aui-toggler-content-collapsed">
		<liferay-ui:message key="renderParametersAmount"/>: <%= popupPortlet.getPublicRenderParameters().size() %>
		<br><ul>
			<%
				for (PublicRenderParameter parameter : popupPortlet.getPublicRenderParameters()) {
					%>
						<li><%=parameter.getIdentifier() %> (<%= parameter.getQName()%>)</li>
					<%
				}
			%>
		</ul>
	</div>
	
	<h4 class="header aui-toggler-header-collapsed"><span>Custom Fields</span></h4>
	<div class="content aui-toggler-content-collapsed">
		<liferay-ui:message key="expandoAttributesAmount"/>: <%= popupPortlet.getExpandoBridge().getAttributes().size() %>
		<br><liferay-ui:message key="expandoAttributesAndValues"/>: 
		<br><table>
			<%
				for (String attributeName : popupPortlet.getExpandoBridge().getAttributes().keySet()) {
					String attributeValue = popupPortlet.getExpandoBridge().getAttributes().get(attributeName).toString();
					%>
					<tr>
						<td><%=attributeName %></td><td><%= attributeValue%></td>
					</tr>
					<%
				}
			%>
		</table>
	</div>
</div>

<script>
AUI().use(
  'aui-toggler',
  function(A) {
    new A.TogglerDelegate(
      {
        animated: true,
        closeAllOnExpand: true,
        container: '#<portlet:namespace/>details',
        content: '.content',
        expanded: false,
        header: '.header',
        transition: {
          duration: 0.2,
          easing: 'cubic-bezier'
        }
      }
    );
  }
);
</script>

