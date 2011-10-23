<%
/**
 * Copyright (c) 2000-2011 Mika Koivisto. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */
%>
<%@ page import="javax.portlet.PortletSession" %>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %>

<portlet:defineObjects />

<portlet:resourceURL var="jsonURL" id="json" />

<%
Integer count = (Integer)portletSession.getAttribute("count");

if (count == null) {
	count = 0;
}
%>
<p>Count: <span id="<portlet:namespace />count"><%= count %></span></p>

<form>
	<input type="button" id="<portlet:namespace />incrementBtn" value="Increment" />
</form>

<aui:script use="io">
	A.one("#<portlet:namespace />incrementBtn").on("click", function(e) {
		e.preventDefault();

		<portlet:namespace />incrementCounter();
	});

	var <portlet:namespace />incrementCounter = function() {
		A.io(
			'<%= jsonURL %>',
			{
				on: {
					success: <portlet:namespace />processResponse
				}
			}
		);
	};

	var <portlet:namespace />processResponse = function(id, obj) {
			var response = A.JSON.parse(obj.responseText);
			var countSpan = A.one("#<portlet:namespace />count");
			countSpan.text(response.count);
	};
</aui:script>