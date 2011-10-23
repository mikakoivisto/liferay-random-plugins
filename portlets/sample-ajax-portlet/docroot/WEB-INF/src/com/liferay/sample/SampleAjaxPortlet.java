/**
 * Copyright (c) 2011 Mika Koivisto. All rights reserved.
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

package com.liferay.sample;

import java.io.IOException;
import java.io.PrintWriter;

import javax.portlet.PortletException;
import javax.portlet.PortletSession;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.util.bridges.mvc.MVCPortlet;

/**
 * @author Mika Koivisto
 */
public class SampleAjaxPortlet extends MVCPortlet {

	@Override
	public void serveResource(
			ResourceRequest request, ResourceResponse response)
		throws PortletException, IOException {

		String resourceId = request.getResourceID();

		PortletSession session = request.getPortletSession();

		Integer count = (Integer) session.getAttribute("count");

		if (count == null) {
			count = 0;
		}

		count++;

		session.setAttribute("count", count);

		if (resourceId.equals("json")) {
			JSONObject jsonObject = JSONFactoryUtil.createJSONObject();

			jsonObject.put("count", count);

			PrintWriter writer = response.getWriter();

			writer.write(jsonObject.toString());
		}
	}

}
